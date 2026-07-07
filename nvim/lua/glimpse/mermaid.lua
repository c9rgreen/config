-- Render mermaid sources to PNG with mermaid-cli (mmdc), cached on disk by
-- content+theme hash so a diagram is only rendered once per edit.

local M = {}

local cache_dir = vim.fs.joinpath(vim.fn.stdpath('cache'), 'glimpse')

-- Failed renders (e.g. syntax errors mid-edit) are remembered in memory so
-- every rescan doesn't relaunch a doomed mmdc/puppeteer run.
local failures = {}
local pending = {}

function M.clear_failures()
   failures = {}
end

function M.theme(configured)
   if configured ~= 'auto' then
      return configured
   end
   return vim.o.background == 'dark' and 'dark' or 'default'
end

function M.key(src, theme)
   return vim.fn.sha256(theme .. '\0' .. src)
end

-- cb(png_path|nil, err|nil) — called from the mmdc exit callback (fast path
-- for cache hits calls it synchronously).
function M.render(key, src, opts, cb)
   local out = vim.fs.joinpath(cache_dir, 'mermaid-' .. key .. '.png')
   if vim.uv.fs_stat(out) then
      return cb(out)
   end
   if failures[key] then
      return cb(nil, failures[key])
   end
   if vim.fn.executable(opts.cmd) ~= 1 then
      return cb(nil, ('%s not found (npm install -g @mermaid-js/mermaid-cli)'):format(opts.cmd))
   end
   if pending[key] then
      table.insert(pending[key], cb)
      return
   end
   pending[key] = { cb }

   vim.fn.mkdir(cache_dir, 'p')
   local src_file = out:gsub('%.png$', '.mmd')
   local f = io.open(src_file, 'w')
   if not f then
      pending[key] = nil
      return cb(nil, 'cannot write ' .. src_file)
   end
   f:write(src)
   f:close()

   vim.system({
      opts.cmd,
      '--quiet',
      '--input', src_file,
      '--output', out,
      '--backgroundColor', 'transparent',
      '--theme', opts.theme,
      '--scale', tostring(opts.scale),
   }, { text = true }, function(res)
      local cbs = pending[key]
      pending[key] = nil
      vim.uv.fs_unlink(src_file) -- only needed while mmdc runs
      local png, err
      if res.code == 0 and vim.uv.fs_stat(out) then
         png = out
      else
         local msg = vim.trim((res.stderr and res.stderr ~= '') and res.stderr or (res.stdout or ''))
         -- mmdc errors are noisy; keep the first informative line
         msg = msg:match('[^\n]*[Ee]rror[^\n]*') or msg:match('[^\n]+') or ''
         err = msg ~= '' and msg:sub(1, 160) or ('mmdc exited with code ' .. res.code)
         failures[key] = err
      end
      for _, callback in ipairs(cbs) do
         callback(png, err)
      end
   end)
end

return M
