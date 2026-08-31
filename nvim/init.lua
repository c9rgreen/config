-- Options
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
   end
   local level = vim.fn.foldlevel(lnum)
   if level > vim.fn.foldlevel(lnum - 1) then
      return '▼'
   end
   -- A fold that starts on the same line the previous one ended -- two
   -- functions with no blank line between them, say -- does not show up as a
   -- deeper fold level: one fold over lines 5-10 and two over 5-7 and 8-10
   -- report the same levels, so comparing levels can never tell them apart.
   -- With 'foldmethod=expr' the fold expression can, since it returns '>N' on
   -- a line that starts a fold, and v:lnum is already the line being drawn, so
   -- it can be run as it stands. Expressions that describe folds the other way
   -- ('a1'/'s1') just miss the arrow, as before, and hand-made folds
   -- (neogit's) have nothing to ask.
   if level > 0 and vim.wo.foldmethod == 'expr' and vim.wo.foldexpr ~= '' then
      local ok, expr = pcall(vim.api.nvim_eval, vim.wo.foldexpr)
      if ok and tostring(expr):sub(1, 1) == '>' then
         return '▼'
      end
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

-- Gutter: sign column, fold marker, then a right-aligned line number. Terminal
-- buffers have neither signs nor folds, so they get the line number alone.
-- Neogit's status buffer keeps its folds but drops the signs, because the only
-- signs it places are its own fold arrows and fold_column() already draws
-- those.
--
-- All of this is decided here rather than in an autocmd, because both
-- 'signcolumn' and 'statuscolumn' belong to the window, not the buffer: a value
-- set for a terminal would stick around once that window showed a file, and
-- neogit sets its own signcolumn after the FileType event anyway. Leaving out
-- %s is what hides the signs; 'signcolumn' only sets aside the space for them.
function _G.status_column()
   if vim.bo.buftype == 'terminal' then
      return '%=%l '
   end
   local signs = vim.bo.filetype == 'NeogitStatus' and '' or '%s'
   return signs .. '%@v:lua.fold_click@' .. fold_column() .. '%X %=%l '
end
vim.opt.statuscolumn = '%{%v:lua.status_column()%}'

-- Closed folds: first line + line count (the ▶ marker lives in the fold column)
function _G.fold_text()
   local first = vim.fn.getline(vim.v.foldstart):gsub('\t', string.rep(' ', vim.bo.tabstop))
   local count = vim.v.foldend - vim.v.foldstart + 1
   return string.format(' %s  (%d lines) ', first, count)
end
vim.opt.foldtext = 'v:lua.fold_text()'
vim.opt.winborder = 'rounded'

-- Use virtual text for diagnostics, with nicer gutter/inline glyphs. The signs
-- are shaded cells (U+2588 full, U+2593 dark, U+2592 medium, U+2591 light) so
-- severity reads as density in the gutter rather than as four separate symbols.
vim.diagnostic.config({
   virtual_text = { prefix = '●' },
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = '█',
         [vim.diagnostic.severity.WARN]  = '▓',
         [vim.diagnostic.severity.INFO]  = '▒',
         [vim.diagnostic.severity.HINT]  = '░',
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

-- New UI
require('vim._core.ui2').enable({})

-- Plugins
require('plugins.mini')
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.zk')
require('plugins.orgmode')
require('plugins.gitlab')
require('plugins.d2')
require('plugins.codediff')
require('plugins.neogit')
