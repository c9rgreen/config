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
require('mini.icons').setup()
require('mini.indentscope').setup({ symbol = '⎸' })
require('mini.notify').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.splitjoin').setup()
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

require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add

--
-- Plugins
--

-- LSP
add("neovim/nvim-lspconfig")

-- Treesitter
add({
   source = "nvim-treesitter/nvim-treesitter",
   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

-- Elixir
add({
   source = 'elixir-tools/elixir-tools.nvim',
   depends = { 'nvim-lua/plenary.nvim' },
})

-- Ruby
add("vim-ruby/vim-ruby")

-- AI
add({
   source = 'olimorris/codecompanion.nvim',
   depends = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
   }
})

-- Colorscheme
add("savq/melange-nvim")

-- Org mode
add("nvim-orgmode/orgmode")

-- Auto light/dark
add("vimpostor/vim-lumen")

-- Git
add("tpope/vim-fugitive")

-- Endings
add("tpope/vim-endwise")

-- Vinegar
add("tpope/vim-vinegar")

-- Projectionist
add("tpope/vim-projectionist")

-- GitLab integration
add("shumphrey/fugitive-gitlab.vim")

-- GitHub integration
add("tpope/vim-rhubarb")

-- Database
add("tpope/vim-dadbod")
add("kristijanhusak/vim-dadbod-ui")
add("kristijanhusak/vim-dadbod-completion")
