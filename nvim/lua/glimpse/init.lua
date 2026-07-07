-- glimpse — inline images and mermaid diagrams for the terminal.
--
-- Markdown buffers are scanned for image links (![alt](path), ![[path]]) and
-- ```mermaid fences; each is rendered as a block of virtual lines below its
-- source via the kitty graphics protocol (see glimpse/kitty.lua). Opening an
-- image file directly shows it in the buffer as well.
--
-- Commands: :Glimpse [toggle|enable|disable|refresh]

local kitty = require('glimpse.kitty')
local mermaid = require('glimpse.mermaid')

local M = {}

M.config = {
   filetypes = { 'markdown' },
   max_width = 80,  -- cells; also capped by the window's text width
   max_height = 24, -- cells
   mermaid = {
      cmd = 'mmdc',
      theme = 'auto', -- 'auto' follows 'background'; or a mermaid theme name
      scale = 2,      -- render at 2x and display at half size for crisp text
      zoom = 3,     -- display size multiplier on top of the natural size
      max_width = 100, -- cells; wider than images so zoom isn't clamped away
      max_height = 30,
   },
}

local ns = vim.api.nvim_create_namespace('glimpse')
local cache_dir = vim.fs.joinpath(vim.fn.stdpath('cache'), 'glimpse')

local bufs = {}   -- buf -> { enabled, gen, timer, static }
local images = {} -- key:size -> { id, sent } (per size, so windows of
                  -- different widths don't retransmit back and forth)
local next_id = 1

local IMG_EXT = {
   png = true, jpg = true, jpeg = true, gif = true, webp = true,
   bmp = true, tiff = true, tif = true, heic = true, svg = true,
}

-- ── scanning ──────────────────────────────────────────────────────────────

local function resolve_path(buf, raw)
   raw = vim.trim(raw):gsub('%%(%x%x)', function(h)
      return string.char(tonumber(h, 16))
   end)
   if raw == '' or raw:match('^%a[%w+.-]*://') then
      return nil
   end
   if not IMG_EXT[(raw:match('%.(%w+)$') or ''):lower()] then
      return nil
   end
   local candidates
   if raw:sub(1, 1) == '/' or raw:sub(1, 1) == '~' then
      candidates = { vim.fs.normalize(raw) }
   else
      local name = vim.api.nvim_buf_get_name(buf)
      local dir = name ~= '' and vim.fs.dirname(name) or vim.fn.getcwd()
      candidates = { vim.fs.joinpath(dir, raw), vim.fs.joinpath(vim.fn.getcwd(), raw) }
   end
   for _, p in ipairs(candidates) do
      p = vim.fn.fnamemodify(p, ':p')
      if vim.uv.fs_stat(p) then
         return p
      end
   end
end

local function image_key(path)
   local stat = vim.uv.fs_stat(path)
   return 'f:' .. path .. ':' .. (stat and stat.mtime.sec or 0)
end

-- Markdown link targets: strip <angle brackets> or a trailing "title".
local function link_target(target)
   local bracketed = target:match('^%s*<(.-)>')
   if bracketed then
      return bracketed
   end
   return (target:gsub('%s+["\'].-["\']%s*$', ''))
end

local function scan(buf)
   local items = {}
   local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
   local theme = mermaid.theme(M.config.mermaid.theme)
   local i = 1
   while i <= #lines do
      if lines[i]:match('^%s*```+%s*mermaid%s*$') then
         local src, close = {}, nil
         for j = i + 1, #lines do
            if lines[j]:match('^%s*```') then
               close = j
               break
            end
            src[#src + 1] = lines[j]
         end
         if close and #src > 0 then
            local source = table.concat(src, '\n')
            items[#items + 1] = {
               kind = 'mermaid',
               src = source,
               key = 'm:' .. mermaid.key(source, theme),
               theme = theme,
               row = close - 1,
            }
            i = close
         end
      elseif lines[i]:match('^%s*```') then
         -- Skip other fenced code blocks so example image links inside them
         -- aren't rendered. An unclosed fence (mid-edit) is not treated as a
         -- fence, matching the mermaid branch above.
         for j = i + 1, #lines do
            if lines[j]:match('^%s*```') then
               i = j
               break
            end
         end
      else
         local function add(raw)
            local path = resolve_path(buf, raw)
            if path then
               items[#items + 1] = { kind = 'image', path = path, key = image_key(path), row = i - 1 }
            end
         end
         for target in lines[i]:gmatch('!%[[^%]]*%]%(([^%)]+)%)') do
            add(link_target(target))
         end
         for target in lines[i]:gmatch('!%[%[([^%]|]+)') do
            add(target)
         end
      end
      i = i + 1
   end
   return items
end

-- ── rendering ─────────────────────────────────────────────────────────────

local function png_size(path)
   local f = io.open(path, 'rb')
   if not f then
      return nil
   end
   local head = f:read(24)
   f:close()
   if not head or #head < 24 or head:sub(2, 4) ~= 'PNG' then
      return nil
   end
   local function u32(o)
      return head:byte(o) * 0x1000000 + head:byte(o + 1) * 0x10000
         + head:byte(o + 2) * 0x100 + head:byte(o + 3)
   end
   return u32(17), u32(21)
end

-- Convert non-PNG images to a cached PNG (the protocol's only file format).
local function to_png(path, cb)
   if path:lower():match('%.png$') then
      return cb(path)
   end
   local out = vim.fs.joinpath(cache_dir, 'img-' .. vim.fn.sha256(image_key(path)) .. '.png')
   if vim.uv.fs_stat(out) then
      return cb(out)
   end
   vim.fn.mkdir(cache_dir, 'p')
   local cmd
   if vim.fn.executable('magick') == 1 then
      cmd = { 'magick', path .. '[0]', out } -- [0]: first frame of gifs
   elseif vim.fn.executable('sips') == 1 then
      cmd = { 'sips', '-s', 'format', 'png', path, '--out', out }
   else
      return cb(nil, 'no image converter found (needs magick or sips)')
   end
   vim.system(cmd, { text = true }, function(res)
      if res.code == 0 and vim.uv.fs_stat(out) then
         cb(out)
      else
         cb(nil, vim.trim(res.stderr or ''):match('[^\n]+') or ('convert failed (' .. res.code .. ')'))
      end
   end)
end

-- cb(png|nil, err|nil, density) — density divides pixel size when computing
-- the cell box, so 2x-rendered mermaid PNGs display at their intended size.
local function resolve_png(item, cb)
   if item.kind == 'mermaid' then
      local opts = { cmd = M.config.mermaid.cmd, theme = item.theme, scale = M.config.mermaid.scale }
      mermaid.render(item.key:sub(3), item.src, opts, function(png, err)
         cb(png, err, M.config.mermaid.scale / M.config.mermaid.zoom)
      end)
   else
      to_png(item.path, function(png, err)
         cb(png, err, 1)
      end)
   end
end

local function avail_cols(buf, max_width)
   local width = vim.o.columns
   local win = vim.fn.bufwinid(buf)
   if win ~= -1 then
      local info = vim.fn.getwininfo(win)[1]
      width = info.width - info.textoff
   end
   return math.max(1, math.min(max_width, width - 1, kitty.MAX_CELLS))
end

-- Fit px_w×px_h pixels into a cell box, preserving aspect ratio.
local function fit(px_w, px_h, max_cols, max_rows)
   local cw, ch = kitty.cell_size()
   local cols = math.max(1, math.min(max_cols, math.ceil(px_w / cw)))
   local rows = math.max(1, math.ceil(cols * cw * px_h / px_w / ch))
   if rows > max_rows then
      rows = max_rows
      cols = math.max(1, math.floor(rows * ch * px_w / px_h / cw))
   end
   return cols, math.min(rows, kitty.MAX_CELLS)
end

local function set_virt_lines(buf, mark, row, lines)
   vim.api.nvim_buf_set_extmark(buf, ns, row, 0, { id = mark, virt_lines = lines })
end

local function place(buf, item, gen)
   local loading = item.kind == 'mermaid' and '· rendering diagram…' or '· loading image…'
   local mark = vim.api.nvim_buf_set_extmark(buf, ns, item.row, 0, {
      virt_lines = { { { loading, 'Comment' } } },
   })
   resolve_png(item, function(png, err, density)
      vim.schedule(function()
         local b = bufs[buf]
         if not vim.api.nvim_buf_is_valid(buf) or not b or b.gen ~= gen then
            return
         end
         -- The extmark tracked any edits made while rendering; follow it.
         local pos = vim.api.nvim_buf_get_extmark_by_id(buf, ns, mark, {})
         if #pos == 0 then
            return
         end
         if not png then
            return set_virt_lines(buf, mark, pos[1], {
               { { '⚠ ' .. (err or 'render failed'), 'DiagnosticVirtualTextError' } },
            })
         end
         local px_w, px_h = png_size(png)
         if not px_w or px_w == 0 or px_h == 0 then
            return set_virt_lines(buf, mark, pos[1], {
               { { '⚠ unreadable PNG: ' .. png, 'DiagnosticVirtualTextError' } },
            })
         end
         local is_mermaid = item.kind == 'mermaid'
         local cols, rows = fit(
            px_w / density, px_h / density,
            avail_cols(buf, is_mermaid and M.config.mermaid.max_width or M.config.max_width),
            is_mermaid and M.config.mermaid.max_height or M.config.max_height
         )
         local size_key = item.key .. ':' .. cols .. 'x' .. rows
         local img = images[size_key]
         if not img then
            img = { id = next_id }
            next_id = next_id + 1
            images[size_key] = img
         end
         if not img.sent then
            if not kitty.transmit(img.id, png, rows, cols) then
               return set_virt_lines(buf, mark, pos[1], {
                  { { '⚠ cannot read ' .. png, 'DiagnosticVirtualTextError' } },
               })
            end
            img.sent = true
         end
         set_virt_lines(buf, mark, pos[1], kitty.placeholder_lines(img.id, rows, cols))
      end)
   end)
end

function M.render(buf)
   buf = buf or vim.api.nvim_get_current_buf()
   local b = bufs[buf]
   if not b or not b.enabled or not vim.api.nvim_buf_is_valid(buf) then
      return
   end
   b.gen = b.gen + 1
   vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
   for _, item in ipairs(b.static and { b.static } or scan(buf)) do
      place(buf, item, b.gen)
   end
end

local function render_all()
   for buf in pairs(bufs) do
      M.render(buf)
   end
end

-- ── attach / detach ───────────────────────────────────────────────────────

local warned
local function terminal_ok()
   if kitty.supported() and vim.o.termguicolors then
      return true
   end
   if not warned then
      warned = true
      vim.notify('glimpse: needs a kitty-graphics terminal and termguicolors', vim.log.levels.WARN)
   end
   return false
end

local function debounce(buf)
   local b = bufs[buf]
   b.timer = b.timer or vim.uv.new_timer()
   b.timer:stop()
   b.timer:start(250, 0, vim.schedule_wrap(function()
      M.render(buf)
   end))
end

function M.attach(buf, static)
   buf = buf or vim.api.nvim_get_current_buf()
   if bufs[buf] then
      bufs[buf].enabled = true
      return M.render(buf)
   end
   if not terminal_ok() then
      return
   end
   bufs[buf] = { enabled = true, gen = 0, static = static }
   local group = vim.api.nvim_create_augroup('glimpse.buf.' .. buf, { clear = true })
   if not static then
      vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'BufWritePost' }, {
         group = group,
         buffer = buf,
         callback = function()
            debounce(buf)
         end,
      })
   end
   vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
      group = group,
      buffer = buf,
      once = true,
      callback = function()
         if bufs[buf] and bufs[buf].timer then
            bufs[buf].timer:close()
         end
         bufs[buf] = nil
         pcall(vim.api.nvim_del_augroup_by_id, group)
      end,
   })
   M.render(buf)
end

function M.disable(buf)
   buf = buf or vim.api.nvim_get_current_buf()
   local b = bufs[buf]
   if b then
      b.enabled = false
      b.gen = b.gen + 1
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
   end
end

function M.toggle(buf)
   buf = buf or vim.api.nvim_get_current_buf()
   if bufs[buf] and bufs[buf].enabled then
      M.disable(buf)
   else
      M.attach(buf)
   end
end

-- Drop caches and re-render everything from scratch.
function M.refresh()
   mermaid.clear_failures()
   for _, img in pairs(images) do
      img.sent = false
   end
   render_all()
end

-- Buffers holding an image file directly: replace the (binary) content with
-- the path and render the image below it.
local function image_buffer(buf, file)
   local path = vim.fn.fnamemodify(file, ':p')
   vim.bo[buf].swapfile = false
   vim.bo[buf].undolevels = -1
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, { path })
   vim.bo[buf].modified = false
   vim.bo[buf].modifiable = false
   vim.bo[buf].buftype = 'nowrite'
   M.attach(buf, { kind = 'image', path = path, key = image_key(path), row = 0 })
end

-- ── setup ─────────────────────────────────────────────────────────────────

function M.setup(opts)
   M.config = vim.tbl_deep_extend('force', M.config, opts or {})

   local group = vim.api.nvim_create_augroup('glimpse', { clear = true })
   local function au(event, o)
      o.group = group
      vim.api.nvim_create_autocmd(event, o)
   end

   au('FileType', {
      pattern = M.config.filetypes,
      callback = function(ev)
         M.attach(ev.buf)
      end,
   })
   au('BufReadCmd', {
      pattern = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.bmp' },
      callback = function(ev)
         image_buffer(ev.buf, ev.match)
      end,
   })
   -- Colorschemes wipe the id-encoding highlight groups; recreate them after
   -- the new scheme has applied.
   au('ColorScheme', {
      callback = function()
         vim.schedule(kitty.apply_highlights)
      end,
   })
   -- Mermaid's theme may flip with 'background'.
   au('OptionSet', {
      pattern = 'background',
      callback = render_all,
   })
   -- The terminal forgets transmitted images while Neovim is suspended, and
   -- cell pixel size changes with font/window size.
   au('VimResume', {
      callback = function()
         for _, img in pairs(images) do
            img.sent = false
         end
         render_all()
      end,
   })
   au('VimResized', {
      callback = function()
         kitty.cell_size(true)
         render_all()
      end,
   })
   au('VimLeavePre', {
      callback = function()
         for _, img in pairs(images) do
            kitty.delete(img.id)
         end
      end,
   })

   vim.api.nvim_create_user_command('Glimpse', function(cmd)
      local action = cmd.fargs[1] or 'toggle'
      if action == 'refresh' then
         M.refresh()
      elseif action == 'enable' then
         M.attach()
      elseif action == 'disable' then
         M.disable()
      else
         M.toggle()
      end
   end, {
      nargs = '?',
      complete = function()
         return { 'toggle', 'enable', 'disable', 'refresh' }
      end,
      desc = 'Inline images and mermaid diagrams',
   })

   -- Prune cache entries untouched for 30 days. Keys embed mtime/content
   -- hashes, so every source edit strands the previous entry; a pruned file
   -- that is still referenced is simply re-rendered on demand.
   vim.defer_fn(function()
      if not vim.uv.fs_stat(cache_dir) then
         return
      end
      local cutoff = os.time() - 30 * 86400
      for name in vim.fs.dir(cache_dir) do
         local path = vim.fs.joinpath(cache_dir, name)
         local stat = vim.uv.fs_stat(path)
         if stat and stat.mtime.sec < cutoff then
            vim.uv.fs_unlink(path)
         end
      end
   end, 1000)

   -- Pick up buffers that existed before setup (e.g. config reload).
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf)
         and vim.list_contains(M.config.filetypes, vim.bo[buf].filetype)
      then
         M.attach(buf)
      end
   end
end

return M
