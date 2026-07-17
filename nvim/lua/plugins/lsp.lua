-- LSP config
vim.pack.add({
   'https://github.com/neovim/nvim-lspconfig',
   'https://github.com/mason-org/mason.nvim',
   'https://github.com/mason-org/mason-lspconfig.nvim',
})

-- Neovim embeds LuaJIT; without this lua_ls assumes Lua 5.4 and flags
-- 5.1-isms like `unpack` as deprecated.
vim.lsp.config('lua_ls', {
   settings = {
      Lua = {
         runtime = { version = 'LuaJIT' },
         workspace = { library = { vim.env.VIMRUNTIME } },
      },
   },
})

vim.lsp.enable({
   'cssls',
   'eslint',
   'expert',
   'html',
   'intelephense',
   'jsonls',
   'lua_ls',
   'marksman',
   'ruff',
   'shopify_theme_ls',
   'tailwindcss',
   'tinymist',
   'ts_ls',
   'ty',
   'yamlls'
})

require('mason').setup()
require('mason-lspconfig').setup({
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})
