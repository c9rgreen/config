-- glimpse — inline images and mermaid diagrams for the terminal.
--
-- Markdown buffers are scanned for image links (![alt](path), ![[path]]) and
-- ```mermaid fences; each is rendered as a block of virtual lines below its
-- source: empty lines hold open the space and the image is drawn on top of
-- them (see glimpse/kitty.lua). Opening an
-- image file directly shows it in the buffer as well.
--
-- Commands: :Glimpse [toggle|enable|disable|refresh]
-- Buffer variables: set b:glimpse_base_dir to say which folder relative image
-- links start from, for buffers that are not backed by a real file.

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
local ns_paint = vim.api.nvim_create_namespace('glimpse.paint')
local cache_dir = vim.fs.joinpath(vim.fn.stdpath('cache'), 'glimpse')

local bufs = {}   -- buf -> { enabled, gen, timer, static }
local images = {} -- item key -> { id, sent }; not tied to a size, so a window
                  -- of a different width reuses the same image
local marks = {}  -- buf -> mark -> { id, rows, cols, px_w, px_h }
local next_id = 1

-- Turn a buffer argument into a real buffer number. `bufs` and `marks` are
-- keyed by real numbers, so the 0 that Neovim's own functions accept for "the
-- current buffer" has to be swapped out here. `buf or ...` will not do it,
-- because 0 counts as true in Lua.
local function resolve_buf(buf)
   if not buf or buf == 0 then
      return vim.api.nvim_get_current_buf()
   end
   return buf
end

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
      -- Buffers that are not backed by a real file (an old git revision, say)
      -- can set b:glimpse_base_dir to say which folder relative links start
      -- from.
      local dir = vim.b[buf].glimpse_base_dir
      if not dir or dir == '' then
         local name = vim.api.nvim_buf_get_name(buf)
         dir = name ~= '' and vim.fs.dirname(name) or vim.fn.getcwd()
      end
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

-- Every window showing the buffer shares one set of added lines, so a block
-- can only be one size. Take the widest that fits the narrowest window, or it
-- spills out of that one and over its neighbour.
local function avail_cols(buf, max_width)
   local width
   for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_buf(win) == buf then
         local info = vim.fn.getwininfo(win)[1]
         if info then
            local w = info.width - info.textoff
            width = width and math.min(width, w) or w
         end
      end
   end
   return math.max(1, math.min(max_width, (width or vim.o.columns) - 1))
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
   return cols, rows
end

local function set_virt_lines(buf, mark, row, lines)
   vim.api.nvim_buf_set_extmark(buf, ns, row, 0, { id = mark, virt_lines = lines })
end

-- Empty lines that hold open the space an image is drawn over. The image
-- covers them, so they only have to be the right shape.
local function reserve_lines(rows, cols)
   local blank = string.rep(' ', cols)
   local lines = {}
   for r = 1, rows do
      lines[r] = { { blank, 'Normal' } }
   end
   return lines
end

-- ── painting ─────────────────────────────────────────────────────────────
--
-- The terminal draws an image at a fixed spot on the screen, so that spot has
-- to be worked out again whenever anything moves it: scrolling, resizing a
-- window, opening a fold, even an image higher up the buffer changing height.
-- paint() walks every visible window, works out where each held-open space now
-- sits, and sends only the commands needed to bring the terminal in line.

local placed = {} -- pid -> where that image currently sits on screen
local pids = {}   -- win .. ':' .. mark -> id of its on-screen copy
local next_pid = 1

local function pid_for(key)
   if not pids[key] then
      pids[key] = next_pid
      next_pid = next_pid + 1
   end
   return pids[key]
end

-- The terminal throws away every image it is showing when it is reset or when
-- Neovim is suspended, so drop our record of them and let the next paint send
-- them again.
local function forget_placements()
   placed = {}
end

-- A line hidden inside a closed fold shows none of its added lines, because
-- Neovim draws the single fold line in place of the whole range. The functions
-- that report screen positions still answer for that fold line, though, so a
-- block inside a fold has to be spotted and skipped, or it ends up drawn over
-- whatever text comes after the fold.
--
-- Whether a fold is closed depends on the window, so reading it means stepping
-- into that window. paint() asks about every line it cares about at once,
-- since it runs after nearly every redraw and each lookup is slow.
local function fold_probe(win, lnums)
   local closed = {}
   vim.api.nvim_win_call(win, function()
      for _, lnum in ipairs(lnums) do
         closed[lnum] = vim.fn.foldclosed(lnum) ~= -1
      end
   end)
   return closed
end

-- Screen row where the block below buffer row `anchor` starts, or nil when
-- none of it is visible. The answer can be above the top of the window, and
-- the caller trims it: Neovim scrolls through a block one row at a time rather
-- than skipping past it in one jump.
--
-- nvim_win_text_height counts added lines against the row *after* them, so the
-- anchor's own height is all - fill, and screenpos() already points past any
-- added lines above it.
local function block_top(win, buf, anchor, closed, top, rows)
   local lines = vim.api.nvim_buf_line_count(buf)
   -- A mark can sit one row past the end of the buffer until the timer catches
   -- up, which is what replacing a whole buffer (:e!, a formatter, a plugin
   -- reloading its contents) leaves behind. Asking screenpos() about a line
   -- that far out raises an error instead of returning a row.
   if anchor >= lines or closed[anchor + 1] then
      return nil
   end
   local sp = vim.fn.screenpos(win, anchor + 1, 1)
   if sp.row > 0 then
      local h = vim.api.nvim_win_text_height(win, { start_row = anchor, end_row = anchor })
      return sp.row + (h.all - h.fill)
   end
   -- The anchor line has scrolled off the top, but part of its block can still
   -- be visible; the next row's fill count says how much.
   if anchor + 1 < lines then
      if closed[anchor + 2] then
         return nil
      end
      local nxt = vim.fn.screenpos(win, anchor + 2, 1)
      if nxt.row > 0 then
         local h = vim.api.nvim_win_text_height(win, { start_row = anchor + 1, end_row = anchor + 1 })
         return nxt.row - h.fill
      end
      return nil
   end
   -- There is no line after the anchor to carry that count, which is what `zb`
   -- on the last line of the buffer leaves behind: the block sits against the
   -- top of the window, and 'topfill' -- how many of its rows Neovim put above
   -- the first visible row -- is the only thing left to go on.
   local fill = vim.api.nvim_win_call(win, function()
      return vim.fn.winsaveview().topfill
   end)
   if fill and fill > 0 then
      return top - (rows - fill)
   end
   return nil
end

-- Areas the images have to stay out of. Neovim draws floating windows and the
-- completion menu as ordinary text, and images sit on top of text, so an image
-- overlapping one would hide it until something moved. A window's border is
-- not counted in the size it reports, hence the extra cell on each side.
local function occluders()
   local rects = {}
   for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(win).relative ~= '' then
         local info = vim.fn.getwininfo(win)[1]
         if info then
            rects[#rects + 1] = {
               top = info.winrow - 1, bot = info.winrow + info.height,
               left = info.wincol - 1, right = info.wincol + info.width,
            }
         end
      end
   end
   local pum = vim.fn.pum_getpos()
   if pum and pum.row then
      rects[#rects + 1] = {
         top = pum.row + 1, bot = pum.row + pum.height,
         left = pum.col + 1, right = pum.col + pum.width,
      }
   end
   return rects
end

local function paint(force)
   local live = {}
   local rects = occluders()
   -- Only windows in the current tab: a window's position is reported within
   -- its own tab, so one sitting on another tab would otherwise draw its
   -- images over whichever tab is on screen.
   for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)
      local b, mk = bufs[buf], marks[buf]
      local info = (b and b.enabled and mk and next(mk)) and vim.fn.getwininfo(win)[1] or nil
      if info then
         local top = info.winrow + ((vim.wo[win].winbar or '') ~= '' and 1 or 0)
         local bot = top + info.height - 1
         local col = info.wincol + info.textoff
         local text_cols = math.max(1, info.width - info.textoff)
         local lines = vim.api.nvim_buf_line_count(buf)
         -- Collect the anchor rows first, so the fold check below -- the slow
         -- part -- can be done for all of them at once.
         local anchors, lnums = {}, {}
         for mark in pairs(mk) do
            local pos = vim.api.nvim_buf_get_extmark_by_id(buf, ns, mark, {})
            if #pos > 0 then
               anchors[mark] = pos[1]
               for _, lnum in ipairs({ pos[1] + 1, pos[1] + 2 }) do
                  if lnum <= lines then
                     lnums[#lnums + 1] = lnum
                  end
               end
            end
         end
         local closed = fold_probe(win, lnums)
         for mark, m in pairs(mk) do
            local anchor = anchors[mark]
            local row = anchor and block_top(win, buf, anchor, closed, top, m.rows) or nil
            -- Trim to the window here, since the terminal knows nothing about
            -- splits and would happily draw past the edge. The stored width
            -- can also be out of date (a new split, or a second window
            -- narrower than the one the block was sized for), so cap that too.
            local cols = math.min(m.cols, text_cols)
            local vis_top = row and math.max(row, top)
            local vis_bot = row and math.min(row + m.rows - 1, bot)
            if row then
               for _, r in ipairs(rects) do
                  if vis_bot >= vis_top
                     and col <= r.right and col + cols - 1 >= r.left
                     and r.bot >= vis_top and r.top <= vis_bot
                  then
                     if r.top <= vis_top and r.bot >= vis_bot then
                        vis_bot = vis_top - 1        -- covered outright
                     elseif r.top <= vis_top then
                        vis_top = r.bot + 1          -- covered from above
                     elseif r.bot >= vis_bot then
                        vis_bot = r.top - 1          -- covered from below
                     else
                        vis_bot = vis_top - 1        -- covered in the middle
                     end
                  end
               end
            end
            if row and vis_bot >= vis_top then
               local rows = vis_bot - vis_top + 1
               local src
               if rows < m.rows or cols < m.cols then
                  src = {
                     y = math.floor((vis_top - row) * m.px_h / m.rows),
                     h = math.max(1, math.floor(rows * m.px_h / m.rows)),
                     w = math.max(1, math.floor(cols * m.px_w / m.cols)),
                  }
               end
               local pid = pid_for(win .. ':' .. mark)
               local cur, want = placed[pid], {
                  id = m.id, row = vis_top, col = col, rows = rows, cols = cols,
                  y = src and src.y or 0, h = src and src.h or 0, w = src and src.w or 0,
               }
               live[pid] = true
               if force or not vim.deep_equal(cur, want) then
                  if cur then
                     kitty.unput(cur.id, pid)
                  end
                  kitty.put(m.id, pid, vis_top, col, rows, cols, src)
                  placed[pid] = want
               end
            end
         end
      end
   end
   -- Whatever is left lost its window, its buffer or its mark.
   for pid, p in pairs(placed) do
      if not live[pid] then
         kitty.unput(p.id, pid)
         placed[pid] = nil
      end
   end
   for key in pairs(pids) do
      local win = tonumber(key:match('^(%d+):'))
      if win and not vim.api.nvim_win_is_valid(win) then
         pids[key] = nil
      end
   end
end

-- Fold the many redraws of one turn into a single paint.
local paint_pending, paint_force = false, false
local function schedule_paint(force)
   paint_force = paint_force or force == true
   if paint_pending then
      return
   end
   paint_pending = true
   vim.schedule(function()
      local f = paint_force
      paint_pending, paint_force = false, false
      paint(f)
   end)
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
         local img = images[item.key]
         if not img then
            img = { id = next_id }
            next_id = next_id + 1
            images[item.key] = img
         end
         if not img.sent then
            if not kitty.transmit(img.id, png) then
               return set_virt_lines(buf, mark, pos[1], {
                  { { '⚠ cannot read ' .. png, 'DiagnosticVirtualTextError' } },
               })
            end
            img.sent = true
         end
         marks[buf] = marks[buf] or {}
         marks[buf][mark] = { id = img.id, rows = rows, cols = cols, px_w = px_w, px_h = px_h }
         set_virt_lines(buf, mark, pos[1], reserve_lines(rows, cols))
         schedule_paint(true)
      end)
   end)
end

function M.render(buf)
   buf = resolve_buf(buf)
   local b = bufs[buf]
   if not b or not b.enabled or not vim.api.nvim_buf_is_valid(buf) then
      return
   end
   b.gen = b.gen + 1
   vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
   -- Removed, not emptied: place() makes the table again when there is
   -- something to track, and an empty one would keep triggering paints.
   marks[buf] = nil
   for _, item in ipairs(b.static and { b.static } or scan(buf)) do
      place(buf, item, b.gen)
   end
   schedule_paint(true)
end

local function render_all()
   for buf in pairs(bufs) do
      M.render(buf)
   end
end

-- ── attach / detach ───────────────────────────────────────────────────────

-- Images now go straight to the terminal rather than being encoded in text
-- colors, so 'termguicolors' is no longer needed.
local warned
local function terminal_ok()
   local ok, reason = kitty.supported()
   if ok then
      return true
   end
   if not warned then
      warned = true
      vim.notify('glimpse: ' .. (reason or 'terminal cannot display images'), vim.log.levels.WARN)
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
   buf = resolve_buf(buf)
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
         marks[buf] = nil
         schedule_paint(true)
         pcall(vim.api.nvim_del_augroup_by_id, group)
      end,
   })
   M.render(buf)
end

function M.disable(buf)
   buf = resolve_buf(buf)
   local b = bufs[buf]
   if b then
      b.enabled = false
      b.gen = b.gen + 1
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      marks[buf] = nil
      schedule_paint(true)
   end
end

function M.toggle(buf)
   buf = resolve_buf(buf)
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
      kitty.delete(img.id)
      img.sent = false
   end
   forget_placements()
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

   -- There is no event for "the screen changed", and any redraw can move a
   -- block, so hook the end of each redraw. Writing to the terminal from in
   -- there is not allowed, so the paint is queued for just afterwards.
   vim.api.nvim_set_decoration_provider(ns_paint, {
      on_end = function()
         if next(placed) ~= nil or next(marks) ~= nil then
            schedule_paint(false)
         end
      end,
   })

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
         forget_placements()
         render_all()
      end,
   })
   au('VimResized', {
      callback = function()
         kitty.cell_size(true)
         render_all()
      end,
   })
   -- Splitting, closing or dragging a window changes the width a block has to
   -- fit into, so the sizes have to be worked out again. The rendered images
   -- are cached, so this is cheap.
   au({ 'WinResized', 'WinNew', 'WinClosed' }, {
      callback = function()
         for buf, b in pairs(bufs) do
            if b.enabled then
               debounce(buf)
            end
         end
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
