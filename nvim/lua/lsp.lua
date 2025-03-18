local lspconfig = require('lspconfig')

-- JavaScript/Typescript language server with Vue plugin
lspconfig.ts_ls.setup {
   init_options = {
      plugins = {
         {
            name = "@vue/typescript-plugin",
            location = vim.fn.expand('$HOME/.npm-global/lib/node_modules/@vue/typescript-plugin'),
            languages = { "javascript", "typescript", "vue" },
         },
      },
   },
   filetypes = {
      "javascript",
      "typescript",
      "vue",
   },
}

-- Vue language server
lspconfig.volar.setup {
   init_options = {
      typescript = {
         tsdk = vim.fn.expand('$HOME/.npm-global/lib/node_modules/typescript/lib')
      }
   }
}

-- ESLint
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- CSS
lspconfig.cssls.setup {}

-- HTML
lspconfig.html.setup {}

-- PHP
lspconfig.intelephense.setup {}

-- Yaml
lspconfig.yamlls.setup {}

-- Lua
lspconfig.lua_ls.setup {
   on_init = function(client)
      if client.workspace_folders then
         local path = client.workspace_folders[1].name
         if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
         end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
         runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
         },
         -- Make the server aware of Neovim runtime files
         workspace = {
            checkThirdParty = false,
            library = {
               vim.env.VIMRUNTIME
            }
         }
      })
   end,
   settings = {
      Lua = {}
   }
}

-- Elixer
require("elixir").setup()
