-- vim: foldmethod=marker foldlevel=0

-- Options {{{
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8
vim.opt.virtualedit = 'all'
vim.opt.guicursor:append("a:blinkon1")
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.fillchars = 'fold: '
vim.opt.foldlevel = 5
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.wildignorecase = true

-- Ghostty.app
vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/vim/vimfiles")

-- LilyPond
vim.opt.runtimepath:append("/opt/homebrew/share/lilypond/2.24.3/vim")
-- }}}

-- Variables {{{
-- NetRW
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- Lumen
vim.g.lumen_light_colorscheme = "monokai-pro-light"
vim.g.lumen_dark_colorscheme = "monokai-pro-default"
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

-- Format on save
-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
   callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = args.buf,
         callback = function()
            vim.lsp.buf.format { async = false, id = args.data.client_id }
         end,
      })
   end
})
-- }}}

-- Plugins {{{
require("mini")
require("lsp")
require("treesitter")
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
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- In terminal mode, use Esc to go back to normal mode
vim.keymap.set('t', '<C-v><Esc>', '<Esc>')  -- Use C-v Esc to send Esc in terminal mode
-- }}}
