-- timew.status — what is being tracked, for the statusline.
--
-- section() returns the elapsed time and tags of the open interval, or ''
-- when nothing is tracked. It never runs timew itself: the open interval is
-- read once, then again whenever the data changes (from Neovim, the shell or
-- the Taskwarrior hook), and a one-minute timer redraws so the time ticks.
-- Past the `long` limit the section turns to a warning colour and one
-- notification asks whether the interval should still be open, since a
-- forgotten stop is the easiest way to lose a day of tracking.

local cli = require('timew.cli')

local M = {}

local state = { started = false, active = nil, warned = nil }

local function check_long()
   local iv = state.active
   local long = require('timew').config.long
   if not iv or not long or os.time() - iv.from < long or state.warned == iv.start then
      return
   end
   state.warned = iv.start
   local tags = cli.format_tags(iv.tags)
   vim.notify(('Tracking %s for %s. Still going?'):format(tags ~= '' and tags or 'time', cli.duration(os.time() - iv.from)),
      vim.log.levels.WARN, { title = 'timew' })
end

function M.refresh()
   cli.active(function(iv)
      state.active = iv
      check_long()
      vim.cmd.redrawstatus({ bang = true })
   end)
end

function M.start()
   if state.started then
      return
   end
   state.started = true
   cli.subscribe(M.refresh)
   local timer = vim.uv.new_timer()
   timer:start(60000, 60000, vim.schedule_wrap(function()
      if state.active then
         check_long()
         vim.cmd.redrawstatus({ bang = true })
      end
   end))
   vim.api.nvim_create_autocmd('FocusGained', {
      group = vim.api.nvim_create_augroup('timew.status', { clear = true }),
      callback = M.refresh,
   })
   M.refresh()
end

-- The open interval, or nil.
function M.active()
   M.start()
   return state.active
end

-- Statusline text. `opts.max` caps the tags' width (default 30), and with
-- `opts.trunc_width` a window narrower than that shows the time alone. A
-- long interval is wrapped in TimewStatusLong, then `opts.hl` (the group
-- the section sits in) is restored.
function M.section(opts)
   opts = opts or {}
   local iv = M.active()
   if not iv then
      return ''
   end
   local config = require('timew').config
   local elapsed = os.time() - iv.from
   local text = config.icon .. ' ' .. cli.duration(elapsed)
   local narrow
   if opts.trunc_width then
      local width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
      narrow = width < opts.trunc_width
   end
   if not narrow and #iv.tags > 0 then
      local tags = table.concat(iv.tags, ' ')
      local max = opts.max or 30
      if vim.fn.strchars(tags) > max then
         tags = vim.fn.strcharpart(tags, 0, max - 1) .. '…'
      end
      text = text .. ' ' .. tags:gsub('%%', '%%%%')
   end
   if config.long and elapsed >= config.long then
      return '%#TimewStatusLong#' .. text .. (opts.hl and ('%#' .. opts.hl .. '#') or '%*')
   end
   return text
end

return M
