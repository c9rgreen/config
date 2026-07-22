-- GitLab (Duo Code Suggestions, statusline)
vim.pack.add({'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git'})

require('gitlab').setup({
   statusline = { enabled = false },
})
