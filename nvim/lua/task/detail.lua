-- task.detail — one task in a float, written as markdown: its attributes,
-- its GitLab fields when bugwarrior synced it, its annotations, and the
-- GitLab issue description. The same lines serve the picker's preview.

local cli = require('task.cli')
local actions = require('task.actions')

local M = {}

local function date(s)
   local t = cli.epoch(s)
   if not t then
      return nil
   end
   local fmt = os.date('%H:%M', t) == '00:00' and '%a %Y-%m-%d' or '%a %Y-%m-%d %H:%M'
   return ('%s (%s)'):format(os.date(fmt, t), cli.relative(s))
end

local DATES = {
   { 'due', 'Due' }, { 'scheduled', 'Scheduled' }, { 'wait', 'Wait' }, { 'until', 'Until' },
   { 'start', 'Started' }, { 'entry', 'Entered' }, { 'modified', 'Modified' }, { 'end', 'Ended' },
}

local GITLAB = {
   { 'gitlabtype', 'Type' }, { 'gitlabstate', 'State' }, { 'gitlabauthor', 'Author' },
   { 'gitlabassignee', 'Assignee' }, { 'gitlabmilestone', 'Milestone' }, { 'gitlaburl', 'URL' },
}

function M.lines(t)
   local lines = { '# ' .. t.description:gsub('[\r\n]+', ' '), '' }
   local function field(label, value)
      if value ~= nil and value ~= '' then
         lines[#lines + 1] = ('- **%s** %s'):format(label, tostring(value))
      end
   end

   field('ID', t.id ~= 0 and t.id or nil)
   field('Status', t.status)
   field('Project', t.project)
   field('Priority', t.priority)
   field('Tags', t.tags and table.concat(vim.tbl_map(function(tag) return '+' .. tag end, t.tags), ' '))
   for _, d in ipairs(DATES) do
      field(d[2], date(t[d[1]]))
   end
   field('Recur', t.recur)
   field('Depends', t.depends and (#t.depends .. ' tasks'))
   field('Urgency', t.urgency and ('%.2f'):format(t.urgency))
   field('UUID', '`' .. t.uuid .. '`')

   if t.gitlabrepo or t.gitlaburl then
      local title = vim.trim(('GitLab %s%s'):format(t.gitlabrepo or '', t.gitlabnumber and (' #' .. t.gitlabnumber) or ''))
      vim.list_extend(lines, { '', '## ' .. title, '' })
      for _, g in ipairs(GITLAB) do
         field(g[2], t[g[1]])
      end
   end

   if t.annotations and #t.annotations > 0 then
      vim.list_extend(lines, { '', '## Annotations', '' })
      for _, a in ipairs(t.annotations) do
         local when = cli.epoch(a.entry)
         local text = a.description:gsub('[\r\n]+', ' ')
         lines[#lines + 1] = ('- *%s* %s'):format(when and os.date('%Y-%m-%d', when) or '', text)
      end
   end

   if t.gitlabdescription and vim.trim(t.gitlabdescription) ~= '' then
      vim.list_extend(lines, { '', '## Description', '' })
      vim.list_extend(lines, vim.split(t.gitlabdescription:gsub('\r', ''), '\n'))
   end
   return lines
end

-- Screen rows the lines take when wrapped at `width`.
local function wrapped_height(lines, width)
   local rows = 0
   for _, l in ipairs(lines) do
      rows = rows + math.max(1, math.ceil(vim.fn.strdisplaywidth(l) / width))
   end
   return rows
end

local function show(t)
   local lines = M.lines(t)
   local buf = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   vim.bo[buf].modifiable = false
   vim.bo[buf].bufhidden = 'wipe'
   vim.bo[buf].filetype = 'markdown'

   local width = math.min(88, vim.o.columns - 8)
   local height = math.min(wrapped_height(lines, width), vim.o.lines - 6)
   local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      row = math.floor((vim.o.lines - height) / 2) - 1,
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = height,
      style = 'minimal',
      title = t.id ~= 0 and (' Task ' .. t.id .. ' ') or ' Task ',
      title_pos = 'center',
   })
   vim.wo[win].wrap = true
   vim.wo[win].linebreak = true
   vim.wo[win].conceallevel = 2

   local function close()
      if vim.api.nvim_win_is_valid(win) then
         vim.api.nvim_win_close(win, true)
      end
   end
   local function map(lhs, fn, desc)
      vim.keymap.set('n', lhs, fn, { buffer = buf, desc = desc, nowait = true })
   end
   -- Act on the task from the float: close it first, so the prompt and the
   -- refresh happen in the report underneath.
   local function act(fn)
      return function()
         close()
         fn({ t })
      end
   end
   map('q', close, 'Close')
   map('<Esc>', close, 'Close')
   map('gx', function() actions.open_url(t) end, 'Open link')
   map('d', act(actions.done), 'Mark done')
   map('s', act(actions.toggle), 'Start or stop')
   map('D', act(actions.due), 'Set due date')
   map('P', act(actions.project), 'Set project')
   map('m', act(actions.modify), 'Modify')
   map('e', act(actions.edit), 'Edit in $EDITOR')
   map('A', act(actions.annotate), 'Annotate')
   map('x', act(actions.delete), 'Delete')
   vim.api.nvim_create_autocmd('WinLeave', { buffer = buf, once = true, callback = close })
end

-- Show the task with this UUID, read fresh from Taskwarrior.
function M.open(uuid)
   cli.export({ uuid }, nil, function(tasks, err)
      if not tasks or not tasks[1] then
         return vim.notify(err or 'Task not found', vim.log.levels.ERROR, { title = 'task' })
      end
      show(tasks[1])
   end)
end

return M
