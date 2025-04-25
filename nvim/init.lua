-- vim: foldmethod=marker foldlevel=0

-- Options, Abbreviations {{{
vim.opt.clipboard = 'unnamedplus'
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

-- Ghostty.app
vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/vim/vimfiles")

-- LilyPond
vim.opt.runtimepath:append("/opt/homebrew/share/lilypond/2.24.3/vim")

-- Abbreviations
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'
vim.cmd.iabbrev ':cg: Christopher Green'
-- }}}

-- Variables {{{
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
-- }}}

-- Autocommands {{{
vim.api.nvim_create_autocmd({ "FileType" }, {
   pattern = { "javascript", "typescript", "vue", "markdown", "html", "yaml", "css" },
   callback = function()
      vim.opt_local.formatprg = "prettier --stdin-filepath %"
   end,
   desc = "Use Prettier when possible "
})

-- Use the built-in LSP formatter
-- Enable via g:lsp_auto_format = 1
vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("LSP", { clear = true }),
   callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = args.buf,

         callback = function()
            local lsp_auto_format = vim.g.lsp_auto_format
            if lsp_auto_format then
               vim.lsp.buf.format { async = false, id = args.data.client_id }
            end
         end,
      })
   end,
   desc = "LSP Format on save"
})
-- }}}

-- Packages {{{
---@diagnostic disable: undefined-global
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
require('mini.comment').setup()
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
require('mini.map').setup()
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

---@diagnostic disable: undefined-global
local add = MiniDeps.add

-- LSP
add("neovim/nvim-lspconfig")

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

-- Elixir
add({
   source = 'elixir-tools/elixir-tools.nvim',
   depends = { 'nvim-lua/plenary.nvim' },
})
require("elixir").setup()

-- Ruby
add("vim-ruby/vim-ruby")

-- Julia
add("JuliaEditorSupport/julia-vim")

-- Go
add("fatih/vim-go")

-- Org mode
add("nvim-orgmode/orgmode")
require("orgmode").setup({
   org_agenda_files = '~/.orgfiles/**/*',
   org_default_notes_file = '~/.orgfiles/refile.org',
})

-- Git, DB, Endings, Vinegar, Projectionist
add("tpope/vim-fugitive")
add("tpope/vim-dadbod")
add("tpope/vim-endwise")
add("tpope/vim-vinegar")
add("tpope/vim-projectionist")

-- Colorscheme
add("savq/melange-nvim")
vim.cmd.colorscheme("melange")
-- }}}

-- Commands {{{
-- Function to open current file in Marked 2
local function open_in_marked2()
   -- Check if 'open' command is available (macOS)
   if vim.fn.executable('open') ~= 1 then
      vim.notify("The 'open' command is required but not found", vim.log.levels.ERROR)
      return
   end

   -- Get the current file path
   local current_file = vim.fn.expand('%:p')

   -- Check if the file exists and is saved
   if current_file == "" then
      vim.notify("Current buffer has no associated file", vim.log.levels.ERROR)
      return
   end

   -- Save the file if it has been modified
   if vim.bo.modified then
      vim.cmd('write')
   end

   -- Open the file with Marked 2
   local cmd = "open -a 'Marked 2' " .. vim.fn.shellescape(current_file)
   vim.fn.system(cmd)
   vim.cmd('redraw!')
end

-- :Marked
vim.api.nvim_create_user_command('Marked', open_in_marked2, {})
-- }}}

-- Mappings {{{
vim.keymap.set('n', '<leader>t', ':tabnew<CR>') -- Open new tab
vim.keymap.set('n', '<leader>c', ':%y+<CR>')    -- Copy buffer to clipboard
vim.keymap.set('n', '<leader>i', ':lua MiniFiles.open()<CR>')
vim.keymap.set('n', '<leader>p', ':lua MiniPick.builtin.files()<CR>')
vim.keymap.set('n', '<leader>g', ':lua MiniPick.builtin.grep_live()<CR>')
vim.keymap.set('n', '<leader>b', ':lua MiniPick.builtin.buffers()<CR>')
vim.keymap.set('n', '<leader>h', ':lua MiniPick.builtin.help()<CR>')
vim.keymap.set('n', '<leader>l', ':lua MiniExtra.pickers.lsp({ scope = "document_symbol" })<CR>')
vim.keymap.set('n', '<leader>o', ':lua MiniDiff.toggle_overlay()<CR>')
vim.keymap.set('n', 'd<Space>', ':lua MiniBufremove.delete()<CR>')
vim.keymap.set('n', '<Leader>mt', ':lua MiniMap.toggle()<CR>')
vim.keymap.set('n', ',,', ':colorscheme randomhue<CR>')
vim.keymap.set('n', '<CR>', 'za', { noremap = true })                        -- Toggle fold under cursor with <ENTER>
vim.keymap.set('n', '<leader>r', 'gggqG', { noremap = true, silent = true }) -- Invoke formatprg
-- }}}

-- LSP {{{
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
   on_attach = function(_, bufnr)
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

-- }}}
