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
vim.diagnostic.config({ virtual_lines = true })

-- Ghostty.app
vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/vim/vimfiles")

-- LilyPond
vim.opt.runtimepath:append("/opt/homebrew/share/lilypond/2.24.3/vim")
-- }}}

-- Variables {{{
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.db_ui_use_nerd_fonts = 1
vim.g["fern#renderer"] = "nerdfont"
-- }}}

-- Autocommands {{{
vim.api.nvim_create_autocmd({ "FileType" }, {
   pattern = { "javascript", "typescript", "vue", "markdown", "html", "yaml", "css" },
   callback = function()
      vim.opt_local.formatprg = "prettier --stdin-filepath %"
   end,
   desc = "Use Prettier when possible "
})

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

vim.api.nvim_create_augroup("FernGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "FernGroup",
  pattern = "fern",
  callback = function()
    vim.opt_local.number = false
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<2-LeftMouse>",
      "<Plug>(fern-action-open-or-enter)",
      { noremap = false, silent = true }
    )
  end,
})
-- }}}

-- Packages {{{
require("mini")
require("lsp")
require("treesitter")
require("codecompanion").setup({
   strategies = {
      chat = {
         adapter = "anthropic",
      },
      inline = {
         adapter = "anthropic",
      },
   },
})
require("orgmode").setup()
-- }}}

-- Commands {{{
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
vim.keymap.set('n', ',,', ':colorscheme randomhue<CR>')
vim.keymap.set('n', '<CR>', 'za', { noremap = true })                        -- Toggle fold under cursor with <ENTER>
vim.keymap.set('n', '<leader>r', 'gggqG', { noremap = true, silent = true }) -- Invoke formatprg
-- }}}

vim.cmd.colorscheme "melange"
vim.cmd.iabbrev ':date: <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'
