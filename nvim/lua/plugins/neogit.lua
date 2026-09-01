-- Neogit: magit-style git UI (:Neogit)
-- Neogit finds its optional companions on its own, but the two used here --
-- codediff for the diff popup and mini.pick for menus -- are already loaded by
-- plugins.codediff and plugins.mini, so name them rather than rely on the
-- order neogit happens to look in.
vim.pack.add({'https://github.com/NeogitOrg/neogit'})

require('neogit').setup({
   -- Fold markers for sections and items, as { closed, opened }. Neogit draws
   -- these as signs rather than in the fold column, so they are its own glyphs
   -- and not the ones 'fillchars' sets -- matching them here keeps its folds
   -- reading the same as everywhere else. `hunk` keeps its default of a blank.
   signs = {
      section = { '▶', '▼' },
      item    = { '▶', '▼' },
   },
   integrations = {
      codediff = true,
      mini_pick = true,
   },
})

vim.keymap.set('n', '<leader>gg', function() vim.cmd('Neogit') end, { desc = 'Neogit status' })
