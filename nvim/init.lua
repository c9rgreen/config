-- vim: foldmethod=marker foldlevel=0

-- Options, Abbreviations {{{
vim.opt.clipboard:append('unnamedplus')
-- vim.g.clipboard = 'osc52' -- Force OSC 52
vim.opt.scrolloff = 8
vim.opt.virtualedit = 'all'
vim.opt.guicursor:append("a:blinkon1")
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.fillchars = {
   fold = '─',
   diff = '▒'
}
vim.opt.foldlevel = 5
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.wildignorecase = true
vim.opt.shell = "fish"
vim.opt.diffopt:append("vertical")
vim.opt.diffopt:append("iwhiteall")
vim.opt.splitright = true
vim.diagnostic.config({ virtual_text = true })
vim.opt.number = false
vim.opt.grepprg = 'rg --vimgrep --no-heading --line-number --column'
vim.opt.grepformat = '%f:%l:%c:%m'

-- Ghostty.app
vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/vim/vimfiles")

-- Abbreviations
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'
vim.cmd.iabbrev ':cg: Christopher Green'

-- Use italics for comments
vim.api.nvim_set_hl(0, 'Comment', { italic = true })
vim.api.nvim_set_hl(0, '@comment', { italic = true }) -- For Tree-sitter
-- }}}

-- Variables {{{
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
-- }}}

-- Package Manager {{{
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
---@diagnostic disable: undefined-field
if not vim.loop.fs_stat(mini_path) then
   vim.cmd('echo "Installing `mini.nvim`" | redraw')
   local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      'https://github.com/echasnovski/mini.nvim', mini_path
   }
   vim.fn.system(clone_cmd)
   vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

---@diagnostic disable: undefined-global
local add = MiniDeps.add
-- }}}

-- Packages {{{
require('mini.align').setup()
require('mini.basics').setup()
require('mini.bufremove').setup()
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.diff').setup()
require('mini.extra').setup()
require('mini.files').setup()
require('mini.fuzzy').setup()
require('mini.git').setup()
require('mini.hipatterns').setup()
require('mini.icons').setup({ style = 'glyphs' })
require('mini.indentscope').setup({ symbol = '⎸' })
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()

require('mini.move').setup({
   mappings = {
      left       = '<S-left>',
      right      = '<S-right>',
      down       = '<S-down>',
      up         = '<S-up>',

      line_left  = '<S-left>',
      line_right = '<S-right>',
      line_down  = '<S-down>',
      line_up    = '<S-up>',
   }
})

require('mini.hipatterns').setup({
   highlighters = {
      hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
   },
})

require('mini.snippets').setup({
   snippets = {
      require('mini.snippets').gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      require('mini.snippets').gen_loader.from_lang(),
   },
})

-- Treesitter
add({
   source = "nvim-treesitter/nvim-treesitter",
   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

require('nvim-treesitter.configs').setup({
   ensure_installed = {
      "bash",
      "css",
      "dockerfile",
      "eex",
      "elixir",
      "gitcommit",
      "heex",
      "html",
      "javascript",
      "json",
      "julia",
      "liquid",
      "lua",
      "markdown",
      "mermaid",
      "python",
      "rst",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
   },
   highlight = { enable = true },
   indent = { enable = true },
   incremental_selection = { enable = true }
})

-- LSP
add("neovim/nvim-lspconfig")

-- Orgmode
add("nvim-orgmode/orgmode")

-- Tree viewer
add("nvim-tree/nvim-tree.lua")
add("nvim-tree/nvim-web-devicons")
require("nvim-tree").setup()

-- Other
add("Ramilito/kubectl.nvim")
add("kristijanhusak/vim-carbon-now-sh")
add("kristijanhusak/vim-dadbod-ui")
add("rbong/vim-flog")
add("shumphrey/fugitive-gitlab.vim")
add("sindrets/diffview.nvim")
add("tpope/vim-dadbod")
add("tpope/vim-endwise")
add("tpope/vim-fugitive")
add("tpope/vim-rhubarb")
add("tpope/vim-vinegar")
-- }}}

-- Mappings {{{
vim.keymap.set('n', '<leader><leader>', ':lua MiniPick.builtin.buffers()<CR>')                     -- Buffer picker
vim.keymap.set('n', '<leader><backspace>', ':lua MiniBufremove.delete()<CR>')                      -- Delete file without closing window
vim.keymap.set('n', '<leader>p', ':lua MiniExtra.pickers.commands()<CR>')                          -- Command picker
vim.keymap.set('n', '<leader>o', ':lua MiniPick.builtin.files()<CR>')                              -- File picker
vim.keymap.set('n', '<leader>g', ':lua MiniPick.builtin.grep_live()<CR>')                          -- Live grep
vim.keymap.set('n', '<leader>w', ':lua MiniExtra.pickers.lsp({ scope = "workspace_symbol" })<CR>') -- Workspace symbol picker
vim.keymap.set('n', '<leader>d', ':lua MiniExtra.pickers.lsp({ scope = "document_symbol" })<CR>')  -- Document symbol picker
vim.keymap.set('n', '<leader>-', ':lua MiniFiles.open()<CR>')                                      -- Open file browser
vim.keymap.set('n', '<leader>h', ':lua MiniPick.builtin.help()<CR>')                               -- Help picker
vim.keymap.set('n', '<leader>i', ':lua MiniExtra.pickers.diagnostic()<CR>')                        -- Diagnostic picker
vim.keymap.set('n', '<leader>s', ':lua MiniExtra.pickers.git_branches()<CR>')                      -- Git branch picker
vim.keymap.set('n', '<leader>k', ':lua MiniExtra.pickers.keymaps()<CR>')                           -- Keymap picker
vim.keymap.set('n', '<leader>q', ':lua MiniExtra.pickers.list({ scope = "quickfix" })<CR>')        -- Quickfix list picker
vim.keymap.set('n', '<leader>m', ':lua MiniExtra.pickers.marks()<CR>')                             -- Marks picker
vim.keymap.set('n', 'gO', ':lua vim.lsp.buf.document_symbol()<CR>')                                -- Show document symbols
-- }}}

-- LSP {{{
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

local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
   on_attach = function(client, bufnr)
      if not base_on_attach then return end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = bufnr,
         command = "LspEslintFixAll",
      })
   end,
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

vim.lsp.config('lexical', {
   cmd = { vim.fn.expand('$HOME/.config/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh') },
   on_attach = format_on_save
})

vim.lsp.enable({
   'cssls',
   'eslint',
   'html',
   'intelephense',
   'lua_ls',
   'lexical',
   'pyright',
   'ts_ls',
   'vue_ls',
   'yamlls',
})
-- }}}
