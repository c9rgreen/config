-- timew.view — interval buffers.
--
-- A view shows the intervals in a date range (today by default), optionally
-- narrowed to intervals carrying every one of some tags. Each day with
-- tracked time is a fold under a header carrying the day's total, and an
-- interval that runs past midnight appears on every day it covers, clipped
-- to that day. Between two intervals on a day, a gap longer than the
-- configured minimum gets a line of its own, so it can be filled in.
--
-- Each interval or gap line carries an extmark whose id maps to what it
-- shows, which is how keys find their interval. Re-rendering keeps each
-- window's cursor on the same interval and its closed folds closed; the
-- open interval's duration is re-rendered every minute without re-reading.

local cli = require('timew.cli')
local range = require('timew.range')
local actions = require('timew.actions')

local M = {}

local ns = vim.api.nvim_create_namespace('timew.rows')
local ns_hl = vim.api.nvim_create_namespace('timew.hl')

-- buf -> { range, tags, gen, intervals, marks = {extmark id -> entry},
--          headers = {row -> day epoch}, levels }
-- An entry is { interval = iv } or { gap = { from, to } }.
M.state = {}

function M.foldexpr(lnum)
   local s = M.state[vim.api.nvim_get_current_buf()]
   return s and s.levels[lnum] or '0'
end

function M.entry_at(buf, row0)
   local s = M.state[buf]
   local marks = vim.api.nvim_buf_get_extmarks(buf, ns, { row0, 0 }, { row0, -1 }, {})
   return s and marks[1] and s.marks[marks[1][1]]
end

local function args_text(s)
   local tags = cli.format_tags(s.tags)
   return range.text(s.range) .. (tags ~= '' and (' ' .. tags) or '')
end

local function name_for(s)
   return 'timew://' .. args_text(s)
end

-- Name the buffer after its range, adding the buffer number when another
-- view already has that name (after stepping onto a range open elsewhere).
local function set_name(buf, s)
   if not pcall(vim.api.nvim_buf_set_name, buf, name_for(s)) then
      pcall(vim.api.nvim_buf_set_name, buf, name_for(s) .. ' (' .. buf .. ')')
   end
end

-- An interval's identity across renders: ids shift, starts do not.
local function key(entry)
   if entry.interval then
      return 'i' .. entry.interval.start
   end
   return 'g' .. entry.gap[1]
end

local function save_views(buf)
   local s = M.state[buf]
   local views = {}
   for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      local row = vim.api.nvim_win_get_cursor(win)[1]
      local entry = M.entry_at(buf, row - 1)
      local v = { row = row, key = entry and key(entry), header = s.headers[row], closed = {} }
      vim.api.nvim_win_call(win, function()
         for r, day in pairs(s.headers) do
            if vim.fn.foldclosed(r) ~= -1 then
               v.closed[day] = true
            end
         end
      end)
      views[win] = v
   end
   return views
end

local function restore_views(buf, views)
   local s = M.state[buf]
   local rows, header_rows = {}, {}
   for id, entry in pairs(s.marks) do
      local k = key(entry)
      if not rows[k] then
         rows[k] = vim.api.nvim_buf_get_extmark_by_id(buf, ns, id, {})[1] + 1
      end
   end
   for r, day in pairs(s.headers) do
      header_rows[day] = r
   end
   local count = vim.api.nvim_buf_line_count(buf)
   for win, v in pairs(views) do
      local row = (v.key and rows[v.key]) or (v.header and header_rows[v.header]) or math.min(v.row, count)
      vim.api.nvim_win_call(win, function()
         vim.cmd('normal! zx')
         for r, day in pairs(s.headers) do
            if v.closed[day] then
               vim.cmd(r .. 'foldclose')
            end
         end
      end)
      vim.api.nvim_win_set_cursor(win, { row, 0 })
   end
end

-- Each day's pieces of the intervals: { from, to, interval } clipped to
-- the day, in order.
local function by_day(s, intervals)
   local days = range.days(s.range)
   local now = os.time()
   local out = {}
   for i, day in ipairs(days) do
      local next_day = days[i + 1] or select(2, range.bounds(s.range))
      local pieces = {}
      for _, iv in ipairs(intervals) do
         local a = math.max(iv.from, day)
         local b = math.min(iv.to or now, next_day)
         if b > a or (a == iv.from and not iv.to and a < next_day) then
            pieces[#pieces + 1] = { from = a, to = b, interval = iv }
         end
      end
      if #pieces > 0 then
         out[#out + 1] = { day = day, pieces = pieces }
      end
   end
   return out
end

local function render(buf, intervals, err)
   local s = M.state[buf]
   local views = save_views(buf)
   local now = os.time()
   local gap_min = require('timew').config.gap

   -- Lines are built with their highlights: { text, hl } chunks, the
   -- right-aligned virtual text, and the entry the line stands for.
   local lines, levels, headers, meta = {}, {}, {}, {}
   local function line(chunks, virt, entry, level)
      local text, hls, col = {}, {}, 0
      for _, c in ipairs(chunks) do
         text[#text + 1] = c[1]
         if c[2] then
            hls[#hls + 1] = { col, col + #c[1], c[2] }
         end
         col = col + #c[1]
      end
      lines[#lines + 1] = table.concat(text)
      levels[#lines] = level or '0'
      meta[#lines] = { hls = hls, virt = virt, entry = entry }
   end

   local total = 0
   local days = err and {} or by_day(s, intervals)
   for _, d in ipairs(days) do
      for _, p in ipairs(d.pieces) do
         total = total + (p.to - p.from)
      end
   end
   -- A range of several days gets a title with its total; a single day's
   -- header is the title.
   local tags = cli.format_tags(s.tags)
   local single = s.range.days == 1
   local tag_chunk = { tags ~= '' and ('  ' .. tags) or '', 'TimewTag' }
   if not single then
      line({ { range.label(s.range), 'TimewTitle' }, tag_chunk }, { { cli.duration(total), 'TimewTotal' } })
   elseif err or #days == 0 then
      line({ { range.label(s.range), 'TimewDay' }, tag_chunk }, { { cli.duration(0), 'TimewDayTotal' } })
   end

   if err then
      for _, l in ipairs(vim.split('timew: ' .. err, '\n')) do
         line({ { l, 'TimewError' } })
      end
   elseif #days == 0 then
      line({ { 'No tracked time', 'TimewEmpty' } })
   end

   for _, d in ipairs(days) do
      local day_total = 0
      for _, p in ipairs(d.pieces) do
         day_total = day_total + (p.to - p.from)
      end
      if not single then
         line({}, nil, nil, '0')
      end
      line({ { os.date('%a %Y-%m-%d', d.day), 'TimewDay' }, single and tag_chunk or { '' } },
         { { cli.duration(day_total), 'TimewDayTotal' } }, nil, '>1')
      headers[#lines] = d.day

      for i, p in ipairs(d.pieces) do
         local prev = d.pieces[i - 1]
         if prev and p.from - prev.to >= gap_min then
            line({
               { '  ' .. os.date('%H:%M', prev.to) .. '–' .. os.date('%H:%M', p.from), 'TimewGap' },
               { '  ·', 'TimewGap' },
            }, { { cli.duration(p.from - prev.to), 'TimewGap' } }, { gap = { prev.to, p.from }, before = prev.interval }, '1')
         end
         local iv = p.interval
         local open = not iv.to
         local clipped_from, clipped_to = p.from ~= iv.from, iv.to and p.to ~= iv.to
         local label = cli.format_tags(iv.tags)
         line({
            { '  ' },
            { os.date('%H:%M', p.from), clipped_from and 'TimewClipped' or 'TimewTime' },
            { '–', 'TimewTime' },
            { open and 'now  ' or os.date('%H:%M', p.to), open and 'TimewActive' or (clipped_to and 'TimewClipped' or 'TimewTime') },
            { '  ' },
            { label ~= '' and label or '(no tags)', open and 'TimewActive' or (label ~= '' and 'TimewTags' or 'TimewEmpty') },
            { iv.annotation and ('  — ' .. iv.annotation:gsub('[\r\n]+', ' ')) or '', 'TimewAnnotation' },
         }, { { cli.duration(p.to - p.from), open and 'TimewActive' or 'TimewDuration' } }, { interval = iv }, '1')
      end
   end

   vim.bo[buf].modifiable = true
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   vim.bo[buf].modifiable = false
   vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
   vim.api.nvim_buf_clear_namespace(buf, ns_hl, 0, -1)
   s.marks, s.headers, s.levels, s.intervals, s.err = {}, headers, levels, intervals, err
   s.open = false

   for row, m in ipairs(meta) do
      for _, h in ipairs(m.hls) do
         if h[2] > h[1] then
            vim.api.nvim_buf_set_extmark(buf, ns_hl, row - 1, h[1], { end_col = h[2], hl_group = h[3] })
         end
      end
      if m.virt or m.entry then
         local id = vim.api.nvim_buf_set_extmark(buf, ns, row - 1, 0, {
            virt_text = m.virt, virt_text_pos = m.virt and 'right_align' or nil,
         })
         if m.entry then
            s.marks[id] = m.entry
            s.open = s.open or (m.entry.interval ~= nil and m.entry.interval.to == nil)
         end
      end
   end
   restore_views(buf, views)
end

function M.refresh(buf)
   local s = M.state[buf]
   if not s then
      return
   end
   s.gen = s.gen + 1
   local gen = s.gen
   local from, to = range.bounds(s.range)
   cli.export(vim.list_extend({ cli.iso(from), '-', cli.iso(to) }, s.tags), function(intervals, err)
      if M.state[buf] ~= s or s.gen ~= gen or not vim.api.nvim_buf_is_valid(buf) then
         return
      end
      render(buf, intervals, err)
   end)
end

function M.refresh_all()
   for buf in pairs(M.state) do
      M.refresh(buf)
   end
end

-- The open interval's duration ticks once a minute, re-rendered from the
-- intervals already read.
local ticker
local function tick()
   if ticker then
      return
   end
   ticker = vim.uv.new_timer()
   ticker:start(60000, 60000, vim.schedule_wrap(function()
      for buf, s in pairs(M.state) do
         if s.open and s.intervals and vim.api.nvim_buf_is_valid(buf) then
            render(buf, s.intervals)
         end
      end
   end))
end

local function untick()
   if ticker and next(M.state) == nil then
      ticker:close()
      ticker = nil
   end
end

local subscribed = false

-- Keys ---------------------------------------------------------------------

-- The intervals under the cursor, or on every line of the visual selection.
local function selection(buf)
   local first, last = vim.fn.line('.'), vim.fn.line('.')
   if vim.fn.mode():match('^[vV\22]') then
      first, last = vim.fn.line('v'), vim.fn.line('.')
      if first > last then
         first, last = last, first
      end
      vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)
   end
   local out = {}
   for row = first, last do
      local e = M.entry_at(buf, row - 1)
      if e and e.interval then
         out[#out + 1] = e.interval
      end
   end
   return out
end

local function with_intervals(buf, fn)
   return function()
      local ivs = selection(buf)
      if #ivs == 0 then
         return vim.notify('No interval on this line', vim.log.levels.WARN, { title = 'timew' })
      end
      fn(ivs)
   end
end

local function with_interval(buf, fn)
   return with_intervals(buf, function(ivs) fn(ivs[1]) end)
end

local function shift(buf, n)
   local s = M.state[buf]
   s.range = range.shift(s.range, n)
   set_name(buf, s)
   M.refresh(buf)
end

local function set_filter(buf)
   local s = M.state[buf]
   vim.ui.input({
      prompt = 'Range and tags: ',
      default = args_text(s),
      completion = "customlist,v:lua.require'timew'.complete_view",
   }, function(line)
      if not line then
         return
      end
      local r, tags = range.parse(cli.split(line))
      s.range = r or s.range
      s.tags = tags
      set_name(buf, s)
      M.refresh(buf)
   end)
end

-- Fill the gap under the cursor, starting from the tags just before it.
local function fill(buf)
   local e = M.entry_at(buf, vim.fn.line('.') - 1)
   if not (e and e.gap) then
      return vim.notify('Not on a gap', vim.log.levels.WARN, { title = 'timew' })
   end
   local span = os.date('%H:%M', e.gap[1]) .. '–' .. os.date('%H:%M', e.gap[2])
   actions.ask_tags('Track ' .. span .. ': ', cli.format_tags(e.before.tags), function(tags)
      actions.track(e.gap[1], e.gap[2], tags)
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
   { 'n', '<CR>', 'Open the Taskwarrior task (toggle fold on a day)' },
   { 'n', 's', 'Stop the open interval, or start these tags now' },
   { 'n', 'c', 'Continue this interval now' },
   { 'n', 'n', 'Start new tags now' },
   { 'nx', 't', 'Add tags' },
   { 'n', 'T', 'Retag' },
   { 'nx', 'A', 'Annotate (empty clears)' },
   { 'n', 'm', 'Modify start and end' },
   { 'nx', '+', 'Lengthen by the step' },
   { 'nx', '-', 'Shorten by the step' },
   { 'n', 'J', 'Join with the next interval' },
   { 'nx', 'S', 'Split in half' },
   { 'n', 'f', 'Fill the gap under the cursor' },
   { 'nx', 'x', 'Delete' },
   { 'n', 'u', 'Undo the last change' },
   { 'n', '[', 'Previous range' },
   { 'n', ']', 'Next range' },
   { 'n', '/', 'Change the range and tags' },
   { 'n', 'r', 'Refresh' },
   { 'n', 'q', 'Close' },
   { 'n', '?', 'Show these keys' },
}

-- The keys in a float over the view. Any of q, Esc or ? closes it, as does
-- leaving it.
local function help()
   local lines = {}
   for _, k in ipairs(KEYS) do
      lines[#lines + 1] = (' %-5s %s%s '):format(k[2], k[3], k[1] == 'nx' and ' *' or '')
   end
   vim.list_extend(lines, { '', ' * also on every line of a visual selection ' })
   local width = 0
   for _, l in ipairs(lines) do
      width = math.max(width, vim.fn.strdisplaywidth(l))
   end
   width = math.min(width, vim.o.columns - 4)
   local height = math.min(#lines, vim.o.lines - 4)

   local buf = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
   vim.bo[buf].modifiable = false
   vim.bo[buf].bufhidden = 'wipe'
   for row = 0, #KEYS - 1 do
      vim.api.nvim_buf_set_extmark(buf, ns_hl, row, 1, { end_col = 6, hl_group = 'TimewHelpKey' })
   end
   vim.api.nvim_buf_set_extmark(buf, ns_hl, #lines - 1, 0, { end_col = #lines[#lines], hl_group = 'Comment' })

   local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      row = math.floor((vim.o.lines - height) / 2) - 1,
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = height,
      style = 'minimal',
      title = ' timew keys ',
      title_pos = 'center',
   })
   local function close_help()
      if vim.api.nvim_win_is_valid(win) then
         vim.api.nvim_win_close(win, true)
      end
   end
   for _, lhs in ipairs({ 'q', '<Esc>', '?' }) do
      vim.keymap.set('n', lhs, close_help, { buffer = buf, desc = 'Close', nowait = true })
   end
   vim.api.nvim_create_autocmd('WinLeave', { buffer = buf, once = true, callback = close_help })
end

local function keymaps(buf)
   local function map(modes, lhs, fn, desc)
      for mode in modes:gmatch('.') do
         vim.keymap.set(mode, lhs, fn, { buffer = buf, desc = desc, nowait = true })
      end
   end
   local one = function(fn) return with_interval(buf, fn) end
   local many = function(fn) return with_intervals(buf, fn) end
   map('n', '<CR>', function()
      local row = vim.fn.line('.')
      local e = M.entry_at(buf, row - 1)
      if e and e.interval then
         if require('timew').config.taskwarrior then
            actions.open_task(e.interval)
         end
      elseif M.state[buf].headers[row] then
         vim.cmd('normal! za')
      end
   end, 'Open task')
   map('n', 's', one(actions.toggle), 'Start or stop')
   map('n', 'c', one(actions.continue), 'Continue')
   map('n', 'n', actions.start_new, 'Start new')
   map('nx', 't', many(actions.tag), 'Add tags')
   map('n', 'T', one(actions.retag), 'Retag')
   map('nx', 'A', many(actions.annotate), 'Annotate')
   map('n', 'm', one(actions.modify), 'Modify')
   map('nx', '+', many(actions.lengthen), 'Lengthen')
   map('nx', '-', many(actions.shorten), 'Shorten')
   map('n', 'J', one(actions.join_next), 'Join with next')
   map('nx', 'S', many(actions.split), 'Split')
   map('n', 'f', function() fill(buf) end, 'Fill gap')
   map('nx', 'x', many(actions.delete), 'Delete')
   map('n', 'u', function() actions.undo() end, 'Undo')
   map('n', '[', function() shift(buf, -1) end, 'Previous range')
   map('n', ']', function() shift(buf, 1) end, 'Next range')
   map('n', '/', function() set_filter(buf) end, 'Change range and tags')
   map('n', 'r', function() M.refresh(buf) end, 'Refresh')
   map('n', 'q', function() close(buf) end, 'Close')
   map('n', '?', help, 'Show keys')
end

local function window_options(win)
   local wo = vim.wo[win][0]
   wo.foldmethod = 'expr'
   wo.foldexpr = "v:lua.require'timew.view'.foldexpr(v:lnum)"
   wo.wrap = false
   wo.cursorline = true
   wo.number = false
   wo.relativenumber = false
   wo.list = false
   wo.spell = false
   wo.signcolumn = 'no'
end

-- Open a view of `r` (a timew.range) narrowed to `tags`, in a split (or
-- `mods`), or go to the window already showing it.
function M.open(r, tags, mods)
   local s = { range = r, tags = tags or {}, gen = 0, marks = {}, headers = {}, levels = {} }
   local name = name_for(s)
   for buf, other in pairs(M.state) do
      if name_for(other) == name then
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
   set_name(buf, s)
   M.state[buf] = s
   keymaps(buf)

   local group = vim.api.nvim_create_augroup('timew.view.' .. buf, { clear = true })
   vim.api.nvim_create_autocmd('BufWinEnter', {
      group = group, buffer = buf,
      callback = function() window_options(vim.api.nvim_get_current_win()) end,
   })
   vim.api.nvim_create_autocmd('BufWipeout', {
      group = group, buffer = buf,
      callback = function()
         M.state[buf] = nil
         vim.api.nvim_del_augroup_by_id(group)
         untick()
      end,
   })

   if not subscribed then
      subscribed = true
      cli.subscribe(M.refresh_all)
   end
   vim.cmd({ cmd = 'sbuffer', args = { tostring(buf) }, mods = mods or {} })
   vim.bo[buf].filetype = 'timewview'
   tick()
   M.refresh(buf)
end

-- Charts ---------------------------------------------------------------------

-- timew's own day, week or month chart. Without colour the chart shows only
-- tag labels, so it runs with colour and is drawn in a terminal buffer,
-- which renders the escape codes.
function M.chart(kind, args, mods)
   local cmd = vim.list_extend({ 'timew', kind }, args)
   vim.list_extend(cmd, { ':color' })
   local db = require('timew').config.db
   local env = db and { TIMEWARRIORDB = vim.fn.expand(db) } or nil
   vim.system(cmd, { text = true, stdin = false, env = env }, vim.schedule_wrap(function(res)
      local out = (res.stdout or '') .. (res.stderr or '')
      vim.cmd({ cmd = 'new', mods = mods or {} })
      local buf = vim.api.nvim_get_current_buf()
      vim.bo[buf].bufhidden = 'wipe'
      local chan = vim.api.nvim_open_term(buf, {})
      vim.api.nvim_chan_send(chan, (out:gsub('\r?\n', '\r\n')))
      pcall(vim.api.nvim_buf_set_name, buf, 'timew://' .. table.concat(vim.list_extend({ kind }, args), ' '))
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].number = false
      vim.wo[win][0].relativenumber = false
      vim.wo[win][0].signcolumn = 'no'
      vim.wo[win][0].wrap = false
      vim.keymap.set('n', 'q', function() close(buf) end, { buffer = buf, desc = 'Close', nowait = true })
   end))
end

return M
