-- Options
vim.opt.clipboard:append('unnamedplus')
vim.opt.scrolloff = 8
vim.opt.virtualedit = 'all'
vim.opt.guicursor:append('a:blinkon1')
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.fillchars = {
   fold = '─',
   diff = ' '
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

-- Abbreviations
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'
vim.cmd.iabbrev ':cg: Christopher Green'

-- Keymaps
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })
vim.keymap.set('x', '>', '>gv', { desc = 'Keep visual mode after indenting' })
vim.keymap.set('x', '<', '<gv', { desc = 'Keep visual mode after indenting' })
vim.keymap.set('n', '<D-s>', ':write<CR>', { desc = 'Save (macOS)' })

-- Italics
vim.api.nvim_set_hl(0, 'Comment', { italic = true })

-- Set up plugins
require('plugins')
