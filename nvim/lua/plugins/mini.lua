-- Mini
vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

require('mini.basics').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.files').setup({ options = { use_as_default_explorer = false }})

-- mini.files has no mouse actions of its own, but its windows are ordinary
-- focusable floats (clicking and scrolling already work via 'mouse'). Click
-- actions have to be attached per buffer through the BufferCreate event. A
-- double-click's first click has already placed the cursor, so go_in() acts
-- on the clicked entry.
vim.api.nvim_create_autocmd('User', {
   pattern = 'MiniFilesBufferCreate',
   callback = function(args)
      local buf = args.data.buf_id
      vim.keymap.set('n', '<2-LeftMouse>', function() MiniFiles.go_in() end, { buffer = buf, desc = 'Open entry' })
      vim.keymap.set('n', '<RightMouse>', function() MiniFiles.go_out() end, { buffer = buf, desc = 'Go up' })
   end,
})
require('mini.diff').setup()
require('mini.git').setup()
require('mini.statusline').setup()
-- Powerline field markers: branch (U+E0A0), line number (U+E0A1) and character
-- number (U+E0A3). mini's default statusline content calls section_git() without
-- an `icon` argument, and section_location() takes none at all, so replacing the
-- sections is the only hook for changing their glyphs.
local PL_BRANCH = ''
local PL_LINE   = ''
local PL_COL    = ''

local section_git = MiniStatusline.section_git
MiniStatusline.section_git = function(args)
   -- 'keep' so an explicit `icon` argument still wins; this only fills the default.
   return section_git(vim.tbl_extend('keep', args or {}, { icon = PL_BRANCH }))
end

-- Same fields as mini's own default (line/total, then virtual column/total), with
-- the markers standing in for the `|` and `│` separators it uses.
MiniStatusline.section_location = function(args)
   if MiniStatusline.is_truncated(args.trunc_width) then return PL_LINE .. '%l' end
   return PL_LINE .. '%l/%L ' .. PL_COL .. '%2v/%-2{virtcol("$") - 1}'
end

require('mini.icons').setup()
-- Plugins that still ask for `nvim-web-devicons` (nvim-tree) get mini.icons
-- glyphs and highlight groups instead of a second icon plugin.
MiniIcons.mock_nvim_web_devicons()

require('mini.tabline').setup()
require('mini.snippets').setup()
require('mini.pick').setup({ window = { config = { border = 'rounded' }, prompt_prefix = ':' } })
require('mini.extra').setup()
require('mini.align').setup()
require('mini.sessions').setup()
require('mini.bufremove').setup()
require('mini.trailspace').setup()
require('mini.cursorword').setup()
require('mini.indentscope').setup()
require('mini.surround').setup()
require('mini.starter').setup()
require('mini.map').setup()
require('mini.move').setup({
   mappings = {
      left  = '<S-left>',
      right = '<S-right>',
      down  = '<S-down>',
      up    = '<S-up>',

      line_left  = '<S-left>',
      line_right = '<S-right>',
      line_down  = '<S-down>',
      line_up    = '<S-up>',
   },
})

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
   highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

      -- Render `#rrggbb` / `#rgb` literals with their actual color
      hex_color = hipatterns.gen_highlighter.hex_color(),
   },
})

local miniclue = require('mini.clue')
miniclue.setup({
   triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },
      { mode = 'i', keys = '<C-x>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
   },
   clues = {
      { mode = 'n', keys = '<Leader>n', desc = 'Notes' },
      { mode = 'n', keys = '<Leader>g', desc = 'Git' },
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
   },
})

vim.keymap.set('n', '<leader>/', function() MiniPick.builtin.grep_live() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>?', function() MiniPick.builtin.help() end, { desc = 'Live help' })
vim.keymap.set('n', '<leader>-', function() MiniPick.builtin.files() end, { desc = 'File picker' })
vim.keymap.set('n', '<leader>k', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>p', function() MiniExtra.pickers.commands() end, { desc = 'Command browser' })
vim.keymap.set('n', '<leader><Right>', function() MiniExtra.pickers.explorer() end, { desc = 'File explorer' })
vim.keymap.set('n', '<leader><leader>', function() MiniPick.builtin.buffers() end, { desc = 'Buffer picker' })
vim.keymap.set('n', '<leader><Del>', function() MiniBufremove.delete() end, { desc = 'Delete' })
vim.keymap.set('n', '-', function() MiniFiles.open() end, { desc = 'File browser' })
vim.keymap.set('n', '<leader>gd', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })
vim.keymap.set('n', '<leader>m', function() MiniMap.toggle() end, { desc = 'Toggle minimap' })
