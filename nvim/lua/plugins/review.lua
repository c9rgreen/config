-- review.nvim: leave review comments in a codediff view and export them as
-- Markdown (:Review). It needs codediff, which plugins.codediff has already
-- loaded, and nui.nvim for its comment popup. Releases only, as its README
-- suggests.
vim.pack.add({
   'https://github.com/MunifTanjim/nui.nvim',
   { src = 'https://github.com/georgeguimaraes/review.nvim', version = vim.version.range('*') },
})

require('review').setup()

vim.keymap.set('n', '<leader>rr', '<Cmd>Review<CR>', { desc = 'Review working tree' })
vim.keymap.set('n', '<leader>rc', '<Cmd>Review commits<CR>', { desc = 'Review commits' })
vim.keymap.set('n', '<leader>rb', '<Cmd>Review branch<CR>', { desc = 'Review branch' })
vim.keymap.set({ 'n', 'x' }, '<leader>rn', ':Review note<CR>', { desc = 'Review: note here' })
vim.keymap.set('n', '<leader>re', '<Cmd>Review edit<CR>', { desc = 'Review: edit comment' })
vim.keymap.set('n', '<leader>rd', '<Cmd>Review delete<CR>', { desc = 'Review: delete comment' })
vim.keymap.set('n', '<leader>rx', '<Cmd>Review export<CR>', { desc = 'Review: export' })
