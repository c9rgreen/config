-- Options
vim.opt.clipboard:append('unnamedplus')
vim.opt.virtualedit = 'all'
vim.opt.fillchars = { diff = '╱' }
vim.opt.wildignorecase = true
vim.opt.shell = 'fish'
vim.opt.diffopt:append('vertical,iwhiteall,algorithm:histogram')
vim.opt.splitright = true
vim.opt.number = false
vim.opt.path:append { '**' }

-- Use virtual text for diagnostics
vim.diagnostic.config({ virtual_text = true })

-- Keymaps
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })

-- Use ripgrep for :find
if vim.fn.executable('rg') == 1 then
   function _G.ripgrep(cmdarg)
      local fnames = vim.fn.systemlist({ 'rg', '--files', '--follow' })
      if cmdarg ~= '' then
         return vim.fn.matchfuzzy(fnames, cmdarg)
      end
      return fnames
   end

   vim.opt.findfunc = 'v:lua.ripgrep'
end

-- Enable built-in plugins
vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
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

local add = MiniDeps.add

require('mini.align').setup()
require('mini.animate').setup()
require('mini.basics').setup()
require('mini.bufremove').setup()
require('mini.clue').setup()
require('mini.cmdline').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.extra').setup()
require('mini.files').setup({ options = { use_as_default_explorer = false } })
require('mini.fuzzy').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.keymap').setup()
require('mini.map').setup()
require('mini.move').setup()
require('mini.notify').setup()
require('mini.pick').setup()
require('mini.sessions').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()
require('mini.visits').setup()


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

-- Treesitter - syntax highlighting, among other things
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

-- Display the context of the cursor in a sticky header
add('nvim-treesitter/nvim-treesitter-context')

require('treesitter-context').setup()

-- LSP servers
add({
   source = 'mason-org/mason-lspconfig.nvim',
   depends = {
      'neovim/nvim-lspconfig',
      'mason-org/mason.nvim',
   }
})

require('mason').setup()

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

-- Automatically install LSP servers
require('mason-lspconfig').setup({
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})
