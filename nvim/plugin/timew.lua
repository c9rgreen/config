-- timew: Timewarrior intervals, a tag-set picker and a statusline section
-- (implementation in lua/timew/)
if vim.g.loaded_timew then
   return
end
vim.g.loaded_timew = true

vim.api.nvim_create_user_command('Timew', function(cmd)
   require('timew').command(cmd.args, cmd.smods)
end, {
   nargs = '*',
   complete = function(...) return require('timew').complete(...) end,
   desc = 'Timewarrior intervals ([range] [tags]), or start/stop/continue/cancel/track/undo/chart',
})

require('timew').highlights()
vim.api.nvim_create_autocmd('ColorScheme', {
   group = vim.api.nvim_create_augroup('timew.highlights', { clear = true }),
   callback = function() require('timew').highlights() end,
})

vim.keymap.set('n', '<leader>w', function() require('timew').command('', {}) end, { desc = 'Timewarrior intervals' })
vim.keymap.set('n', '<leader>W', function() require('timew.pick').open() end, { desc = 'Timewarrior picker' })
