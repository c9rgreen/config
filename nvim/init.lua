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
-- Use the built-in LSP formatter
vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("LSP", { clear = true }),
   callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = args.buf,

         callback = function()
            vim.lsp.buf.format { async = false, id = args.data.client_id }
         end,
      })
   end,
   desc = "LSP Format on save"
})
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
require('mini.icons').setup()
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

-- Org mode
add("nvim-orgmode/orgmode")
require("orgmode").setup({
   org_agenda_files = '~/.orgfiles/**/*',
   org_default_notes_file = '~/.orgfiles/refile.org',
})

-- Colorscheme
add("savq/melange-nvim")
vim.cmd.colorscheme("melange")
-- }}}

-- Mappings {{{
vim.keymap.set('n', '<CR>', 'za', { noremap = true }) -- Toggle fold under cursor with <ENTER>
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')       -- Open new tab
vim.keymap.set('n', '<leader>c', ':%y+<CR>')          -- Copy buffer to clipboard
vim.keymap.set('n', '<leader>mo', ':lua MiniFiles.open()<CR>')
vim.keymap.set('n', '<leader>mp', ':lua MiniPick.builtin.files()<CR>')
vim.keymap.set('n', '<leader>mg', ':lua MiniPick.builtin.grep_live()<CR>')
vim.keymap.set('n', '<leader>mm', ':lua MiniPick.builtin.buffers()<CR>')
vim.keymap.set('n', '<leader>mh', ':lua MiniPick.builtin.help()<CR>')
vim.keymap.set('n', '<leader>ml', ':lua MiniExtra.pickers.lsp({ scope = "document_symbol" })<CR>')
vim.keymap.set('n', '<leader>my', ':lua MiniDiff.toggle_overlay()<CR>')
vim.keymap.set('n', '<leader>md', ':lua MiniBufremove.delete()<CR>')
-- }}}

-- LSP {{{
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

vim.lsp.config('volar', {
   init_options = {
      typescript = {
         tsdk = vim.fn.expand('$HOME/.npm-global/lib/node_modules/typescript/lib')
      }
   }
})

vim.lsp.config('eslint', {
   on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = bufnr,
         command = "EslintFixAll",
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
   }
})

vim.lsp.config('nextls', {
   cmd = { 'nextls', '--stdio' }
})

vim.lsp.enable({
   'cssls',
   'eslint',
   'html',
   'intelephense',
   'lua_ls',
   'nextls',
   'pyright',
   'ts_ls',
   'volar',
   'yamlls',
})
-- }}}
