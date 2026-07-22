-- D2 syntax highlighting
vim.pack.add({'https://github.com/terrastruct/d2-vim'})

-- The plugin's ftdetect isn't sourced when packadd runs during startup
vim.filetype.add({ extension = { d2 = 'd2' } })
