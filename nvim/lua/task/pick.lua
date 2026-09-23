-- task.pick — a mini.pick picker over pending tasks, most urgent first.
-- Enter opens the task's detail float, and the preview shows the same
-- details. Tasks marked with ctrl-x go to a menu of actions on alt-Enter.

local cli = require('task.cli')

local M = {}

local function item(t)
   local tags = (t.tags and #t.tags > 0) and ('  +' .. table.concat(t.tags, ' +')) or ''
   local due = t.due and ('  due ' .. cli.relative(t.due)) or ''
   return {
      text = ('%-16s %s%s%s'):format(t.project or '', t.description:gsub('[\r\n]+', ' '), tags, due),
      task = t,
   }
end

function M.open(opts)
   opts = opts or {}
   local ok, pick = pcall(require, 'mini.pick')
   if not ok then
      return vim.notify('The task picker needs mini.pick', vim.log.levels.ERROR, { title = 'task' })
   end
   local report = opts.report or require('task').config.picker_report
   local filter = opts.filter and cli.split(opts.filter) or {}

   pick.start({
      source = {
         name = 'Tasks (' .. report .. ')',
         items = function()
            cli.export(filter, report, function(tasks, err)
               if not pick.is_picker_active() then
                  return
               end
               if not tasks then
                  vim.notify(err, vim.log.levels.ERROR, { title = 'task' })
                  return pick.set_picker_items({})
               end
               pick.set_picker_items(vim.tbl_map(item, tasks))
            end)
         end,
         preview = function(buf, it)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, require('task.detail').lines(it.task))
            vim.bo[buf].filetype = 'markdown'
         end,
         choose = function(it)
            vim.schedule(function() require('task.detail').open(it.task.uuid) end)
         end,
         choose_marked = function(its)
            local tasks = vim.tbl_map(function(it) return it.task end, its)
            vim.schedule(function() require('task.actions').choose(tasks) end)
         end,
      },
   })
end

return M
