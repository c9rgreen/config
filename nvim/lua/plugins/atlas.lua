-- Atlas: review merge requests and manage issues (:Atlas)
-- Only the providers listed here are turned on. GitHub goes through `gh`, so
-- it needs no token. Reviews open in codediff, which plugins.codediff loads
-- first.
vim.pack.add({'https://github.com/emrearmagan/atlas.nvim'})

require('atlas').setup({
   providers = {
      github = {},
      gitlab = {
         base_url = 'https://gitlab.com',
         token = vim.env.GITLAB_TOKEN,
      },
   },
})
