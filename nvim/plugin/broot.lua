-- broot: explore directories and open files with broot in a floating
-- terminal (implementation in lua/broot/)
if vim.g.loaded_broot then
   return
end
vim.g.loaded_broot = true

vim.api.nvim_create_user_command('Broot', function(cmd)
   local path = cmd.args ~= '' and vim.fn.expand(cmd.args) or nil
   require('broot').open({ path = path })
end, {
   nargs = '?',
   complete = 'file',
   desc = 'Explore with broot (a directory to root at, or a file to select; default cwd)',
})

vim.keymap.set('n', '<leader>b', function() require('broot').open() end, { desc = 'Broot' })
vim.keymap.set('n', '<leader>B', function()
   require('broot').open({ path = vim.api.nvim_buf_get_name(0) })
end, { desc = 'Broot at current file' })
