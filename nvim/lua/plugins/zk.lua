-- zk (Zettelkasten notebook)
vim.pack.add({'https://github.com/zk-org/zk-nvim'})

require('zk').setup({ picker = 'minipick' })

vim.keymap.set('n', '<leader>nn', function() vim.cmd('ZkNew { title = vim.fn.input("Title: ") }') end, { desc = 'New note' })
vim.keymap.set('n', '<leader>no', function() vim.cmd('ZkNotes { sort = { "modified" } }') end, { desc = 'Open note' })
vim.keymap.set('n', '<leader>nt', function() vim.cmd('ZkTags') end, { desc = 'Browse tags' })
vim.keymap.set('n', '<leader>nf', function() vim.cmd('ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }') end, { desc = 'Find notes' })
