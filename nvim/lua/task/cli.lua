-- task.cli — run Taskwarrior and read what it prints.
--
-- Every call goes through vim.system with an argument list, never a shell, so
-- descriptions need no escaping. The overrides below make output stable no
-- matter what the user's taskrc says: no color, no chatter, JSON as a single
-- array, and no interactive prompts (the plugin asks its own questions).
-- Tasks are always addressed by UUID, since IDs shift when Taskwarrior
-- renumbers the working set.

local M = {}

local OVERRIDES = {
   'rc.color=off',
   'rc.verbose=nothing',
   'rc.json.array=on',
   'rc.confirmation=off',
   'rc.bulk=0',
   'rc.recurrence.confirmation=no',
}

-- The taskrc to run with, from the user's config (a path or a function).
function M.taskrc()
   local rc = require('task').config.taskrc
   if type(rc) == 'function' then
      rc = rc()
   end
   return rc
end

local function build(args)
   local cmd = { 'task' }
   vim.list_extend(cmd, OVERRIDES)
   vim.list_extend(cmd, args)
   local rc = M.taskrc()
   return cmd, { text = true, env = rc and { TASKRC = vim.fn.expand(rc) } or nil }
end

-- What Taskwarrior said, stdout and stderr together. Error messages such as
-- "Task 4 not started." arrive on stdout.
function M.message(res)
   return vim.trim((res.stdout or '') .. '\n' .. (res.stderr or ''))
end

-- Run `task <args>` and call `cb(res)` on the main loop.
function M.run(args, cb)
   local cmd, opts = build(args)
   vim.system(cmd, opts, function(res)
      vim.schedule(function() cb(res) end)
   end)
end

-- Run synchronously and return stdout lines, or {} on failure. For
-- completion, which has to answer before the cmdline redraws.
function M.lines(args)
   local cmd, opts = build(args)
   local ok, res = pcall(function() return vim.system(cmd, opts):wait(2000) end)
   if not ok or res.code ~= 0 then
      return {}
   end
   return vim.split(vim.trim(res.stdout), '\n', { trimempty = true })
end

-- `task <filter> export [report]`. With a report name, Taskwarrior applies
-- that report's filter and sort order too. Calls `cb(tasks)` or
-- `cb(nil, message)`.
function M.export(filter, report, cb)
   local args = vim.list_extend({}, filter)
   args[#args + 1] = 'export'
   if report then
      args[#args + 1] = report
   end
   M.run(args, function(res)
      if res.code ~= 0 then
         return cb(nil, M.message(res))
      end
      local ok, tasks = pcall(vim.json.decode, res.stdout, { luanil = { object = true, array = true } })
      if not ok or type(tasks) ~= 'table' then
         return cb(nil, 'Could not parse task export')
      end
      cb(tasks)
   end)
end

-- Split a line the way a shell would, so `project:x +tag due:fri` becomes
-- three arguments (Taskwarrior does not re-split a single argument). Quotes
-- group words only at the start of a word or right after a colon, so the
-- apostrophe in "Bob's" stays literal.
function M.split(s)
   local args, cur, quote, quoted = {}, {}, nil, false
   local function flush()
      if #cur > 0 or quoted then
         args[#args + 1] = table.concat(cur)
      end
      cur, quoted = {}, false
   end
   for ch in s:gmatch('.') do
      if quote then
         if ch == quote then
            quote = nil
         else
            cur[#cur + 1] = ch
         end
      elseif (ch == '"' or ch == "'") and (#cur == 0 or cur[#cur] == ':') then
         quote, quoted = ch, true
      elseif ch:match('%s') then
         flush()
      else
         cur[#cur + 1] = ch
      end
   end
   flush()
   return args
end

-- Taskwarrior dates (20260930T230000Z) as epoch seconds. Computed from the
-- civil date directly, because os.time reads its fields as local time.
function M.epoch(s)
   local y, mo, d, h, mi, se = (s or ''):match('^(%d%d%d%d)(%d%d)(%d%d)T(%d%d)(%d%d)(%d%d)Z$')
   if not y then
      return nil
   end
   y, mo, d = tonumber(y), tonumber(mo), tonumber(d)
   y = mo <= 2 and y - 1 or y
   local era = math.floor(y / 400)
   local yoe = y - era * 400
   local doy = math.floor((153 * ((mo + 9) % 12) + 2) / 5) + d - 1
   local doe = yoe * 365 + math.floor(yoe / 4) - math.floor(yoe / 100) + doy
   local days = era * 146097 + doe - 719468
   return days * 86400 + tonumber(h) * 3600 + tonumber(mi) * 60 + tonumber(se)
end

-- A date in local time that Taskwarrior accepts back as input: the day
-- alone at midnight, otherwise day and minute.
function M.iso(s)
   local t = M.epoch(s)
   if not t then
      return nil
   end
   local fmt = os.date('%H:%M', t) == '00:00' and '%Y-%m-%d' or '%Y-%m-%dT%H:%M'
   return os.date(fmt, t)
end

-- Compact distance from now, negative in the past: 3h, 2d, -1w, 4mo.
function M.relative(s)
   local t = M.epoch(s)
   if not t then
      return nil
   end
   local secs = t - os.time()
   local a, sign = math.abs(secs), secs < 0 and '-' or ''
   local units = {
      { 'y', 365 * 86400, 365 * 86400 },
      { 'mo', 30 * 86400, 60 * 86400 },
      { 'w', 7 * 86400, 14 * 86400 },
      { 'd', 86400, 86400 },
      { 'h', 3600, 3600 },
   }
   for _, u in ipairs(units) do
      if a >= u[3] then
         return sign .. math.floor(a / u[2]) .. u[1]
      end
   end
   return sign .. math.max(1, math.floor(a / 60)) .. 'min'
end

-- Completion candidates, cached briefly so typing stays responsive.
local cache = {}
function M.cached(key, args, filter)
   local hit = cache[key]
   if hit and vim.uv.now() - hit.at < 10000 then
      return hit.value
   end
   local value = M.lines(args)
   if filter then
      value = vim.tbl_filter(filter, value)
   end
   cache[key] = { at = vim.uv.now(), value = value }
   return value
end

function M.projects()
   return M.cached('projects', { '_projects' })
end

-- Real tags only. The all-caps names are Taskwarrior's virtual tags.
function M.tags()
   return M.cached('tags', { '_tags' }, function(t) return t ~= t:upper() end)
end

function M.reports()
   return M.cached('reports', { '_config' }, nil)
end

function M.report_names()
   local names = {}
   for _, key in ipairs(M.reports()) do
      local name = key:match('^report%.(.+)%.columns$')
      if name then
         names[#names + 1] = name
      end
   end
   table.sort(names)
   return names
end

function M.udas()
   return M.cached('udas', { '_udas' })
end

function M.invalidate()
   cache = {}
end

return M
