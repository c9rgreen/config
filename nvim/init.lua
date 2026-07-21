-- Options
vim.opt.clipboard:append('unnamedplus')
vim.opt.virtualedit = 'all'
vim.opt.fillchars = { diff = ' ', fold = ' ' }
vim.opt.wildignorecase = true
vim.opt.shell = 'fish' -- for :terminal, :!, and system()
vim.opt.diffopt:append('vertical,iwhiteall,algorithm:histogram')
vim.opt.splitright = true
vim.opt.number = false
vim.opt.numberwidth = 4 -- reserve a stable gutter so statuscolumn's %=%l right-aligns
vim.opt.path:append { '**' }
vim.opt.wildoptions:append('fuzzy')
vim.opt.foldlevel = 5

-- Fold column: down triangle at open-fold starts, right triangle at closed-fold
-- starts, blank otherwise. Rendered via statuscolumn so the native foldcolumn's
-- depth digits are never shown.
function _G.fold_column()
   local lnum = vim.v.lnum
   if vim.fn.foldclosed(lnum) == lnum then
      return '▶'
   elseif vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
      return '▼'
   end
   return ' '
end
-- Click handler: toggle the fold that starts on the clicked line.
function _G.fold_click()
   local lnum = vim.fn.getmousepos().line
   if lnum <= 0 or vim.fn.foldlevel(lnum) == 0 then
      return
   end
   if vim.fn.foldclosed(lnum) == -1 then
      vim.cmd(lnum .. 'foldclose')
   else
      vim.cmd(lnum .. 'foldopen')
   end
end
vim.opt.foldcolumn = '0'
vim.opt.statuscolumn = '%s%@v:lua.fold_click@%{%v:lua.fold_column()%}%X %=%l '

-- Closed folds: first line + line count (the ▶ marker lives in the fold column)
function _G.fold_text()
   local first = vim.fn.getline(vim.v.foldstart):gsub('\t', string.rep(' ', vim.bo.tabstop))
   local count = vim.v.foldend - vim.v.foldstart + 1
   return string.format(' %s  (%d lines) ', first, count)
end
vim.opt.foldtext = 'v:lua.fold_text()'
vim.opt.winborder = 'rounded'

-- Use virtual text for diagnostics, with nicer gutter/inline glyphs
vim.diagnostic.config({
   virtual_text = { prefix = '●' },
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = '',
         [vim.diagnostic.severity.WARN]  = '',
         [vim.diagnostic.severity.INFO]  = '',
         [vim.diagnostic.severity.HINT]  = '󰌵',
      },
   },
})

-- Keymaps
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })

-- Use ripgrep for :find
if vim.fn.executable('rg') == 1 then
   -- The file list is cached across the keystrokes of one completion session
   -- (cmdcomplete is true while the wildmenu is filtering).
   local fnames
   function _G.ripgrep(cmdarg, cmdcomplete)
      if not fnames then
         fnames = vim.fn.systemlist({ 'rg', '--files', '--follow' })
      end
      local result = cmdarg == '' and fnames or vim.fn.matchfuzzy(fnames, cmdarg)
      if not cmdcomplete then
         fnames = nil
      end
      return result
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

-- New UI
require('vim._core.ui2').enable({})

-- Plugins
require('plugins.mini')
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.zk')
require('plugins.orgmode')
require('plugins.diffview')
require('plugins.colorscheme')
