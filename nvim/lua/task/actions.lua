-- task.actions — changes made to tasks, shared by the report buffer, the
-- detail float and the picker. Each takes a list of tasks as exported (so
-- toggles can read the current state) and refreshes every open report once
-- Taskwarrior has finished.

local cli = require('task.cli')

local M = {}

local function uuids(tasks)
   return vim.tbl_map(function(t) return t.uuid end, tasks)
end

local function cmd(tasks, ...)
   return vim.list_extend(uuids(tasks), { ... })
end

local function notify(msg, level)
   vim.notify(msg, level or vim.log.levels.INFO, { title = 'task' })
end

local function finish(res, focus)
   if res and res.code ~= 0 then
      notify(cli.message(res), vim.log.levels.ERROR)
   end
   cli.invalidate()
   local view = require('task.view')
   view.note_write()
   view.refresh_all({ focus = focus })
end

-- Run commands one after another and refresh once at the end, stopping at
-- the first failure.
local function sequence(cmds, focus)
   local i = 0
   local function step(res)
      if res and res.code ~= 0 then
         return finish(res)
      end
      i = i + 1
      if i > #cmds then
         return finish(nil, focus)
      end
      cli.run(cmds[i], step)
   end
   step()
end

local function plural(tasks)
   return #tasks == 1 and ("'" .. tasks[1].description .. "'") or (#tasks .. ' tasks')
end

function M.done(tasks)
   sequence({ cmd(tasks, 'done') })
end

function M.delete(tasks)
   if vim.fn.confirm('Delete ' .. plural(tasks) .. '?', '&Yes\n&No', 2) == 1 then
      sequence({ cmd(tasks, 'delete') })
   end
end

-- Stop the started tasks and start the rest. With Taskwarrior's on-modify
-- Timewarrior hook installed, this also starts and stops tracking.
function M.toggle(tasks)
   local started = vim.tbl_filter(function(t) return t.start ~= nil end, tasks)
   local stopped = vim.tbl_filter(function(t) return t.start == nil end, tasks)
   local cmds = {}
   if #started > 0 then
      cmds[#cmds + 1] = cmd(started, 'stop')
   end
   if #stopped > 0 then
      cmds[#cmds + 1] = cmd(stopped, 'start')
   end
   sequence(cmds)
end

local LEVELS = { '', 'L', 'M', 'H' }
local RANK = { [''] = 1, L = 2, M = 3, H = 4 }

-- Move each task's priority one step up (1) or down (-1), none being lowest.
function M.priority(tasks, step)
   local by_level = {}
   for _, t in ipairs(tasks) do
      local rank = RANK[t.priority or ''] or 1
      local level = LEVELS[math.min(4, math.max(1, rank + step))]
      if level ~= (t.priority or '') then
         by_level[level] = by_level[level] or {}
         table.insert(by_level[level], t)
      end
   end
   local cmds = {}
   for level, group in pairs(by_level) do
      cmds[#cmds + 1] = cmd(group, 'modify', 'priority:' .. level)
   end
   if #cmds > 0 then
      sequence(cmds)
   end
end

function M.annotate(tasks)
   vim.ui.input({ prompt = 'Annotate ' .. plural(tasks) .. ': ' }, function(text)
      if text and vim.trim(text) ~= '' then
         sequence({ cmd(tasks, 'annotate', text) })
      end
   end)
end

-- Set or clear the due date. With one task the prompt starts from its
-- current date; an empty answer removes the date. Tab completes
-- Taskwarrior's date keywords (tomorrow, eow, friday and so on).
function M.due(tasks)
   local current = (#tasks == 1 and tasks[1].due) and cli.iso(tasks[1].due) or ''
   vim.ui.input({
      prompt = 'Due ' .. plural(tasks) .. ' (empty clears): ',
      default = current,
      completion = "customlist,v:lua.require'task'.complete_date",
   }, function(value)
      if not value then
         return
      end
      value = vim.trim(value)
      local any_due = vim.iter(tasks):any(function(t) return t.due ~= nil end)
      if (value ~= '' and value == current) or (value == '' and not any_due) then
         return notify('No changes')
      end
      sequence({ cmd(tasks, 'modify', 'due:' .. value) })
   end)
end

-- Choose a project from the ones in use, fuzzy-matched with mini.pick when
-- it is there. The current project is named in the prompt rather than
-- listed, so a query never lands back on it. "New project" asks for a name
-- (starting from the current one, so adding ".sub" is quick) and "No
-- project" clears it.
local NEW = { label = 'New project…' }
local NONE = { label = 'No project' }

function M.project(tasks)
   local current = #tasks == 1 and tasks[1].project or nil
   local items = {}
   for _, p in ipairs(cli.projects()) do
      if p ~= current then
         items[#items + 1] = p
      end
   end
   items[#items + 1] = NEW
   if vim.iter(tasks):any(function(t) return t.project ~= nil end) then
      items[#items + 1] = NONE
   end

   local function set(project)
      if vim.iter(tasks):all(function(t) return (t.project or '') == project end) then
         return notify('No changes')
      end
      sequence({ cmd(tasks, 'modify', 'project:' .. project) })
   end

   local ok, pick = pcall(require, 'mini.pick')
   local select = ok and pick.ui_select or vim.ui.select
   select(items, {
      prompt = 'Project for ' .. plural(tasks) .. (current and (' (now ' .. current .. ')') or ''),
      format_item = function(item) return type(item) == 'table' and item.label or item end,
   }, function(choice)
      if choice == NEW then
         vim.ui.input({
            prompt = 'New project: ',
            default = current or '',
            completion = "customlist,v:lua.require'task'.complete_project",
         }, function(name)
            name = name and vim.trim(name)
            if name and name ~= '' then
               set(name)
            end
         end)
      elseif choice == NONE then
         set('')
      elseif choice then
         set(choice)
      end
   end)
end

-- A float over most of the editor, sized as broot's is.
local function float_config(title)
   local cols, lines = vim.o.columns, vim.o.lines - vim.o.cmdheight
   local width = math.max(math.min(cols - 4, math.max(math.floor(cols * 0.9), 40)), 1)
   local height = math.max(math.min(lines - 4, math.max(math.floor(lines * 0.85), 10)), 1)
   return {
      relative = 'editor',
      width = width,
      height = height,
      col = math.max(math.floor((cols - width) / 2), 0),
      row = math.max(math.floor((lines - height) / 2) - 1, 0),
      style = 'minimal',
      title = title,
      title_pos = 'center',
   }
end

-- Run `task edit` on one task in a floating terminal. Taskwarrior opens
-- rc.editor, $VISUAL or $EDITOR on the task and applies the file when the
-- editor quits. The float then closes and the reports refresh. If
-- Taskwarrior fails, the float stays open so its message can be read; q
-- closes it.
function M.edit(tasks)
   if #tasks ~= 1 then
      return notify('Edit one task at a time', vim.log.levels.WARN)
   end
   local t = tasks[1]
   local rc = cli.taskrc()
   local prev_win = vim.api.nvim_get_current_win()
   local buf = vim.api.nvim_create_buf(false, true)
   local title = ' task edit: ' .. t.description:gsub('[\r\n]+', ' ') .. ' '
   local win = vim.api.nvim_open_win(buf, true, float_config(title))
   vim.wo[win].winhighlight = 'NormalFloat:Normal'
   local augroup = vim.api.nvim_create_augroup('task.edit.' .. buf, { clear = true })

   local function close()
      pcall(vim.api.nvim_del_augroup_by_id, augroup)
      if vim.api.nvim_win_is_valid(win) then
         vim.api.nvim_win_close(win, true)
      end
      if vim.api.nvim_buf_is_valid(buf) then
         vim.api.nvim_buf_delete(buf, { force = true })
      end
      if vim.api.nvim_win_is_valid(prev_win) then
         vim.api.nvim_set_current_win(prev_win)
      end
   end

   local job = vim.fn.jobstart({ 'task', t.uuid, 'edit' }, {
      term = true,
      env = rc and { TASKRC = vim.fn.expand(rc) } or nil,
      on_exit = function(_, code)
         vim.schedule(function()
            if code == 0 then
               close()
            else
               notify('task edit failed; press q to close it', vim.log.levels.ERROR)
               vim.keymap.set('n', 'q', close, { buffer = buf, nowait = true })
            end
            finish(nil, t.uuid)
         end)
      end,
   })
   if job <= 0 then
      close()
      return notify('Could not start task edit', vim.log.levels.ERROR)
   end

   -- Closing the float some other way ends the editor too.
   vim.api.nvim_create_autocmd('WinClosed', {
      group = augroup,
      pattern = tostring(win),
      once = true,
      callback = function() vim.fn.jobstop(job) end,
   })
   vim.api.nvim_create_autocmd('VimResized', {
      group = augroup,
      callback = function()
         if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, float_config(title))
         end
      end,
   })
   vim.cmd.startinsert()
end

function M.undo()
   sequence({ { 'undo' } })
end

-- The attributes the modify prompt shows, in the order it shows them.
local EDITABLE = { 'project', 'priority', 'due', 'scheduled', 'wait', 'until', 'recur' }
local DATES = { due = true, scheduled = true, wait = true, ['until'] = true }

local function editable(t)
   local f = {}
   for _, k in ipairs(EDITABLE) do
      if t[k] then
         f[k] = DATES[k] and cli.iso(t[k]) or t[k]
      end
   end
   return f
end

local function quote(v)
   return v:find('%s') and ('"' .. v .. '"') or v
end

-- The modify prompt for one task: its description, then its attributes and
-- tags as Taskwarrior input.
local function prefill(t)
   local parts = { t.description }
   local f = editable(t)
   for _, k in ipairs(EDITABLE) do
      if f[k] then
         parts[#parts + 1] = k .. ':' .. quote(f[k])
      end
   end
   for _, tag in ipairs(t.tags or {}) do
      parts[#parts + 1] = '+' .. tag
   end
   return table.concat(parts, ' ')
end

-- Turn an edited prompt back into modify arguments by comparing it with the
-- task. A token naming a known attribute is that attribute, +word and -word
-- are tags, and the remaining words are the description. An attribute or tag
-- deleted from the prompt is removed from the task, which a plain modify
-- with the edited text would not do.
local function diff(t, line)
   local known = { description = true, depends = true }
   for _, k in ipairs(EDITABLE) do
      known[k] = true
   end
   for _, k in ipairs(cli.udas()) do
      known[k] = true
   end

   -- Taskwarrior accepts an unambiguous prefix of an attribute name (pro:).
   local function resolve(k)
      if known[k] then
         return k
      end
      local match
      for name in pairs(known) do
         if #k >= 2 and vim.startswith(name, k) then
            if match then
               return nil
            end
            match = name
         end
      end
      return match
   end

   local words, attrs, tags, extra = {}, {}, {}, {}
   for _, tok in ipairs(cli.split(line)) do
      local k, v = tok:match('^([%w_]+):(.*)$')
      k = k and resolve(k)
      if k then
         attrs[k] = v
      elseif tok:match('^%+%S') then
         tags[tok:sub(2)] = true
      elseif tok:match('^%-[^%s%d]') then
         extra[#extra + 1] = tok
      else
         words[#words + 1] = tok
      end
   end

   local args = {}
   local desc = attrs.description or table.concat(words, ' ')
   attrs.description = nil
   if desc ~= '' and desc ~= table.concat(cli.split(t.description), ' ') then
      args[#args + 1] = 'description:' .. desc
   end

   local old = editable(t)
   for k, v in pairs(attrs) do
      if v ~= tostring(old[k] or t[k] or '') then
         args[#args + 1] = k .. ':' .. v
      end
   end
   for k in pairs(old) do
      if attrs[k] == nil then
         args[#args + 1] = k .. ':'
      end
   end

   local had = {}
   for _, tag in ipairs(t.tags or {}) do
      had[tag] = true
      if not tags[tag] then
         args[#args + 1] = '-' .. tag
      end
   end
   for tag in pairs(tags) do
      if not had[tag] then
         args[#args + 1] = '+' .. tag
      end
   end
   return vim.list_extend(args, extra)
end

-- One task: edit it in a prompt holding its current state. Several: type
-- modifications to apply to all of them.
function M.modify(tasks)
   if #tasks == 1 then
      local t = tasks[1]
      vim.ui.input({ prompt = 'Modify: ', default = prefill(t) }, function(line)
         if not line then
            return
         end
         local args = diff(t, line)
         if #args == 0 then
            return notify('No changes')
         end
         sequence({ cmd(tasks, 'modify', unpack(args)) })
      end)
   else
      vim.ui.input({ prompt = 'Modify ' .. #tasks .. ' tasks: ' }, function(line)
         if line and vim.trim(line) ~= '' then
            sequence({ cmd(tasks, 'modify', unpack(cli.split(line))) })
         end
      end)
   end
end

-- Add a task from a line of Taskwarrior input. The new task's UUID comes
-- back so the report cursor can land on it.
function M.add_line(line, opts)
   opts = opts or {}
   local args = cli.split(line)
   if #args == 0 then
      return
   end
   cli.run(vim.list_extend({ 'rc.verbose=new-uuid', 'add' }, args), function(res)
      if res.code ~= 0 then
         return finish(res)
      end
      local uuid = res.stdout:match('(%x+%-%x+%-%x+%-%x+%-%x+)')
      if opts.notify then
         notify('Added: ' .. line)
      end
      finish(nil, uuid)
   end)
end

local ADD_COMPLETION = "customlist,v:lua.require'task'.complete_input"

-- Prompt for a new task, starting from `default` (such as "project:web ").
function M.add(default)
   vim.ui.input({ prompt = 'Add: ', default = default, completion = ADD_COMPLETION }, function(line)
      if line then
         M.add_line(line)
      end
   end)
end

-- The quick add: type the description (attributes and tags are allowed
-- too) and the task goes into `project`. The project comes first, so a
-- project: typed in the prompt still wins.
function M.quick_add(project)
   local prompt = project and ('New task in ' .. project .. ': ') or 'New task: '
   vim.ui.input({ prompt = prompt, completion = ADD_COMPLETION }, function(line)
      if line and vim.trim(line) ~= '' then
         M.add_line((project and ('project:' .. project .. ' ') or '') .. line)
      end
   end)
end

-- The task's GitLab page, or else the first link in its annotations.
function M.url(t)
   if t.gitlaburl and t.gitlaburl ~= '' then
      return t.gitlaburl
   end
   for _, a in ipairs(t.annotations or {}) do
      local url = a.description:match('https?://[^%s>)]+')
      if url then
         return url
      end
   end
end

function M.open_url(t)
   local url = M.url(t)
   if not url then
      return notify('No link on this task', vim.log.levels.WARN)
   end
   vim.ui.open(url)
end

-- Pick one of the actions above for a set of tasks, for the picker's marks.
function M.choose(tasks)
   local choices = {
      { 'Done', M.done },
      { 'Start / stop', M.toggle },
      { 'Raise priority', function(ts) M.priority(ts, 1) end },
      { 'Lower priority', function(ts) M.priority(ts, -1) end },
      { 'Set due date', M.due },
      { 'Set project', M.project },
      { 'Modify', M.modify },
      { 'Edit in $EDITOR', M.edit },
      { 'Annotate', M.annotate },
      { 'Delete', M.delete },
   }
   vim.ui.select(choices, {
      prompt = plural(tasks),
      format_item = function(c) return c[1] end,
   }, function(choice)
      if choice then
         choice[2](tasks)
      end
   end)
end

return M
