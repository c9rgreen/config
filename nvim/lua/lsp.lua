-- JavaScript/Typescript language server with Vue plugin
require('lspconfig').ts_ls.setup {
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
require('lspconfig').volar.setup {
   init_options = {
      typescript = {
         tsdk = vim.fn.expand('$HOME/.npm-global/lib/node_modules/typescript/lib')
      }
   }
}

-- CSS
require('lspconfig').cssls.setup {}

-- HTML
require('lspconfig').html.setup {}

-- PHP
require('lspconfig').intelephense.setup {}

-- Yaml
require('lspconfig').yamlls.setup {}

-- Lua
require 'lspconfig'.lua_ls.setup {
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
