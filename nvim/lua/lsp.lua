-- LSP format on save
local lsp_formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
local format_on_save = function(client, bufnr)
   vim.notify(vim.inspect(client.supports_method("textDocument/formatting")))
   if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = lsp_formatting_augroup, -- Assign to our augroup
         buffer = bufnr,                 -- Make it buffer-local
         callback = function()
            -- Request formatting from this specific client.
            -- async = false ensures formatting completes before the file is written.
            vim.lsp.buf.format({ async = false, id = client.id })
         end,
      })
   end
end

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
   filetypes = {
      "javascript",
      "typescript",
      "vue",
   },
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
         diagnostics = {
            globals = { "vim" },
         },
         format = {
            enable = true,
            defaultConfig = {
               indent_stle = "space",
            },
         },
      }
   },
   on_attach = format_on_save
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
