--
-- Options
--
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
vim.opt.clipboard:append('unnamedplus')
vim.opt.scrolloff = 8
vim.opt.virtualedit = 'all'
vim.opt.guicursor:append('a:blinkon1')
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.fillchars = {
   diff = '╱'
}
vim.opt.foldlevel = 5
vim.opt.foldmethod = 'indent'
vim.opt.foldtext = ''
vim.opt.wildignorecase = true
vim.opt.wildignore:append { '*/node_modules/**', '*.tmp', '*.swp', 'deps' }
vim.opt.shell = 'fish'
vim.opt.diffopt:append('internal,vertical,iwhiteall,algorithm:histogram')
vim.opt.splitright = true
vim.opt.number = false
vim.opt.path:append { '**' }

-- Display diagnostics on virtual lines, but only for the current line
vim.diagnostic.config({ virtual_text = true })

-- Contextual menu
vim.cmd.amenu([[PopUp.LSP\ Hover <Cmd>lua vim.lsp.buf.hover()<CR>]])
vim.cmd.amenu([[PopUp.References <Cmd>lua vim.lsp.buf.references()<CR>]])
vim.cmd.amenu([[PopUp.Close\ Window <Cmd>close<CR>]])

--
-- Abbreviations
--
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'

--
-- Keymaps
--
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })
vim.keymap.set('x', '>', '>gv', { desc = 'Keep visual mode after indenting' })
vim.keymap.set('x', '<', '<gv', { desc = 'Keep visual mode after indenting' })
vim.keymap.set('n', '<D-s>', ':write<CR>', { desc = 'macOS native save' })

-- Use rg for :find
if vim.fn.executable('rg') == 1 then
   function _G.FindFunc(arg_lead)
      local output = vim.fn.systemlist({ 'rg', '--files', '--follow' })
      if arg_lead ~= '' then
         return vim.fn.matchfuzzy(output, arg_lead)
      end
      return output
   end

   vim.o.findfunc = 'v:lua.FindFunc'
end

-- Enable built-in plugins
vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')

--
-- Netrw
--

-- Hide banner
vim.g.netrw_banner = 0
-- Use tree style by default
vim.g.netrw_liststyle = 3
-- Open in previous window
vim.g.netrw_browse_split = 4

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

local use_icons = vim.env.TERM_PROGRAM == 'ghostty'
local add = MiniDeps.add

require('mini.align').setup()
require('mini.basics').setup()
require('mini.bufremove').setup()
require('mini.cmdline').setup()
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.extra').setup()
require('mini.files').setup({ options = { use_as_default_explorer = false } })
require('mini.fuzzy').setup()
require('mini.git').setup()
require('mini.icons').setup({ style = use_icons and 'glyph' or 'ascii' })
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.statusline').setup({ use_icons = use_icons })
require('mini.surround').setup()
require('mini.tabline').setup()

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
mini_diff.setup()

-- Add MiniBufremove to the contextual menu
vim.cmd.amenu([[PopUp.Delete\ Buffer <Cmd>lua MiniBufremove.delete()<CR>]])

-- Commands
local mini_extra = require('mini.extra')
local mini_pick = require('mini.pick')
local mini_commands = {
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

for name, func in pairs(mini_commands) do
   vim.api.nvim_create_user_command(name, func, {})
end

-- Mappings for Mini.Pick
vim.keymap.set('n', '\\\\', ':lua MiniFiles.open()<CR>', { desc = 'File browser' })
vim.keymap.set('n', '<leader><leader>', ':Pick buffers<CR>', { desc = 'Buffer picker' })
vim.keymap.set('n', '<leader>-', ':Pick files<CR>', { desc = 'File picker' })
vim.keymap.set('n', '<leader>/', ':Pick grep_live<CR>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>k', ':DocumentSymbol<CR>', { desc = 'Document symbols' })

-- Colorscheme
vim.cmd.colorscheme('minisummer')

--
-- Treesitter - syntax highlighting, among other things
-- Requires tree-sitter-cli
--
add({
   source = 'nvim-treesitter/nvim-treesitter',
   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

local languages = {
   'bash',
   'caddy',
   'css',
   'eex',
   'elixir',
   'gitcommit',
   'heex',
   'html',
   'hurl',
   'javascript',
   'jinja',
   'json',
   'julia',
   'liquid',
   'lua',
   'markdown',
   'markdown_inline',
   'mermaid',
   'python',
   'rst',
   'sql',
   'vim',
   'vimdoc',
   'vue',
   'yaml',
}

require('nvim-treesitter').setup({ ensure_installed = languages })

vim.api.nvim_create_autocmd('FileType', {
   pattern = languages,
   callback = function()
      vim.treesitter.start()
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
   end,
})

-- Treesitter context - display the context of the cursor in a sticky header
add('nvim-treesitter/nvim-treesitter-context')

require('treesitter-context').setup()

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
   'yamlls'
})

-- Run :Format to apply LSP formatting
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})

require('mason-lspconfig').setup({
   -- Automatically install the language servers configured by vim.lsp.enable
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})
