-- Vimscript classics: git, database, and editing utilities.
-- vim-flog isn't tpope's, but it renders its commit graph through fugitive, so
-- it lives here to keep the load order (fugitive first) in one place.
vim.pack.add({
   'https://github.com/tpope/vim-fugitive',       -- :Git and the status buffer
   'https://github.com/rbong/vim-flog',           -- :Flog commit graph
   'https://github.com/tpope/vim-dadbod',         -- :DB database queries
   'https://github.com/tpope/vim-endwise',        -- auto-close end/endif/fi
   'https://github.com/tpope/vim-vinegar',        -- `-` opens the parent directory
   'https://github.com/tpope/vim-projectionist',  -- :A alternate-file navigation
   'https://github.com/tpope/vim-dispatch',       -- :Make and :Dispatch async builds
})
