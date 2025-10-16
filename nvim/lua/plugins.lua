-- Initialize plugin manager
-- https://github.com/nvim-mini/mini.nvim
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
---@diagnostic disable: undefined-field
if not vim.loop.fs_stat(mini_path) then
   vim.cmd('echo "Installing `mini.nvim`" | redraw')
   local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      'https://github.com/nvim-mini/mini.nvim', mini_path
   }
   vim.fn.system(clone_cmd)
   vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add

--
-- Install plugins
--

-- Treesitter - syntax highlighting, among other things
add({
   source = "nvim-treesitter/nvim-treesitter",
   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

-- Treesitter - text objects
add("nvim-treesitter/nvim-treesitter-textobjects")

-- Treesitter context - display the context of the cursor in a sticky header
add('nvim-treesitter/nvim-treesitter-context')

-- D2 - D2 diagram helpers, including preview
add("terrastruct/d2-vim")

-- Quarto
add({
   source = "quarto-dev/quarto-nvim",
   depends = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter"
   }
})

-- Org Mode
add("nvim-orgmode/orgmode")

-- Git
add({
   source = "NeogitOrg/neogit",
   depends = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim"
   }
})

-- Diff viewer
add("sindrets/diffview.nvim")

-- Diagrams and images
add({
   source = "3rd/diagram.nvim",
   depends = { "3rd/image.nvim" }
})

-- Mason (LSP)
add({
   source = "mason-org/mason-lspconfig.nvim",
   depends = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
   }
})

-- Modus colorscheme
add("miikanissi/modus-themes.nvim")

--
-- Set up plugins
--

-- Mini - a collection of minimal utility plugins (such as pickers, icons)
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

local diff = require('mini.diff')
diff.setup({
   view = {
      style = 'sign',
      signs = { add = '+', change = '•', delete = '-' },
   }
})

require('nvim-treesitter.configs').setup({
   ensure_installed = {
      "bash",
      "caddy",
      "css",
      "dockerfile",
      "eex",
      "elixir",
      "gitcommit",
      "heex",
      "html",
      "javascript",
      "jinja",
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

require('treesitter-context').setup()

require('orgmode').setup({
   org_agenda_files = { '~/Documents/Org/*' },
   org_default_notes_file = '~/Documents/Org/refile.org',
})

require("modus-themes").setup({
   -- variant = "tinted",
   on_highlights = function(highlight, color)
      highlight.MiniCursorword = { bg = color.bg_yellow_subtle, fg = color.fg_alt }
      highlight.MiniCursorwordCurrent = { bg = color.bg_yellow_nuanced }
   end,
})

require("mason").setup()
require("mason-lspconfig").setup({
   -- Automatically install the language servers configured by vim.lsp.enable
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})

require("image").setup({
   integrations = {
      markdown = {
         enabled = true,
         filetypes = { "markdown", "quarto" }
      },
      org = { enabled = true }
   }
})

-- npm install -g @mermaid-js/mermaid-cli
require("diagram").setup({
   integrations = {
      require("diagram.integrations.markdown"),
   },
})
