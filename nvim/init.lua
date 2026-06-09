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
vim.opt.completeopt = 'menu,menuone,noselect,popup'
vim.opt.autocomplete = true
vim.opt.signcolumn = 'yes'

-- LSP completion
vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
   callback = function(args)
      local client_id = args.data.client_id
      if not client_id then
         return
      end

      local client = vim.lsp.get_client_by_id(client_id)
      if client and client:supports_method("textDocument/completion") then
         -- Enable native LSP completion for this client + buffer
         vim.lsp.completion.enable(true, client_id, args.buf, {
            autotrigger = true, -- auto-show menu
         })
      end
   end,
})

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
   'https://github.com/nvim-treesitter/nvim-treesitter',
   'https://github.com/nvim-treesitter/nvim-treesitter-context',
   'https://github.com/neovim/nvim-lspconfig',
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
require('treesitter-context').setup()


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

-- New UI
require('vim._core.ui2').enable({})
