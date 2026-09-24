-- Mini, grouped as in https://nvim-mini.org/mini.nvim/#modules
vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

--------------------------------------------------------------------------------
-- Text editing
--------------------------------------------------------------------------------

require('mini.align').setup()
require('mini.comment').setup()
require('mini.completion').setup()

-- Shift+arrows move lines in Normal mode and selections in Visual mode.
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

require('mini.pairs').setup()

-- Load snippets/global.json everywhere, plus snippets/<lang>.json per filetype.
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
   snippets = {
      gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
      gen_loader.from_lang(),
   },
})

require('mini.surround').setup()

--------------------------------------------------------------------------------
-- General workflow
--------------------------------------------------------------------------------

require('mini.basics').setup()
require('mini.bracketed').setup()

require('mini.bufremove').setup()
vim.keymap.set('n', '<leader><Del>', function() MiniBufremove.delete() end, { desc = 'Delete buffer' })

local miniclue = require('mini.clue')
miniclue.setup({
   triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' },
      { mode = 'n',          keys = '[' },
      { mode = 'n',          keys = ']' },
      { mode = 'i',          keys = '<C-x>' },
      { mode = { 'n', 'x' }, keys = 'g' },
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'n',          keys = '<C-w>' },
      { mode = { 'n', 'x' }, keys = 'z' },
   },
   clues = {
      { mode = 'n', keys = '<Leader>g', desc = '+Git' },
      { mode = 'n', keys = '<Leader>n', desc = '+Notes' },
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
   },
})

require('mini.cmdline').setup()

require('mini.diff').setup()
vim.keymap.set('n', '<leader>gd', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })

require('mini.extra').setup()
vim.keymap.set('n', '<leader>k', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>p', function() MiniExtra.pickers.commands() end, { desc = 'Command browser' })
vim.keymap.set('n', '<leader><Right>', function() MiniExtra.pickers.explorer() end, { desc = 'File explorer' })

require('mini.files').setup()
vim.keymap.set('n', '-', function() MiniFiles.open() end, { desc = 'File browser' })

-- Mouse support: double-click opens an entry, right-click goes up.
vim.api.nvim_create_autocmd('User', {
   pattern = 'MiniFilesBufferCreate',
   callback = function(args)
      local buf = args.data.buf_id
      vim.keymap.set('n', '<2-LeftMouse>', function() MiniFiles.go_in() end, { buffer = buf, desc = 'Open entry' })
      vim.keymap.set('n', '<RightMouse>', function() MiniFiles.go_out() end, { buffer = buf, desc = 'Go up' })
   end,
})

require('mini.git').setup()
require('mini.jump').setup()
require('mini.jump2d').setup()

require('mini.pick').setup({ window = { config = { border = 'rounded' }, prompt_prefix = ':' } })
vim.keymap.set('n', '<leader>/', function() MiniPick.builtin.grep_live() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>?', function() MiniPick.builtin.help() end, { desc = 'Live help' })
vim.keymap.set('n', '<leader>-', function() MiniPick.builtin.files() end, { desc = 'File picker' })
vim.keymap.set('n', '<leader><leader>', function() MiniPick.builtin.buffers() end, { desc = 'Buffer picker' })

require('mini.sessions').setup()
require('mini.visits').setup()

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------

-- mini.base16 is set up by the colorschemes in colors/ (see the end of this file).

require('mini.cursorword').setup()

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
   highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

      -- Show `#rrggbb` / `#rgb` in their own color.
      hex_color = hipatterns.gen_highlighter.hex_color(),
   },
})

require('mini.icons').setup()
-- Serve mini.icons to plugins that expect nvim-web-devicons (e.g. codediff.nvim).
MiniIcons.mock_nvim_web_devicons()
-- Show kind icons in mini.completion's LSP items.
MiniIcons.tweak_lsp_kind()

require('mini.indentscope').setup()

require('mini.map').setup({
   window = {
      width = 5,
      winblend = 100,
      show_integration_count = false,
   },
})
vim.keymap.set('n', '<leader>m', function() MiniMap.toggle() end, { desc = 'Toggle minimap' })

-- Replaces vim.notify and shows LSP progress; rounded border to match mini.pick.
require('mini.notify').setup({ window = { config = { border = 'rounded' } } })
vim.keymap.set('n', '<leader>N', function() MiniNotify.show_history() end, { desc = 'Notification history' })

require('mini.starter').setup()

-- Defaults; 'foldcolumn' and 'fillchars' shape the fold section (see init.lua).
require('mini.statuscolumn').setup()

-- Powerline glyphs, escaped because editors can strip Private Use Area characters.
local PL_BRANCH = '\u{e0a0}'
local PL_LINE   = '\u{e0a1}'
local PL_COL    = '\u{e0a3}'
local SEP_L     = '\u{e0b0}'
local SEP_R     = '\u{e0b2}'

-- mini's default layout plus powerline wedges, markers and a Timewarrior section.
-- Plain strings pass through combine_groups() as-is, so each wedge sets its own highlight.
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
         -- Current Timewarrior interval, empty when not tracking.
         local timew         = require('timew.status').section({ trunc_width = 120, hl = 'MiniStatuslineFileinfo' })
         -- Like section_location, with powerline markers as separators.
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
            { hl = 'MiniStatuslineFileinfo', strings = { timew, fileinfo } },
            '%#' .. mode_hl .. 'SepR#' .. SEP_R,
            { hl = mode_hl,                  strings = { search, location } },
         })
      end,
   },
})

-- Wedge highlights: the nearer segment's background as fg over the farther one's.
-- Each mode gets a left and right group; the filename boundaries get one each.
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

-- Scheduled so it runs after colorschemes restyle the statusline groups.
vim.api.nvim_create_autocmd('ColorScheme', { callback = function() vim.schedule(define_separators) end })
define_separators()

require('mini.tabline').setup()
require('mini.trailspace').setup()

--------------------------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------------------------

-- Built on mini.base16; the variant follows 'background' (dark_forest / light_parchment).
vim.cmd.colorscheme('circadia-forest')
