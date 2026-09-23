-- task.view — report buffers.
--
-- A report buffer shows one Taskwarrior report (next by default) narrowed by
-- an optional filter. Tasks keep the report's own order and are grouped by
-- project, each group a fold under its project line; groups come in the
-- order of their first task, so the most urgent project leads. The first
-- cell of a task line shows its urgency as a density (the shading of the
-- diagnostic signs), and priority, due and urgency sit right-aligned in
-- virtual text so descriptions stay in one column.
--
-- Each task line carries an extmark whose id maps to the task's UUID, which
-- is how keys find their task. Re-rendering keeps each window's cursor on
-- the same task and its closed folds closed.
--
-- The buffers refresh after every change made from Neovim, and when
-- anything else (bugwarrior, the shell) writes the task database. A read
-- creates and removes SQLite's -wal and -shm files, so the watcher compares
-- the database file's own mtime rather than trusting the directory events;
-- otherwise every refresh would trigger the next one.

local cli = require('task.cli')
local actions = require('task.actions')

local M = {}

local ns = vim.api.nvim_create_namespace('task.rows')
local ns_hl = vim.api.nvim_create_namespace('task.hl')

-- buf -> { report, filter, gen, marks = {extmark id -> uuid},
--          tasks = {uuid -> task}, headers = {row -> project}, levels }
M.state = {}

-- Urgency thresholds for the density cell.
local DENSITY = { { 15, '█' }, { 10, '▓' }, { 5, '▒' }, { 0.01, '░' } }

local function density(urgency)
   for _, d in ipairs(DENSITY) do
      if urgency >= d[1] then
         return d[2]
      end
   end
   return ' '
end

local function due_group(t)
   local e = cli.epoch(t.due)
   if not e then
      return nil
   end
   local left = e - os.time()
   if left < 0 then
      return 'TaskOverdue'
   elseif left < 2 * 86400 then
      return 'TaskDueSoon'
   end
   return 'TaskDue'
end

function M.foldexpr(lnum)
   local s = M.state[vim.api.nvim_get_current_buf()]
   return s and s.levels[lnum] or '0'
end

function M.uuid_at(buf, row0)
   local s = M.state[buf]
   local marks = vim.api.nvim_buf_get_extmarks(buf, ns, { row0, 0 }, { row0, -1 }, {})
   return s and marks[1] and s.marks[marks[1][1]]
end

local function name_for(report, filter)
   return 'task://' .. report .. (filter ~= '' and (' ' .. filter) or '')
end

-- Remember each window's cursor task and closed project folds.
local function save_views(buf)
   local s = M.state[buf]
   local views = {}
   for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      local row = vim.api.nvim_win_get_cursor(win)[1]
      local v = { row = row, uuid = M.uuid_at(buf, row - 1), header = s.headers[row], closed = {} }
      vim.api.nvim_win_call(win, function()
         for r, project in pairs(s.headers) do
            if vim.fn.foldclosed(r) ~= -1 then
               v.closed[project] = true
            end
         end
      end)
      views[win] = v
   end
   return views
end

local function restore_views(buf, views, focus)
   local s = M.state[buf]
   local rows, header_rows = {}, {}
   for id, uuid in pairs(s.marks) do
      local pos = vim.api.nvim_buf_get_extmark_by_id(buf, ns, id, {})
      rows[uuid] = pos[1] + 1
   end
   for r, project in pairs(s.headers) do
      header_rows[project] = r
   end
   local count = vim.api.nvim_buf_line_count(buf)
   local current = vim.api.nvim_get_current_win()
   for win, v in pairs(views) do
      local row = (win == current and focus and rows[focus])
         or (v.uuid and rows[v.uuid])
         or (v.header and header_rows[v.header])
         or math.min(v.row, count)
      vim.api.nvim_win_call(win, function()
         vim.cmd('normal! zx')
         for r, project in pairs(s.headers) do
            if v.closed[project] then
               vim.cmd(r .. 'foldclose')
            end
         end
      end)
      vim.api.nvim_win_set_cursor(win, { row, 0 })
   end
end

local function render(buf, tasks, err, opts)
   local s = M.state[buf]
   local views = save_views(buf)

   local lines, levels, headers, rows = {}, {}, {}, {}
   if err then
      lines = vim.split('Taskwarrior: ' .. err, '\n')
   elseif #tasks == 0 then
      lines = { 'No matching tasks' }
   else
      local order, groups = {}, {}
      for _, t in ipairs(tasks) do
         local p = t.project or ''
         if not groups[p] then
            groups[p] = {}
            order[#order + 1] = p
         end
         table.insert(groups[p], t)
      end
      for _, p in ipairs(order) do
         lines[#lines + 1] = p == '' and '(no project)' or p
         levels[#lines], headers[#lines] = '>1', p
         for _, t in ipairs(groups[p]) do
            local prefix = '  ' .. density(t.urgency or 0) .. ' '
            local desc = t.description:gsub('[\r\n]+', ' ')
            local tags = (t.tags and #t.tags > 0) and ('  +' .. table.concat(t.tags, ' +')) or ''
            lines[#lines + 1] = prefix .. desc .. tags
            levels[#lines] = '1'
            rows[#rows + 1] = { row = #lines, task = t, prefix = #prefix, desc = #desc }
         end
      end
   end

   vim.bo[buf].modifiable = true
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   vim.bo[buf].modifiable = false
   vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
   vim.api.nvim_buf_clear_namespace(buf, ns_hl, 0, -1)
   s.marks, s.tasks, s.headers, s.levels = {}, {}, headers, levels

   if err or #tasks == 0 then
      vim.api.nvim_buf_set_extmark(buf, ns_hl, 0, 0, {
         end_row = #lines - 1, end_col = #lines[#lines], hl_group = err and 'TaskError' or 'TaskEmpty',
      })
   end

   local counts = {}
   for _, r in ipairs(rows) do
      local p = r.task.project or ''
      counts[p] = (counts[p] or 0) + 1
   end
   for row, p in pairs(headers) do
      local r0 = row - 1
      vim.api.nvim_buf_set_extmark(buf, ns_hl, r0, 0, {
         end_col = #lines[row], hl_group = 'TaskProject',
         virt_text = { { '  ' .. counts[p], 'TaskCount' } },
      })
   end

   for _, r in ipairs(rows) do
      local t, r0 = r.task, r.row - 1
      local virt = {}
      if t.priority then
         vim.list_extend(virt, { { t.priority, 'TaskPriority' .. t.priority }, { '  ' } })
      end
      local rel = cli.relative(t.due)
      if rel then
         vim.list_extend(virt, { { rel, due_group(t) }, { '  ' } })
      end
      virt[#virt + 1] = { ('%5.1f'):format(t.urgency or 0), 'TaskUrgencyValue' }
      local id = vim.api.nvim_buf_set_extmark(buf, ns, r0, 0, {
         virt_text = virt, virt_text_pos = 'right_align',
      })
      s.marks[id], s.tasks[t.uuid] = t.uuid, t

      vim.api.nvim_buf_set_extmark(buf, ns_hl, r0, 2, { end_col = r.prefix - 1, hl_group = 'TaskUrgency' })
      if t.start then
         vim.api.nvim_buf_set_extmark(buf, ns_hl, r0, r.prefix, {
            end_col = r.prefix + r.desc, hl_group = 'TaskActive',
         })
      end
      if #lines[r.row] > r.prefix + r.desc then
         vim.api.nvim_buf_set_extmark(buf, ns_hl, r0, r.prefix + r.desc, {
            end_col = #lines[r.row], hl_group = 'TaskTag',
         })
      end
   end

   restore_views(buf, views, opts and opts.focus)
end

function M.refresh(buf, opts)
   local s = M.state[buf]
   if not s then
      return
   end
   s.gen = s.gen + 1
   local gen = s.gen
   cli.export(cli.split(s.filter), s.report, function(tasks, err)
      -- A newer refresh has been started, or the buffer is gone.
      if M.state[buf] ~= s or s.gen ~= gen or not vim.api.nvim_buf_is_valid(buf) then
         return
      end
      render(buf, tasks, err, opts)
   end)
end

function M.refresh_all(opts)
   for buf in pairs(M.state) do
      M.refresh(buf, opts)
   end
end

-- Watching the task database ------------------------------------------------

local watcher = {}

local function db_mtime()
   local st = watcher.db and vim.uv.fs_stat(watcher.db)
   return st and (st.mtime.sec .. '.' .. st.mtime.nsec)
end

-- Record the database as seen after a write made from Neovim, which
-- refreshes by itself, so the watcher does not refresh a second time.
function M.note_write()
   watcher.mtime = db_mtime()
end

local function unwatch()
   if watcher.handle then
      watcher.handle:close()
      watcher.timer:close()
   end
   watcher = {}
end

function M.watch()
   if watcher.handle or watcher.starting or not require('task').config.watch then
      return
   end
   watcher.starting = true
   cli.run({ '_get', 'rc.data.location' }, function(res)
      watcher.starting = nil
      local dir = res.code == 0 and vim.fs.normalize(vim.trim(res.stdout))
      if not dir or not vim.uv.fs_stat(dir) then
         return
      end
      local handle, timer = vim.uv.new_fs_event(), vim.uv.new_timer()
      local ok = handle:start(dir, {}, function()
         timer:stop()
         timer:start(300, 0, vim.schedule_wrap(function()
            local mtime = db_mtime()
            if mtime and mtime ~= watcher.mtime then
               watcher.mtime = mtime
               cli.invalidate()
               M.refresh_all()
            end
         end))
      end)
      if not ok then
         handle:close()
         timer:close()
         return
      end
      watcher.handle, watcher.timer = handle, timer
      watcher.db = vim.fs.joinpath(dir, 'taskchampion.sqlite3')
      watcher.mtime = db_mtime()
   end)
end

-- Keys ---------------------------------------------------------------------

-- The tasks under the cursor, or on every line of the visual selection.
local function selection(buf)
   local s = M.state[buf]
   local mode = vim.fn.mode()
   local first, last = vim.fn.line('.'), vim.fn.line('.')
   if mode:match('^[vV\22]') then
      first, last = vim.fn.line('v'), vim.fn.line('.')
      if first > last then
         first, last = last, first
      end
      vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)
   end
   local tasks = {}
   for row = first, last do
      local uuid = M.uuid_at(buf, row - 1)
      if uuid then
         tasks[#tasks + 1] = s.tasks[uuid]
      end
   end
   return tasks
end

local function with_tasks(buf, fn)
   return function()
      local tasks = selection(buf)
      if #tasks == 0 then
         return vim.notify('No task on this line', vim.log.levels.WARN, { title = 'task' })
      end
      fn(tasks)
   end
end

-- The project of the line under the cursor: its task's, or its header's.
local function project_at(buf)
   local s = M.state[buf]
   local row = vim.fn.line('.')
   local uuid = M.uuid_at(buf, row - 1)
   if uuid then
      return s.tasks[uuid].project
   end
   local p = s.headers[row]
   return p ~= '' and p or nil
end

local function set_filter(buf)
   local s = M.state[buf]
   vim.ui.input({ prompt = 'Filter (' .. s.report .. '): ', default = s.filter }, function(filter)
      if not filter then
         return
      end
      s.filter = vim.trim(filter)
      pcall(vim.api.nvim_buf_set_name, buf, name_for(s.report, s.filter))
      M.refresh(buf)
   end)
end

local function close(buf)
   if #vim.api.nvim_tabpage_list_wins(0) > 1 then
      vim.cmd.close()
   else
      vim.api.nvim_buf_delete(buf, { force = true })
   end
end

local KEYS = {
   { 'n', '<CR>', 'Show task (toggle fold on a project)' },
   { 'n', 'n', 'New task in this project (just type the description)' },
   { 'n', 'a', 'Add a task, prompt starts with this project' },
   { 'nx', 'd', 'Mark done' },
   { 'nx', 's', 'Start or stop' },
   { 'nx', 'D', 'Set or clear the due date' },
   { 'nx', 'P', 'Set the project' },
   { 'nx', 'm', 'Modify' },
   { 'n', 'e', 'Edit in $EDITOR (task edit)' },
   { 'nx', 'A', 'Annotate' },
   { 'nx', '+', 'Raise priority' },
   { 'nx', '-', 'Lower priority' },
   { 'nx', 'x', 'Delete' },
   { 'n', 'u', 'Undo the last change' },
   { 'n', 'gx', 'Open the GitLab issue or linked URL' },
   { 'n', '/', 'Change the filter' },
   { 'n', 'r', 'Refresh' },
   { 'n', 'q', 'Close' },
   { 'n', '?', 'Show these keys' },
}

-- The keys above in a float over the report. Keys that also act on a
-- visual selection are marked. q, Esc or ? closes it, as does leaving it.
local function help()
   local lines, key_width, text_width = {}, 0, 0
   for _, k in ipairs(KEYS) do
      key_width = math.max(key_width, #k[2])
   end
   for _, k in ipairs(KEYS) do
      local line = (' %-' .. key_width .. 's  %s%s '):format(k[2], k[3], k[1] == 'nx' and ' •' or '')
      lines[#lines + 1] = line
      text_width = math.max(text_width, vim.fn.strdisplaywidth(line))
   end
   vim.list_extend(lines, { '', ' • also works on a visual selection' })

   local buf = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   vim.bo[buf].modifiable = false
   vim.bo[buf].bufhidden = 'wipe'
   for i = 1, #KEYS do
      vim.api.nvim_buf_set_extmark(buf, ns_hl, i - 1, 1, { end_col = 1 + key_width, hl_group = 'TaskHelpKey' })
   end
   vim.api.nvim_buf_set_extmark(buf, ns_hl, #lines - 1, 0, { end_col = #lines[#lines], hl_group = 'TaskHelpNote' })

   local width = math.min(math.max(text_width, 36), vim.o.columns - 4)
   local height = math.min(#lines, vim.o.lines - 4)
   local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      row = math.floor((vim.o.lines - height) / 2) - 1,
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = height,
      style = 'minimal',
      title = ' Task keys ',
      title_pos = 'center',
   })
   vim.wo[win].cursorline = false

   local function close()
      if vim.api.nvim_win_is_valid(win) then
         vim.api.nvim_win_close(win, true)
      end
   end
   for _, lhs in ipairs({ 'q', '<Esc>', '?' }) do
      vim.keymap.set('n', lhs, close, { buffer = buf, nowait = true, desc = 'Close help' })
   end
   vim.api.nvim_create_autocmd('WinLeave', { buffer = buf, once = true, callback = close })
end

local function keymaps(buf)
   local function map(modes, lhs, fn, desc)
      for mode in modes:gmatch('.') do
         vim.keymap.set(mode, lhs, fn, { buffer = buf, desc = desc, nowait = true })
      end
   end
   local function task(fn)
      return with_tasks(buf, fn)
   end
   map('n', '<CR>', function()
      local uuid = M.uuid_at(buf, vim.fn.line('.') - 1)
      if uuid then
         require('task.detail').open(uuid)
      elseif M.state[buf].headers[vim.fn.line('.')] then
         vim.cmd('normal! za')
      end
   end, 'Show task')
   map('n', 'a', function()
      local p = project_at(buf)
      actions.add(p and ('project:' .. p .. ' ') or '')
   end, 'Add task')
   map('n', 'n', function() actions.quick_add(project_at(buf)) end, 'New task')
   map('nx', 'd', task(actions.done), 'Mark done')
   map('nx', 's', task(actions.toggle), 'Start or stop')
   map('nx', 'D', task(actions.due), 'Set due date')
   map('nx', 'P', task(actions.project), 'Set project')
   map('nx', 'm', task(actions.modify), 'Modify')
   map('n', 'e', task(actions.edit), 'Edit in $EDITOR')
   map('nx', 'A', task(actions.annotate), 'Annotate')
   map('nx', '+', task(function(ts) actions.priority(ts, 1) end), 'Raise priority')
   map('nx', '-', task(function(ts) actions.priority(ts, -1) end), 'Lower priority')
   map('nx', 'x', task(actions.delete), 'Delete')
   map('n', 'u', actions.undo, 'Undo')
   map('n', 'gx', task(function(ts) actions.open_url(ts[1]) end), 'Open link')
   map('n', '/', function() set_filter(buf) end, 'Change filter')
   map('n', 'r', function()
      cli.invalidate()
      M.refresh(buf)
   end, 'Refresh')
   map('n', 'q', function() close(buf) end, 'Close')
   map('n', '?', help, 'Show keys')
end

local function window_options(win)
   local wo = vim.wo[win][0]
   wo.foldmethod = 'expr'
   wo.foldexpr = "v:lua.require'task.view'.foldexpr(v:lnum)"
   wo.wrap = false
   wo.cursorline = true
   wo.number = false
   wo.relativenumber = false
   wo.list = false
   wo.spell = false
   wo.signcolumn = 'no'
end

-- Open a report in a split (or `mods`, such as `vertical`), or go to the
-- window already showing it.
function M.open(report, filter, mods)
   for buf, s in pairs(M.state) do
      if s.report == report and s.filter == filter then
         local win = vim.fn.bufwinid(buf)
         if win ~= -1 then
            vim.api.nvim_set_current_win(win)
         else
            vim.cmd({ cmd = 'sbuffer', args = { tostring(buf) }, mods = mods or {} })
         end
         return M.refresh(buf)
      end
   end

   local buf = vim.api.nvim_create_buf(false, true)
   vim.bo[buf].bufhidden = 'wipe'
   vim.bo[buf].modifiable = false
   pcall(vim.api.nvim_buf_set_name, buf, name_for(report, filter))
   M.state[buf] = {
      report = report, filter = filter, gen = 0,
      marks = {}, tasks = {}, headers = {}, levels = {},
   }
   keymaps(buf)

   local group = vim.api.nvim_create_augroup('task.view.' .. buf, { clear = true })
   vim.api.nvim_create_autocmd('BufWinEnter', {
      group = group, buffer = buf,
      callback = function() window_options(vim.api.nvim_get_current_win()) end,
   })
   vim.api.nvim_create_autocmd('BufWipeout', {
      group = group, buffer = buf,
      callback = function()
         M.state[buf] = nil
         vim.api.nvim_del_augroup_by_id(group)
         if next(M.state) == nil then
            unwatch()
         end
      end,
   })

   vim.cmd({ cmd = 'sbuffer', args = { tostring(buf) }, mods = mods or {} })
   vim.bo[buf].filetype = 'taskreport'
   M.refresh(buf)
   M.watch()
end

return M
