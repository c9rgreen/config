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
-- Powerline glyphs: U+E0A0 is the git branch, and U+E0B6/U+E0B4 are the
-- half-circles that cap a pill. Written as escapes rather than literals
-- because these are Private Use Area codepoints, and some editors strip them
-- on save -- the pills would quietly lose their caps with nothing in the diff
-- to explain why.
local PL_BRANCH = '\u{e0a0}'
local PILL_L, PILL_R = '\u{e0b6}', '\u{e0b4}'

-- A pill is an ordinary highlighted section with a cap glyph on each side.
-- Each cap is drawn as foreground in that section's own fill color over the
-- bar's background, which makes the fill look like it rounds off. The cap
-- groups live in colors/atomic.lua, one per fill tone.
--
-- The caps go into the group list as plain strings rather than tables:
-- combine_groups() pads every table entry with a space on each side, and that
-- padding is what gives the pill its body, while strings pass through
-- untouched so a cap sits flush against the fill.
local function pill(hl, cap, strings)
   local content = vim.tbl_filter(function(s) return type(s) == 'string' and s ~= '' end, strings)
   -- Every section came back empty: skip the pill instead of drawing two caps
   -- around a space.
   if #content == 0 then return {} end
   return {
      '%#' .. cap .. '#' .. PILL_L,
      { hl = hl, strings = content },
      '%#' .. cap .. '#' .. PILL_R .. ' ',
   }
end

require('mini.statusline').setup({
   content = {
      active = function()
         local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
         local mode_cap      = mode_hl:gsub('MiniStatuslineMode', 'MiniStatuslineCap')
         -- The same sections and truncation widths as mini's default
         -- content; only the assembly below differs. `icon` can be passed
         -- straight to section_git() here, so the old wrapper around it is
         -- gone.
         local git           = MiniStatusline.section_git({ trunc_width = 40, icon = PL_BRANCH })
         local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
         local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
         local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
         local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
         local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
         local location      = MiniStatusline.section_location({ trunc_width = 75 })
         local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

         local groups = { ' ' } -- left margin, so the first pill floats clear of the edge
         local add = function(parts) vim.list_extend(groups, parts) end

         add(pill(mode_hl, mode_cap, { mode }))
         add(pill('MiniStatuslineDevinfo', 'MiniStatuslineCapDevinfo', { git, diff, diagnostics, lsp }))
         -- The filename goes in uncapped, riding the bar itself:
         -- MiniStatuslineFilename already carries the bar's background, which
         -- leaves the pills as the only filled things on the line. '%<' marks
         -- where to truncate and '%=' ends the left-aligned run; both inherit
         -- that same bar-colored background from the group before them.
         add({ '%<', { hl = 'MiniStatuslineFilename', strings = { filename } }, '%=' })
         add(pill('MiniStatuslineFileinfo', 'MiniStatuslineCapDevinfo', { fileinfo }))
         add(pill(mode_hl, mode_cap, { search, location }))

         return MiniStatusline.combine_groups(groups)
      end,
   },
})

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
