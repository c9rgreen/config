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
vim.opt.wildoptions:append('fuzzy')

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

-- Packages
vim.pack.add({
   'https://github.com/nvim-mini/mini.nvim',
   'https://github.com/nvim-treesitter/nvim-treesitter',
   'https://github.com/nvim-treesitter/nvim-treesitter-context',
   'https://github.com/neovim/nvim-lspconfig',
   'https://github.com/mason-org/mason.nvim',
   'https://github.com/mason-org/mason-lspconfig.nvim',
})

-- Mini
require('mini.basics').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.files').setup({ options = { use_as_default_explorer = false }})
require('mini.diff').setup()
require('mini.git').setup()
require('mini.statusline').setup()
require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.snippets').setup()
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.align').setup()
require('mini.sessions').setup()

vim.keymap.set('n', '<leader>g', function() MiniPick.builtin.grep() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>h', function() MiniPick.builtin.help() end, { desc = 'Live help' })
vim.keymap.set('n', '<leader>o', function() MiniPick.builtin.files() end, { desc = 'File picker' })
vim.keymap.set('n', '<leader>k', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>p', function() MiniExtra.pickers.commands() end, { desc = 'Command browser' })
vim.keymap.set('n', '<leader>b', function() MiniExtra.pickers.explorer() end, { desc = 'File exlporer' })
vim.keymap.set('n', '<leader><leader>', function() MiniPick.builtin.buffers() end, { desc = 'Buffer picker' })
vim.keymap.set('n', '-', function() MiniFiles.open() end, { desc = 'File browser' })

vim.cmd.colorscheme('minisummer')

-- Install treesitter parsers on demand, driven by the buffer's filetype
local ts = require('nvim-treesitter')
local available = ts.get_available()

local function start(buf, lang)
   vim.treesitter.start(buf, lang)
   vim.wo[0][0].foldmethod = 'expr'
   vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
   vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_autocmd('FileType', {
   callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match) or args.match
      if not vim.list_contains(available, lang) then
         return
      end
      if vim.list_contains(ts.get_installed(), lang) then
         start(args.buf, lang)
      else
         ts.install({ lang }):await(vim.schedule_wrap(function(err)
            if not err then
               start(args.buf, lang)
            end
         end))
      end
   end,
})

-- Display the context of the cursor in a sticky header
require('treesitter-context').setup()

-- LSP config
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

require('mason').setup()
require('mason-lspconfig').setup({
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})

-- New UI
require('vim._core.ui2').enable({})
