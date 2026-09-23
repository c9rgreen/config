-- timew.cli — run Timewarrior, read what it prints, and watch its data.
--
-- Every call goes through vim.system with an argument list, never a shell, so
-- tags with spaces need no escaping. The :nocolor and :yes hints make output
-- plain and stop `confirmation = on` from waiting for an answer nobody can
-- give. Intervals are addressed by @id, which Timewarrior renumbers after
-- every write (@1 is the latest), so views refresh after each change rather
-- than reusing ids they read before it.
--
-- Dates in the export are the same UTC form Taskwarrior uses, so the
-- conversion and the shell-like splitting come from task.cli.

local tcli = require('task.cli')

local M = {}

M.split = tcli.split
M.epoch = tcli.epoch

-- The database directory: the configured one, TIMEWARRIORDB, the legacy
-- ~/.timewarrior, or the XDG data directory, in the order timew looks.
function M.db()
   local db = require('timew').config.db
   if db then
      return vim.fn.expand(db)
   end
   if vim.env.TIMEWARRIORDB then
      return vim.env.TIMEWARRIORDB
   end
   local legacy = vim.fn.expand('~/.timewarrior')
   if vim.uv.fs_stat(legacy) then
      return legacy
   end
   return vim.fs.joinpath(vim.env.XDG_DATA_HOME or vim.fn.expand('~/.local/share'), 'timewarrior')
end

local function build(args)
   local cmd = { 'timew' }
   vim.list_extend(cmd, args)
   vim.list_extend(cmd, { ':nocolor', ':yes' })
   local db = require('timew').config.db
   return cmd, { text = true, stdin = false, env = db and { TIMEWARRIORDB = vim.fn.expand(db) } or nil }
end

function M.message(res)
   return vim.trim((res.stdout or '') .. '\n' .. (res.stderr or ''))
end

-- A few refusals ("Cannot modify interval @2 where start is after end.")
-- exit 0, so the message is checked as well as the code.
function M.failed(res)
   return res.code ~= 0 or M.message(res):match('^Cannot ') ~= nil
end

-- Run `timew <args>` and call `cb(res)` on the main loop.
function M.run(args, cb)
   local cmd, opts = build(args)
   vim.system(cmd, opts, function(res)
      vim.schedule(function() cb(res) end)
   end)
end

local function decode(s)
   local ok, v = pcall(vim.json.decode, s, { luanil = { object = true, array = true } })
   return ok and v or nil
end

-- `timew export <args>`, calling `cb(intervals)` or `cb(nil, message)`.
-- Intervals come oldest first; each gets `from` and `to` as epoch seconds,
-- `to` being nil while the interval is still open.
function M.export(args, cb)
   M.run(vim.list_extend({ 'export' }, args), function(res)
      if res.code ~= 0 then
         return cb(nil, M.message(res))
      end
      local list = decode(res.stdout)
      if type(list) ~= 'table' then
         return cb(nil, 'Could not parse timew export')
      end
      for _, iv in ipairs(list) do
         iv.tags = iv.tags or {}
         iv.from, iv.to = M.epoch(iv.start), M.epoch(iv['end'])
      end
      cb(list)
   end)
end

-- The open interval, or nil when nothing is tracked (timew then refuses
-- the DOM reference, which is not an error here).
function M.active(cb)
   M.run({ 'get', 'dom.active.json' }, function(res)
      local iv = res.code == 0 and decode(res.stdout) or nil
      if type(iv) ~= 'table' then
         return cb(nil)
      end
      iv.tags = iv.tags or {}
      iv.from = M.epoch(iv.start)
      cb(iv)
   end)
end

-- Every tag in use, from tags.data, which timew keeps as JSON with a count
-- per tag. Read directly: `timew get dom.tags` joins tags with spaces, which
-- loses the boundaries of tags like "Fix the thing".
function M.tags()
   local path = vim.fs.joinpath(M.db(), 'data', 'tags.data')
   local ok, lines = pcall(vim.fn.readfile, path)
   local data = ok and decode(table.concat(lines, '\n')) or nil
   local tags = {}
   for tag, info in pairs(type(data) == 'table' and data or {}) do
      if type(info) ~= 'table' or (info.count or 1) > 0 then
         tags[#tags + 1] = tag
      end
   end
   table.sort(tags)
   return tags
end

-- Tags as they would be typed, quoting any with spaces.
function M.quote(tag)
   return tag:find('%s') and ('"' .. tag .. '"') or tag
end

function M.format_tags(tags)
   return table.concat(vim.tbl_map(M.quote, tags or {}), ' ')
end

-- Local time in a form timew reads back as input.
function M.iso(t)
   return os.date('%Y-%m-%dT%H:%M:%S', t)
end

-- Seconds as H:MM.
function M.duration(secs)
   local m = math.floor(math.max(0, secs) / 60)
   return ('%d:%02d'):format(math.floor(m / 60), m % 60)
end

-- Watching the database ------------------------------------------------------
--
-- Anything that writes the data directory (the shell, the Taskwarrior hook)
-- notifies the subscribers. timew only writes when something changes, but
-- a write touches several files, so events are debounced and compared with a
-- signature of every file's mtime. Changes made from Neovim record the new
-- signature first, so they are not reported twice.

local subscribers = {}
local watcher = {}

local function signature()
   local dir = vim.fs.joinpath(M.db(), 'data')
   local parts = {}
   for name in vim.fs.dir(dir) do
      local st = vim.uv.fs_stat(vim.fs.joinpath(dir, name))
      if st then
         parts[#parts + 1] = name .. '=' .. st.mtime.sec .. '.' .. st.mtime.nsec
      end
   end
   table.sort(parts)
   return table.concat(parts, ' ')
end

local function notify_all()
   for _, fn in ipairs(subscribers) do
      fn()
   end
end

local function watch()
   if watcher.handle then
      return
   end
   local dir = vim.fs.joinpath(M.db(), 'data')
   if not vim.uv.fs_stat(dir) then
      return
   end
   local handle, timer = vim.uv.new_fs_event(), vim.uv.new_timer()
   local ok = handle:start(dir, {}, function()
      timer:stop()
      timer:start(300, 0, vim.schedule_wrap(function()
         local sig = signature()
         if sig ~= watcher.sig then
            watcher.sig = sig
            notify_all()
         end
      end))
   end)
   if not ok then
      handle:close()
      timer:close()
      return
   end
   watcher.handle, watcher.timer, watcher.sig = handle, timer, signature()
end

-- Call `fn` whenever the data changes, from Neovim or elsewhere.
function M.subscribe(fn)
   subscribers[#subscribers + 1] = fn
   if require('timew').config.watch then
      watch()
   end
end

-- Report a change made from Neovim.
function M.changed()
   if watcher.handle then
      watcher.sig = signature()
   elseif require('timew').config.watch then
      watch()
   end
   notify_all()
end

return M
