-- GitLab (Duo Code Suggestions, statusline)
vim.pack.add({'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git'})

-- gitlab.vim hardcodes root_dir = getcwd() and offers no root/attach hook, so
-- wrap its lspconfig M.setup (the choke point every start path funnels
-- through): skip attaching outside a git repo, and use the repo root — not
-- cwd — as root_dir so gitlab-lsp never indexes $HOME. If a plugin update
-- reshapes gitlab.lspconfig, this errors loudly rather than silently crawling.
local gitlab_lspconfig = require('gitlab.lspconfig')
local setup = gitlab_lspconfig.setup
gitlab_lspconfig.setup = function(cfg)
   local root = vim.fs.root(0, '.git')
   if not root then
      return
   end
   cfg.root_dir = root
   return setup(cfg)
end

require('gitlab').setup({
   statusline = { enabled = false },
})
