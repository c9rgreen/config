-- See h: lspconfig-all for helpful docs
vim.lsp.config('ts_ls', {
   init_options = {
      plugins = {
         {
            -- This requires npm install -g @vue/typescript-plugin
            name = "@vue/typescript-plugin",
            location = vim.fn.expand('$HOME/.npm-global/lib/node_modules/@vue/typescript-plugin'),
            languages = { "javascript", "typescript", "vue" },
         },
      },
   },
   filetypes = { "javascript", "typescript", "vue" },
})

vim.lsp.config('vue_ls', {
   init_options = {
      typescript = {
         tsdk = vim.fn.expand('$HOME/.npm-global/lib/node_modules/typescript/lib')
      }
   }
})

vim.lsp.config('lua_ls', {
   on_init = function(client)
      if client.workspace_folders then
         local path = client.workspace_folders[1].name
         if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
         end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
         runtime = {
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
      Lua = {
         format = {
            enable = true,
            defaultConfig = {
               indent_stle = "space",
            },
         },
      }
   },
})

vim.lsp.enable({
   'cssls',
   'eslint',
   'expert',
   'html',
   'intelephense',
   'lua_ls',
   'marksman',
   'pyright',
   'ts_ls',
   'vue_ls',
   'yamlls',
})
