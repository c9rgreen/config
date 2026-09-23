-- timew.pick — switch what you are tracking.
--
-- A mini.pick picker over the tag sets tracked in the last `pick_days`
-- days, the most recently used first. Enter starts the chosen set now
-- (closing whatever is open), and ctrl-o starts whatever is typed in the
-- prompt instead, for a set that has not been tracked before. The preview
-- shows the set's total and its latest intervals.

local cli = require('timew.cli')

local M = {}

local function sets(intervals)
   local now = os.time()
   local by_key, list = {}, {}
   for _, iv in ipairs(intervals) do
      if #iv.tags > 0 then
         local k = table.concat(iv.tags, '\0')
         local set = by_key[k]
         if not set then
            set = { tags = iv.tags, total = 0, intervals = {} }
            by_key[k], list[#list + 1] = set, set
         end
         set.total = set.total + ((iv.to or now) - iv.from)
         set.last = math.max(set.last or 0, iv.from)
         table.insert(set.intervals, 1, iv)
      end
   end
   table.sort(list, function(a, b) return a.last > b.last end)
   return list
end

local function item(set)
   return {
      text = ('%s  %s'):format(cli.format_tags(set.tags), os.date('%a %m-%d', set.last)),
      set = set,
   }
end

local function preview_lines(set, days)
   local lines = {
      '# ' .. cli.format_tags(set.tags),
      '',
      ('- **Total** %s over %d intervals in %d days'):format(cli.duration(set.total), #set.intervals, days),
      '',
      '## Latest',
      '',
   }
   for i = 1, math.min(15, #set.intervals) do
      local iv = set.intervals[i]
      lines[#lines + 1] = ('- %s–%s  %s%s'):format(
         os.date('%a %Y-%m-%d %H:%M', iv.from),
         iv.to and os.date('%H:%M', iv.to) or 'now',
         cli.duration((iv.to or os.time()) - iv.from),
         iv.annotation and ('  *' .. iv.annotation .. '*') or '')
   end
   return lines
end

function M.open()
   local ok, pick = pcall(require, 'mini.pick')
   if not ok then
      return vim.notify('The timew picker needs mini.pick', vim.log.levels.ERROR, { title = 'timew' })
   end
   local actions = require('timew.actions')
   local days = require('timew').config.pick_days
   local from = os.time() - days * 86400

   pick.start({
      source = {
         name = 'Timewarrior (ctrl-o starts the query)',
         items = function()
            cli.export({ 'from', cli.iso(from) }, function(intervals, err)
               if not pick.is_picker_active() then
                  return
               end
               if not intervals then
                  vim.notify(err, vim.log.levels.ERROR, { title = 'timew' })
                  return pick.set_picker_items({})
               end
               pick.set_picker_items(vim.tbl_map(item, sets(intervals)))
            end)
         end,
         preview = function(buf, it)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, preview_lines(it.set, days))
            vim.bo[buf].filetype = 'markdown'
         end,
         choose = function(it)
            vim.schedule(function() actions.start(it.set.tags) end)
         end,
      },
      mappings = {
         start_query = {
            char = '<C-o>',
            func = function()
               local tags = cli.split(table.concat(pick.get_picker_query()))
               if #tags == 0 then
                  return
               end
               vim.schedule(function() actions.start(tags) end)
               return true
            end,
         },
      },
   })
end

return M
