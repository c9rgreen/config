-- Mini
vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

require('mini.basics').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.files').setup()

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
-- Powerline field markers: branch (U+E0A0), line number (U+E0A1) and
-- character number (U+E0A3), plus the separator wedges (U+E0B0, U+E0B2).
-- Written as escapes rather than literals because these are Private Use Area
-- codepoints, and some editors strip them on save -- the wedges would
-- quietly vanish with nothing in the diff to explain why.
local PL_BRANCH = '\u{e0a0}'
local PL_LINE   = '\u{e0a1}'
local PL_COL    = '\u{e0a3}'
local SEP_L     = '\u{e0b0}'
local SEP_R     = '\u{e0b2}'

-- The content below is mini's own default apart from the wedges at each
-- color boundary and the powerline markers in the git and location sections.
-- combine_groups() passes plain strings through verbatim, so each wedge
-- carries its own highlight and gets none of the padding table entries get.
require('mini.statusline').setup({
   content = {
      active = function()
         local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
         local git           = MiniStatusline.section_git({ trunc_width = 40, icon = PL_BRANCH })
         local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
         local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
         local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
         local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
         local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
         local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
         -- The same fields as mini's own section_location (line/total, then
         -- virtual column/total; when truncated, just line and column), with
         -- the powerline markers standing in for its `|` and `│` separators.
         local location      = MiniStatusline.is_truncated(75)
            and (PL_LINE .. '%l ' .. PL_COL .. '%2v')
            or (PL_LINE .. '%l/%L ' .. PL_COL .. '%2v/%-2{virtcol("$") - 1}')

         return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode } },
            '%#' .. mode_hl .. 'SepL#' .. SEP_L,
            { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
            '%#MiniStatuslineDevinfoSep#' .. SEP_L,
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            '%#MiniStatuslineFileinfoSep#' .. SEP_R,
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            '%#' .. mode_hl .. 'SepR#' .. SEP_R,
            { hl = mode_hl,                  strings = { search, location } },
         })
      end,
   },
})

-- A wedge is the glyph painted in the nearer segment's background over the
-- farther one's. The mode groups swap per mode, so those boundaries need two
-- extra groups per mode -- few enough to define up front instead of
-- resolving them on every redraw -- plus one static group per side for the
-- Devinfo/Filename and Filename/Fileinfo boundaries.
local function define_separators()
   local bg = function(name) return vim.api.nvim_get_hl(0, { name = name, link = false }).bg end
   for _, m in ipairs({ 'Normal', 'Insert', 'Visual', 'Replace', 'Command', 'Other' }) do
      local hl = 'MiniStatuslineMode' .. m
      vim.api.nvim_set_hl(0, hl .. 'SepL', { fg = bg(hl), bg = bg('MiniStatuslineDevinfo') })
      vim.api.nvim_set_hl(0, hl .. 'SepR', { fg = bg(hl), bg = bg('MiniStatuslineFileinfo') })
   end
   vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfoSep',  { fg = bg('MiniStatuslineDevinfo'),  bg = bg('MiniStatuslineFilename') })
   vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfoSep', { fg = bg('MiniStatuslineFileinfo'), bg = bg('MiniStatuslineFilename') })
end

-- Deferred because the colors/*.lua schemes restyle statusline groups after
-- their mini.base16 setup; scheduling puts this after every other handler
-- for the event regardless of which file registered first.
vim.api.nvim_create_autocmd('ColorScheme', { callback = function() vim.schedule(define_separators) end })
define_separators()

require('mini.icons').setup()
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
require('mini.map').setup({
   window = {
      width = 1,
      winblend = 100,
      show_integration_count = false,
   },
})
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

-- Colorscheme relies on mini.base16
vim.cmd.colorscheme('atomic')
