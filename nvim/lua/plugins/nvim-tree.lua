-- nvim-tree (sidebar file tree)
vim.pack.add({'https://github.com/nvim-tree/nvim-tree.lua'})

-- Icons come from mini.icons via the nvim-web-devicons mock set up in
-- plugins.mini; folder devicons stay off (nvim-tree's default) because
-- mini.icons resolves directory names through its "file" category and would
-- fall back to a generic glyph anyway.
require('nvim-tree').setup({
   disable_netrw = false,
   hijack_netrw  = true,
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file tree' })
