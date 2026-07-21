-- Orgmode
vim.pack.add({'https://github.com/nvim-orgmode/orgmode'})

require('orgmode').setup({
   org_agenda_files = '~/Desktop/Org/**/*',
   org_default_notes_file = '~/Desktop/Org/refile.org',
})

-- Experimental LSP support
vim.lsp.enable('org')
