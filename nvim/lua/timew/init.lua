-- timew — Timewarrior in Neovim.
--
-- :Timew [range] [tags]        opens the intervals in a range (today by
--                              default), narrowed to intervals with every tag
-- :Timew start|stop|continue|cancel|track|undo [args]
--                              runs that timew command
-- :Timew chart [day|week|month] [range] [tags]
--                              timew's own chart, in colour
-- require('timew.pick').open() switches to a recent tag set
-- require('timew.status').section()
--                              the open interval, for the statusline
--
-- Timewarrior stays the only store: every view is read from `timew export`
-- and every change is a `timew` command, so the shell, Taskwarrior's
-- on-modify hook and this plugin never disagree.

local M = {}

M.config = {
   -- Range for a bare :Timew, as :Timew takes it.
   range = 'day',
   -- Database directory; nil finds it the way timew does.
   db = nil,
   -- Refresh views and the statusline when anything else writes the data.
   watch = true,
   -- Seconds after which the open interval is flagged (nil never).
   long = 4 * 3600,
   -- What + and - lengthen and shorten by.
   step = '15min',
   -- Gaps shorter than this many seconds get no line in the view.
   gap = 5 * 60,
   -- Enter on an interval opens the task its tags came from.
   taskwarrior = true,
   -- How far back the picker looks for tag sets.
   pick_days = 30,
   icon = '\u{23f1}',
}

function M.setup(opts)
   M.config = vim.tbl_deep_extend('force', M.config, opts or {})
end

-- Highlight groups, linked so they follow the colorscheme and set again
-- after every :colorscheme. TimewStatusLong is the warning colour on the
-- statusline's fileinfo background, so it has to be resolved, not linked;
-- it is scheduled because mini.statusline's groups are restyled after the
-- colorscheme's own handlers.
function M.highlights()
   local links = {
      TimewTitle = 'Special',
      TimewTag = 'Comment',
      TimewTotal = 'Special',
      TimewDay = 'Title',
      TimewDayTotal = 'Comment',
      TimewTime = 'Number',
      TimewClipped = 'Comment',
      TimewTags = 'Normal',
      TimewAnnotation = 'Comment',
      TimewDuration = 'Comment',
      TimewActive = 'DiagnosticOk',
      TimewGap = 'NonText',
      TimewEmpty = 'Comment',
      TimewError = 'DiagnosticError',
      TimewHelpKey = 'Special',
   }
   for group, link in pairs(links) do
      vim.api.nvim_set_hl(0, group, { link = link, default = true })
   end
   vim.schedule(function()
      local get = function(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) end
      vim.api.nvim_set_hl(0, 'TimewStatusLong', {
         fg = get('DiagnosticWarn').fg, bg = get('MiniStatuslineFileinfo').bg, bold = true,
      })
   end)
end

local PASSTHROUGH = { stop = true, continue = true, cancel = true, track = true, undo = true }
local CHARTS = { day = true, week = true, month = true }

function M.command(args, mods)
   local cli = require('timew.cli')
   local actions = require('timew.actions')
   local words = cli.split(args)
   local sub = words[1]
   if sub == 'start' then
      if #words == 1 then
         return actions.start_new()
      end
      return actions.start(vim.list_slice(words, 2), { notify = true })
   elseif PASSTHROUGH[sub] then
      return actions.sequence({ words }, { notify = true })
   elseif sub == 'chart' then
      local kind = CHARTS[words[2]] and words[2] or 'week'
      local rest = vim.list_slice(words, CHARTS[words[2]] and 3 or 2)
      return require('timew.view').chart(kind, rest, mods)
   end
   local range = require('timew.range')
   local r, tags = range.parse(words)
   r = r or range.parse({ M.config.range })
   require('timew.view').open(r, tags, mods)
end

-- Completion -------------------------------------------------------------------

local function matching(list, lead)
   return vim.tbl_filter(function(v) return vim.startswith(v, lead) end, list)
end

local function quoted_tags()
   local cli = require('timew.cli')
   return vim.tbl_map(cli.quote, cli.tags())
end

local function words_before(line, pos, lead)
   local words = vim.split(line:sub(1, pos), '%s+', { trimempty = true })
   if lead ~= '' then
      table.remove(words)
   end
   return words
end

-- Tags, for the tag prompts.
function M.complete_tags(lead)
   return matching(quoted_tags(), lead)
end

-- A range then tags, for the view's / prompt.
function M.complete_view(lead, line, pos)
   if #words_before(line, pos, lead) == 0 then
      return vim.list_extend(matching(require('timew.range').WORDS, lead), matching(quoted_tags(), lead))
   end
   return matching(quoted_tags(), lead)
end

local SUBS = { 'start', 'stop', 'continue', 'cancel', 'track', 'undo', 'chart' }

function M.complete(lead, line, pos)
   local words = words_before(line, pos, lead)
   table.remove(words, 1)
   local ranges = require('timew.range').WORDS
   if #words == 0 then
      return vim.list_extend(matching(vim.list_extend(vim.deepcopy(SUBS), ranges), lead), matching(quoted_tags(), lead))
   end
   if words[1] == 'chart' and #words == 1 then
      return matching(vim.list_extend({ 'day', 'week', 'month' }, vim.tbl_map(function(w) return ':' .. w end, ranges)), lead)
   end
   return matching(quoted_tags(), lead)
end

return M
