--
-- Mini.nvim
-- https://nvim-mini.org/mini.nvim/
--
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
   vim.cmd("echo 'Installing `mini.nvim`' | redraw")
   local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      'https://github.com/nvim-mini/mini.nvim', mini_path
   }
   vim.fn.system(clone_cmd)
   vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add

require('mini.basics').setup()
require('mini.bufremove').setup()
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.extra').setup()
require('mini.files').setup()
require('mini.fuzzy').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.align').setup()

require('mini.snippets').setup({
   snippets = {
      require('mini.snippets').gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      require('mini.snippets').gen_loader.from_lang(),
   },
})

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
   highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
   }
})

local mini_diff = require('mini.diff')
mini_diff.setup({
   view = {
      style = 'sign',
      signs = { add = '+', change = '•', delete = '-' },
   }
})

-- Add MiniBufremove to the contextual menu
vim.cmd.amenu([[PopUp.Delete\ Buffer <Cmd>lua MiniBufremove.delete()<CR>]])

-- Commands
local mini_extra = require('mini.extra')
local mini_pick = require('mini.pick')
local commands = {
   -- MiniExtra Pickers
   Branches = function() mini_extra.pickers.git_branches() end,
   Diagnostic = function() mini_extra.pickers.diagnostic() end,
   DocumentSymbol = function() mini_extra.pickers.lsp({ scope = 'document_symbol' }) end,
   Keymaps = function() mini_extra.pickers.keymaps() end,
   Marks = function() mini_extra.pickers.marks() end,
   Quickfix = function() mini_extra.pickers.list({ scope = 'quickfix' }) end,
   WorkspaceSymbol = function() mini_extra.pickers.lsp({ scope = 'workspace_symbol' }) end,

   -- MiniPick Builtin Pickers
   Files = function() mini_pick.builtin.files() end,
   Buffers = function() mini_pick.builtin.buffers() end,
   Grep = function() mini_pick.builtin.grep_live() end,
   Help = function() mini_pick.builtin.help() end,

   -- Other Commands
   Delete = function() require('mini.bufremove').delete() end,
   Diff = function() mini_diff.toggle_overlay() end,
}

for name, func in pairs(commands) do
   vim.api.nvim_create_user_command(name, func, {})
end

-- Mappings for Mini.Pick
vim.keymap.set('n', '<M-p>', ':Pick commands<CR>', { desc = 'Command picker' })
vim.keymap.set('n', '<D-p>', ':Pick commands<CR>', { desc = 'Command picker' })
vim.keymap.set('n', '\\\\', ':lua MiniFiles.open()<CR>', { desc = 'File browser' })
vim.keymap.set('n', '<leader><leader>', ':Pick buffers<CR>', { desc = 'Buffer picker' })
vim.keymap.set('n', '<leader>-', ':Pick files<CR>', { desc = 'File picker' })
vim.keymap.set('n', '<D-o>', ':Pick files<CR>', { desc = 'File picker' })
vim.keymap.set('n', '<leader>/', ':Pick grep_live<CR>', { desc = 'Live grep' })
vim.keymap.set('n', '<D-k>', ':DocumentSymbol<CR>', { desc = 'Document symbols' })

--
-- Treesitter - syntax highlighting, among other things
-- Requires tree-sitter-cli
--
add({
   source = 'nvim-treesitter/nvim-treesitter',
   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

local languages = {
   'bash', 'caddy', 'css', 'dockerfile',
   'eex', 'elixir', 'gitcommit', 'heex', 'html',
   'javascript', 'jinja', 'json', 'julia', 'liquid',
   'lua', 'markdown', 'mermaid', 'python', 'rst',
   'vim', 'vimdoc', 'vue', 'yaml',
}

require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
   pattern = languages,
   callback = function()
      vim.treesitter.start()
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
   end,
})

-- Treesitter - text objects
add('nvim-treesitter/nvim-treesitter-textobjects')

-- Treesitter context - display the context of the cursor in a sticky header
add('nvim-treesitter/nvim-treesitter-context')

require('treesitter-context').setup()

--
-- D2 - D2 diagram helpers, including preview
--
add('terrastruct/d2-vim')

--
-- Mason & LSP
-- See h: lspconfig-all for helpful docs
--
add({
   source = 'mason-org/mason-lspconfig.nvim',
   depends = {
      'neovim/nvim-lspconfig',
      'mason-org/mason.nvim',
   }
})

require('mason').setup()

-- LSP config for Lua
vim.lsp.config('lua_ls', {
   on_init = function(client)
      -- Load .luarc.json[c]
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
})

-- LSP config for Vue
local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
    '/vue-language-server' .. '/node_modules/@vue/language-server'
local vue_plugin = {
   name = '@vue/typescript-plugin',
   location = vue_language_server_path,
   languages = { 'vue' },
   configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
   settings = {
      vtsls = {
         tsserver = {
            globalPlugins = {
               vue_plugin,
            },
         },
      },
   },
   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- LSP config for Elixir
vim.lsp.config('expert', {
   cmd = { 'expert', '--stdio' },
   root_markers = { 'mix.exs', '.git' },
   filetypes = { 'elixir', 'eelixir', 'heex' },
})

-- Enable LSP servers
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
   'ts_ls',
   'ty',
   'vtsls',
   'vue_ls',
   'yamlls'
})

-- Run :Format to apply LSP formatting
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})

require('mason-lspconfig').setup({
   -- Automatically install the language servers configured by vim.lsp.enable
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})

--
-- Zettelkasten
--
add('zk-org/zk-nvim')

require('zk').setup({
   picker = 'minipick'
})

--
-- Git, database, utilities
--
add('tpope/vim-dadbod')
add('tpope/vim-endwise')
add('tpope/vim-eunuch')
add('tpope/vim-fugitive')
add('tpope/vim-vinegar')

--
-- Diff viewer
--
add('sindrets/diffview.nvim')

--
-- Modus
--
add('miikanissi/modus-themes.nvim')

require("modus-themes").setup({
   -- variant = "tinted",
   on_highlights = function(highlight, color)
      highlight.MiniCursorword = { bg = color.bg_yellow_subtle, fg = color.fg_alt }
      highlight.MiniCursorwordCurrent = { bg = color.bg_yellow_nuanced }
      highlight.Visual = { bg = color.bg_yellow_nuanced }
   end,
})

vim.cmd.colorscheme('modus')
