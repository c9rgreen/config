-- Options
vim.opt.clipboard:append('unnamedplus')
vim.opt.scrolloff = 8
vim.opt.virtualedit = 'all'
vim.opt.guicursor:append("a:blinkon1")
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.fillchars = {
   fold = '─',
   diff = ' '
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
vim.opt.number = false

-- Display diagnostics on virtual lines, but only for the current line
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- Contextual menu
vim.cmd.amenu([[PopUp.LSP\ Hover <Cmd>lua vim.lsp.buf.hover()<CR>]])
vim.cmd.amenu([[PopUp.References <Cmd>lua vim.lsp.buf.references()<CR>]])
vim.cmd.amenu([[PopUp.Close\ Window <Cmd>close<CR>]])

-- Abbreviations
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'
vim.cmd.iabbrev ':cg: Christopher Green'

-- Exit terminal
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>')

-- Set up language servers
require("lsp")

-- Set up plugins
require("plugins")
