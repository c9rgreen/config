-- task — Taskwarrior in Neovim.
--
-- :Task [report] [filter]  opens a report buffer (next by default)
-- :Task add <input>        adds a task, as `task add` would
-- require('task.pick').open()  picks from pending tasks with mini.pick
--
-- Taskwarrior stays the only store: every view is read from `task export`
-- and every change is a `task` command, so the shell, bugwarrior and this
-- plugin never disagree. The taskrc is the one the fish `task` wrapper
-- uses, chosen by 'background' here as the wrapper chooses it by the macOS
-- appearance, so UDAs, hooks and urgency coefficients all match.

local cli = require('task.cli')

local M = {}

M.config = {
   -- Report for a bare :Task, and for the picker.
   report = 'next',
   picker_report = 'next',
   -- Refresh open reports when something else writes the task database.
   watch = true,
   -- A path, or a function returning one (nil leaves TASKRC alone).
   taskrc = function()
      if vim.env.TASKRC then
         return vim.env.TASKRC
      end
      local path = vim.fn.expand('~/.config/task/taskrc.' .. vim.o.background)
      if vim.uv.fs_stat(path) then
         return path
      end
   end,
}

function M.setup(opts)
   M.config = vim.tbl_deep_extend('force', M.config, opts or {})
end

-- Highlight groups, linked so they follow the colorscheme. They are set
-- again after every :colorscheme, which clears default links.
function M.highlights()
   local links = {
      TaskProject = 'Title',
      TaskCount = 'Comment',
      TaskUrgency = 'Special',
      TaskUrgencyValue = 'Comment',
      TaskTag = 'Comment',
      TaskActive = 'DiagnosticOk',
      TaskOverdue = 'DiagnosticError',
      TaskDueSoon = 'DiagnosticWarn',
      TaskDue = 'Comment',
      TaskPriorityH = 'DiagnosticError',
      TaskPriorityM = 'DiagnosticWarn',
      TaskPriorityL = 'DiagnosticHint',
      TaskEmpty = 'Comment',
      TaskError = 'DiagnosticError',
      TaskHelpKey = 'Special',
      TaskHelpNote = 'Comment',
   }
   for group, link in pairs(links) do
      vim.api.nvim_set_hl(0, group, { link = link, default = true })
   end
end

-- :Task's argument line. A first word naming a report selects it, and the
-- rest is the filter; otherwise the whole line is the filter.
function M.command(args, mods)
   local words = cli.split(args)
   if words[1] == 'add' then
      local line = vim.trim(args:gsub('^%s*add', '', 1))
      if line == '' then
         return require('task.actions').add('')
      end
      return require('task.actions').add_line(line, { notify = true })
   end
   local report = M.config.report
   if words[1] and vim.tbl_contains(cli.report_names(), words[1]) then
      report = words[1]
      args = args:gsub('^%s*' .. vim.pesc(report), '', 1)
   end
   require('task.view').open(report, vim.trim(args), mods)
end

-- Completion -------------------------------------------------------------------

local ATTRS = { 'project', 'priority', 'due', 'scheduled', 'wait', 'until', 'recur', 'status', 'depends', 'description' }
local VALUES = {
   priority = { 'H', 'M', 'L' },
   status = { 'pending', 'waiting', 'completed', 'deleted', 'recurring' },
   recur = { 'daily', 'weekdays', 'weekly', 'biweekly', 'monthly', 'quarterly', 'yearly' },
}
local DATE_ATTRS = { due = true, scheduled = true, wait = true, ['until'] = true }
local DATES = {
   'today', 'tomorrow', 'yesterday', 'now', 'eod', 'eow', 'eom', 'eoy', 'sow', 'som',
   'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday', 'someday',
}

-- Taskwarrior accepts any unambiguous prefix of an attribute name (pro:).
local function attribute(name)
   for _, a in ipairs(ATTRS) do
      if a == name then
         return a
      end
   end
   for _, a in ipairs(ATTRS) do
      if vim.startswith(a, name) then
         return a
      end
   end
end

-- Completion for the due-date prompt, where the whole line is the date.
function M.complete_date(lead)
   return vim.tbl_filter(function(d) return vim.startswith(d, lead) end, DATES)
end

-- Completion for the add prompts, which take the same input as :Task add.
function M.complete_input(lead, line, pos)
   return M.complete(lead, 'Task add ' .. line, pos + #'Task add ')
end

-- Completion for the new-project prompt.
function M.complete_project(lead)
   return vim.tbl_filter(function(p) return vim.startswith(p, lead) end, cli.projects())
end

-- Completion for the tag prompt: the word under the cursor, keeping its
-- + or - sign. input() may pass the whole line as the lead, in which case
-- the words before this one go back in front of each match.
function M.complete_tag(lead, line, pos)
   local before = line:sub(1, pos)
   local head, word = before:match('^(.-)(%S*)$')
   local sign, name = word:match('^([+-]?)(.*)$')
   local keep = lead == before and head or ''
   local out = {}
   for _, tag in ipairs(cli.tags()) do
      if vim.startswith(tag, name) then
         out[#out + 1] = keep .. sign .. tag
      end
   end
   return out
end

function M.complete(lead, line, pos)
   local words = vim.split(line:sub(1, pos), '%s+', { trimempty = true })
   table.remove(words, 1)
   if lead ~= '' then
      table.remove(words)
   end
   local out = {}
   local function add(list, prefix)
      for _, v in ipairs(list) do
         v = (prefix or '') .. v
         if vim.startswith(v, lead) then
            out[#out + 1] = v
         end
      end
   end

   local name = lead:match('^(%w+):')
   if name then
      local attr = attribute(name)
      if attr == 'project' then
         add(cli.projects(), name .. ':')
      elseif VALUES[attr] then
         add(VALUES[attr], name .. ':')
      elseif DATE_ATTRS[attr] then
         add(DATES, name .. ':')
      end
      return out
   end
   if lead:match('^[+-]') then
      add(cli.tags(), lead:sub(1, 1))
      return out
   end
   if #words == 0 then
      add({ 'add' })
      add(cli.report_names())
   end
   add(vim.tbl_map(function(a) return a .. ':' end, ATTRS))
   return out
end

return M
