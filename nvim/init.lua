-- Options
vim.opt.virtualedit = 'all'
vim.opt.fillchars = { diff = ' ', fold = ' ' }
vim.opt.wildignorecase = true
vim.opt.shell = 'fish' -- for :terminal, :!, and system()
vim.opt.diffopt:append('vertical,iwhiteall,algorithm:histogram')
vim.opt.splitright = true
vim.opt.number = false
vim.opt.numberwidth = 4 -- reserve a stable gutter so the line number does not shift
vim.opt.path:append { '**' }
vim.opt.wildoptions:append('fuzzy')
vim.opt.foldlevel = 5

-- Fold column: one cell of native fold markers, which is what mini.statuscolumn
-- draws in its fold section. 'fillchars' keeps the markers to the triangles at
-- fold starts and blanks the rest, so the column never widens into depth digits
-- and folded lines get no vertical bar.
vim.opt.foldcolumn = '1'
vim.opt.fillchars:append('foldopen:▼,foldclose:▶,foldsep: ,foldinner: ')

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
