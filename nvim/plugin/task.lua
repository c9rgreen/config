-- task: Taskwarrior reports, a detail float and a picker (implementation in
-- lua/task/)
if vim.g.loaded_task then
   return
end
vim.g.loaded_task = true

vim.api.nvim_create_user_command('Task', function(cmd)
   require('task').command(cmd.args, cmd.smods)
end, {
   nargs = '*',
   complete = function(...) return require('task').complete(...) end,
   desc = 'Taskwarrior report ([report] [filter]), or add <task>',
})

require('task').highlights()
vim.api.nvim_create_autocmd('ColorScheme', {
   group = vim.api.nvim_create_augroup('task.highlights', { clear = true }),
   callback = function() require('task').highlights() end,
})

vim.keymap.set('n', '<leader>t', function() require('task').command('', {}) end, { desc = 'Task report' })
vim.keymap.set('n', '<leader>T', function() require('task.pick').open() end, { desc = 'Task picker' })
