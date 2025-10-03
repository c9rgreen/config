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
   diff = '╱'
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

vim.diagnostic.config({ virtual_text = true })

-- Support for the Ghostty terminal configuration files
vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/vim/vimfiles")

-- Contextual menu
vim.cmd.amenu([[PopUp.Code\ action <Cmd>lua vim.lsp.buf.code_action()<CR>]])
vim.cmd.amenu([[PopUp.LSP\ Hover <Cmd>lua vim.lsp.buf.hover()<CR>]])
vim.cmd.amenu([[PopUp.References <Cmd>lua vim.lsp.buf.references()<CR>]])
vim.cmd.amenu([[PopUp.Delete\ Buffer <Cmd>lua MiniBufremove.delete()<CR>]])
vim.cmd.amenu([[PopUp.Close\ Window <Cmd>close<CR>]])

-- Abbreviations
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'
vim.cmd.iabbrev ':cg: Christopher Green'

-- Use italics for comments
vim.api.nvim_set_hl(0, 'Comment', { italic = true })
vim.api.nvim_set_hl(0, '@comment', { italic = true }) -- For Treesitter

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- Set up language servers
require("lsp")

-- Set up plugins
require("plugins")

-- Set colorscheme
vim.cmd.colorscheme("modus")

-- Mappings
vim.keymap.set('n', '-', ':lua MiniFiles.open()<CR>')                          -- File browser
vim.keymap.set('n', '<leader>-', ':lua MiniPick.builtin.files()<CR>')          -- File picker
vim.keymap.set('n', '<leader>/', ':lua MiniPick.builtin.grep_live()<CR>')      -- Live grep
vim.keymap.set('n', '<leader><leader>', ':lua MiniPick.builtin.buffers()<CR>') -- Buffer picker
vim.keymap.set('n', '<Esc><Esc>', ':lua MiniExtra.pickers.commands()<CR>')     -- Command picker
vim.keymap.set('n', 'gO', ':lua vim.lsp.buf.document_symbol()<CR>')            -- Show document symbols
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>')                                  -- Exit terminal mode with Ctrl+Enter

-- Commands
vim.api.nvim_create_user_command('Branches', function() MiniExtra.pickers.git_branches() end, {})
vim.api.nvim_create_user_command('Diagnostic', function() MiniExtra.pickers.diagnostic() end, {})
vim.api.nvim_create_user_command('DocumentSymbol', function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end,
   {})
vim.api.nvim_create_user_command('Files', function() MiniPick.builtin.files() end, {})
vim.api.nvim_create_user_command('Grep', function() MiniPick.builtin.grep_live() end, {})
vim.api.nvim_create_user_command('Help', function() MiniPick.builtin.help() end, {})
vim.api.nvim_create_user_command('Keymaps', function() MiniExtra.pickers.keymaps() end, {})
vim.api.nvim_create_user_command('Marks', function() MiniExtra.pickers.marks() end, {})
vim.api.nvim_create_user_command('Quickfix', function() MiniExtra.pickers.list({ scope = "quickfix" }) end, {})
vim.api.nvim_create_user_command('WorkspaceSymbol', function() MiniExtra.pickers.lsp({ scope = "workspace_symbol" }) end,
   {})
vim.api.nvim_create_user_command('Delete', function() MiniBufremove.delete() end, {})
vim.api.nvim_create_user_command('Diff', function() MiniDiff.toggle_overlay() end, {})
