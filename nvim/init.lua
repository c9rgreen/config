-- vim: foldmethod=marker foldlevel=0

-- Options {{{
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.virtualedit = 'all'
vim.opt.writebackup = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'yes'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 5
vim.opt.fillchars = {
   eob = ' ',
   fold = ' '
}

vim.opt.magic = true
vim.opt.wildignorecase = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

-- Ghostty.app
vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/vim/vimfiles")

-- LilyPond
vim.opt.runtimepath:append("/opt/homebrew/share/lilypond/2.24.3/vim")
-- }}}

-- Variables {{{
-- Use space for leader
vim.g.mapleader = ' '

-- NetRW
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- Lumen
vim.g.lumen_light_colorscheme = "monokai-pro-light"
vim.g.lumen_dark_colorscheme = "monokai-pro-default"
-- }}}

-- Mappings {{{
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<leader>c', ':%y+<CR>')
vim.keymap.set('n', '<A-Right>', ':bn<CR>')
vim.keymap.set('n', '<A-Left>', ':bp<CR>')
vim.keymap.set('n', '<A-Up>', ':tabn<CR>')
vim.keymap.set('n', '<A-Down>', ':tabp<CR>')
vim.keymap.set('n', '-', ':lua MiniFiles.open()<CR>')
vim.keymap.set('n', '<leader>p', ':lua MiniPick.builtin.files()<CR>')
vim.keymap.set('n', '<leader>g', ':lua MiniPick.builtin.grep_live()<CR>')
vim.keymap.set('n', '<leader>b', ':lua MiniPick.builtin.buffers()<CR>')
vim.keymap.set('n', '<leader>h', ':lua MiniPick.builtin.help()<CR>')
vim.keymap.set('n', '<leader>l', ':lua MiniExtra.pickers.lsp({ scope = "document_symbol" })<CR>')
vim.keymap.set('n', '<leader>o', ':lua MiniDiff.toggle_overlay()<CR>')
vim.keymap.set('n', 'd<Space>', ':lua MiniBufremove.delete()<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- In terminal mode, use Esc to go back to normal mode
vim.keymap.set('t', '<C-v><Esc>', '<Esc>')  -- Use C-v Esc to send Esc in terminal mode
vim.keymap.set('n', '<leader>f', 'ggVGgq')  -- Format buffer with formatprg
vim.keymap.set('v', '<', '<gv') -- Keep selection active after indenting
vim.keymap.set('v', '>', '>gv') -- Keep selection active after outdenting
-- }}}

-- Autocommands {{{
-- Terminal
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
   group = vim.api.nvim_create_augroup('Terminal', { clear = true }),
   callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
   end
})

-- Highlight groups
vim.api.nvim_create_autocmd({ 'Colorscheme' }, {
   group = vim.api.nvim_create_augroup('Mini', { clear = true }),
   callback = function()
      vim.cmd('highlight link MiniPickMatchCurrent TabLineSel')
   end
})
-- }}}

-- Mini {{{
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
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

local add = MiniDeps.add
-- }}}

-- Plugins {{{
-- Mini
require('mini.basics').setup()
require('mini.bracketed').setup()
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
require('mini.notify').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.starter').setup()
require('mini.statusline').setup({ use_icons = false })
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.hipatterns').setup({
   highlighters = {
      fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

      hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
   },
})

require('mini.snippets').setup({
   snippets = {
      -- Load custom file with global snippets first (adjust for Windows)
      require('mini.snippets').gen_loader.from_file('~/.config/nvim/snippets/global.json'),

      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      require('mini.snippets').gen_loader.from_lang(),
   },
})

-- LSP
add("neovim/nvim-lspconfig")

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
      "lua",
      "markdown",
      "python",
      "rst",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
   },
   highlight = { enable = true },
   indent = {
      enable = true,
   },
})

-- Elixir
add({
   source = 'elixir-tools/elixir-tools.nvim',
   depends = { 'nvim-lua/plenary.nvim' },
})

require("elixir").setup()

add('loctvl842/monokai-pro.nvim')
add('mattn/emmet-vim')
add('tpope/vim-projectionist')
add('tpope/vim-fugitive')
add('rbong/vim-flog')
add('shumphrey/fugitive-gitlab.vim')
add('vimpostor/vim-lumen')
-- }}}
