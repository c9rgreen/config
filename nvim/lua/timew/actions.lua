-- timew.actions — changes to tracked time, shared by the interval view, the
-- picker and :Timew. Intervals are passed as exported, and every action
-- ends by reporting the change, which refreshes open views and the
-- statusline.

local cli = require('timew.cli')

local M = {}

local function notify(msg, level)
   vim.notify(msg, level or vim.log.levels.INFO, { title = 'timew' })
end

local function ids(intervals)
   local out, seen = {}, {}
   for _, iv in ipairs(intervals) do
      if not seen[iv.id] then
         seen[iv.id] = true
         out[#out + 1] = '@' .. iv.id
      end
   end
   return out
end

-- Run commands one after another, stopping at the first failure, then report
-- the change once. With `opts.notify`, the last command's output is shown
-- (for :Timew start and friends, where it is the only feedback).
function M.sequence(cmds, opts)
   opts = opts or {}
   local i = 0
   local function step(res)
      if res and cli.failed(res) then
         notify(cli.message(res), vim.log.levels.ERROR)
         return cli.changed()
      end
      i = i + 1
      if i > #cmds then
         if opts.notify and res and cli.message(res) ~= '' then
            notify(cli.message(res))
         end
         return cli.changed()
      end
      cli.run(cmds[i], step)
   end
   step()
end

local function run(args, opts)
   M.sequence({ args }, opts)
end

-- Prompts --------------------------------------------------------------------

local TAG_COMPLETION = "customlist,v:lua.require'timew'.complete_tags"

-- Ask for tags, as they are typed at the shell ("Two words" one). Calls
-- `cb(tags, line)` unless the prompt is cancelled.
function M.ask_tags(prompt, default, cb)
   vim.ui.input({ prompt = prompt, default = default, completion = TAG_COMPLETION }, function(line)
      if line then
         cb(cli.split(line), line)
      end
   end)
end

local function describe(intervals)
   local n = #ids(intervals)
   if n > 1 then
      return n .. ' intervals'
   end
   local tags = cli.format_tags(intervals[1].tags)
   return tags ~= '' and tags or ('@' .. intervals[1].id)
end

-- Tracking -----------------------------------------------------------------

function M.start(tags, opts)
   run(vim.list_extend({ 'start' }, tags), opts)
end

-- Prompt for tags and start tracking them now.
function M.start_new()
   M.ask_tags('Start: ', '', function(tags) M.start(tags) end)
end

function M.stop(opts)
   run({ 'stop' }, opts)
end

function M.continue(iv, opts)
   run({ 'continue', '@' .. iv.id }, opts)
end

-- Stop when this is the open interval, otherwise start its tags now.
function M.toggle(iv)
   if not iv.to then
      M.stop()
   else
      M.start(iv.tags)
   end
end

function M.cancel(opts)
   run({ 'cancel' }, opts)
end

-- Record `tags` for the span between two epoch times.
function M.track(from, to, tags)
   run(vim.list_extend({ 'track', cli.iso(from), '-', cli.iso(to) }, tags))
end

function M.undo(opts)
   run({ 'undo' }, opts)
end

-- Editing ------------------------------------------------------------------

function M.tag(intervals)
   M.ask_tags('Add tags to ' .. describe(intervals) .. ': ', '', function(tags)
      if #tags > 0 then
         run(vim.list_extend(vim.list_extend({ 'tag' }, ids(intervals)), tags))
      end
   end)
end

-- Replace one interval's tags, starting from the current ones. An empty
-- answer removes them all (retag refuses an empty list).
function M.retag(iv)
   local current = cli.format_tags(iv.tags)
   M.ask_tags('Tags: ', current, function(tags, line)
      if vim.trim(line) == current then
         return notify('No changes')
      elseif #tags == 0 then
         if #iv.tags > 0 then
            run(vim.list_extend({ 'untag', '@' .. iv.id }, iv.tags))
         end
      else
         run(vim.list_extend({ 'retag', '@' .. iv.id }, tags))
      end
   end)
end

-- Set or clear the annotation. With one interval the prompt starts from
-- its current annotation; an empty answer removes it.
function M.annotate(intervals)
   local current = #ids(intervals) == 1 and intervals[1].annotation or ''
   vim.ui.input({ prompt = 'Annotate ' .. describe(intervals) .. ' (empty clears): ', default = current }, function(text)
      if not text then
         return
      end
      text = vim.trim(text)
      if text == current then
         return notify('No changes')
      end
      run(vim.list_extend(vim.list_extend({ 'annotate' }, ids(intervals)), { text }))
   end)
end

function M.delete(intervals)
   if vim.fn.confirm('Delete ' .. describe(intervals) .. '?', '&Yes\n&No', 2) == 1 then
      run(vim.list_extend({ 'delete' }, ids(intervals)))
   end
end

function M.lengthen(intervals)
   run(vim.list_extend(vim.list_extend({ 'lengthen' }, ids(intervals)), { require('timew').config.step }))
end

function M.shorten(intervals)
   run(vim.list_extend(vim.list_extend({ 'shorten' }, ids(intervals)), { require('timew').config.step }))
end

function M.split(intervals)
   run(vim.list_extend({ 'split' }, ids(intervals)))
end

-- Join an interval with the one after it (ids count back from the latest,
-- so the next interval is the id below).
function M.join_next(iv)
   if iv.id <= 1 then
      return notify('No later interval to join', vim.log.levels.WARN)
   end
   run({ 'join', '@' .. iv.id, '@' .. (iv.id - 1) })
end

-- A time typed in the modify prompt: HH:MM on the day it had before, or a
-- full date and time.
local function read_time(s, base)
   s = vim.trim(s or '')
   local h, m = s:match('^(%d%d?):(%d%d)$')
   if h then
      local d = os.date('*t', base)
      return os.time({ year = d.year, month = d.month, day = d.day, hour = tonumber(h), min = tonumber(m) })
   end
   local y, mo, d, hh, mm = s:match('^(%d%d%d%d)%-(%d%d)%-(%d%d)[T ](%d%d?):(%d%d)$')
   if y then
      return os.time({ year = tonumber(y), month = tonumber(mo), day = tonumber(d), hour = tonumber(hh), min = tonumber(mm) })
   end
end

-- Edit start and end as `HH:MM - HH:MM`, times on the days they already
-- fall on unless a date is typed. Only the start of the open interval can
-- move.
function M.modify(iv)
   local function show(t)
      return os.date(os.date('%Y%m%d', t) == os.date('%Y%m%d', iv.from) and '%H:%M' or '%Y-%m-%d %H:%M', t)
   end
   local default = os.date('%H:%M', iv.from) .. (iv.to and (' - ' .. show(iv.to)) or '')
   vim.ui.input({ prompt = iv.to and 'Start - end: ' or 'Start: ', default = default }, function(line)
      if not line then
         return
      end
      local a, b = line:match('^%s*(.-)%s+%-%s+(.-)%s*$')
      a = a or line
      local from = read_time(a, iv.from)
      local to = iv.to and read_time(b, iv.to)
      if not from or (iv.to and not to) then
         return notify('Expected HH:MM' .. (iv.to and ' - HH:MM' or '') .. ', or YYYY-MM-DD HH:MM', vim.log.levels.WARN)
      end
      -- The prompt holds minutes, so seconds already on the interval are
      -- not a change.
      local same_from = math.floor(from / 60) == math.floor(iv.from / 60)
      local same_to = not iv.to or math.floor(to / 60) == math.floor(iv.to / 60)
      if same_from and same_to then
         return notify('No changes')
      elseif not iv.to then
         run({ 'modify', 'start', '@' .. iv.id, cli.iso(from) })
      else
         run({ 'modify', 'range', '@' .. iv.id, cli.iso(same_from and iv.from or from), '-', cli.iso(same_to and iv.to or to) })
      end
   end)
end

-- Taskwarrior ----------------------------------------------------------------

-- The task an interval was tracked for. The on-modify hook tags intervals
-- with the task's description, project and tags, so a tag equal to a task's
-- description finds it. Tags are tried in order; the first match wins.
function M.open_task(iv)
   local tags = vim.deepcopy(iv.tags)
   local tcli = require('task.cli')
   local function try()
      local tag = table.remove(tags, 1)
      if not tag then
         return notify('No task matches these tags', vim.log.levels.WARN)
      end
      tcli.export({ 'description.is:' .. tag }, nil, function(tasks)
         if tasks and tasks[1] then
            return require('task.detail').open(tasks[1].uuid)
         end
         try()
      end)
   end
   try()
end

return M
