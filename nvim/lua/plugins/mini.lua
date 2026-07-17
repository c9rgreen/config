-- Mini
vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

require('mini.basics').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.files').setup({ options = { use_as_default_explorer = false }})
require('mini.diff').setup()
require('mini.git').setup()
-- Time tracked today (timewarrior), refreshed asynchronously so the
-- statusline redraw never blocks on the shell. A filled green dot shows while
-- an interval is running, a dim hollow dot when stopped.
local timew_tracked = ''
if vim.fn.executable('timew') == 1 then
   local function refresh_timew()
      -- `timew get dom.active` is 1 while tracking; then read today's total.
      vim.system({ 'timew', 'get', 'dom.active' }, { text = true }, function(a)
         local active = vim.trim(a.stdout or '') == '1'
         vim.system({ 'timew', 'day' }, { text = true }, function(out)
            -- `timew day` footer: "Tracked   8:24:08" (includes running interval)
            local h, m = (out.stdout or ''):match('Tracked%s+(%d+):(%d+)')
            h, m = tonumber(h) or 0, tonumber(m) or 0
            local dot_hl = active and 'TimewActive' or 'TimewInactive'
            local dot = active and '●' or '○'
            local result = string.format(
               '%%#%s#%s%%#MiniStatuslineFileinfo# %dh%02dm', dot_hl, dot, h, m)
            vim.schedule(function()
               if result ~= timew_tracked then
                  timew_tracked = result
                  vim.cmd('redrawstatus')
               end
            end)
         end)
      end)
   end
   refresh_timew()
   vim.fn.timer_start(60000, refresh_timew, { ['repeat'] = -1 })
end

-- Powerline glyphs used in the statusline. PL_LEFT/PL_RIGHT are the hard
-- dividers between the mode cap and the neutral bar (their per-mode colors are
-- built in set_pl_hl); the rest are inline markers within a segment.
local PL_LEFT   = ''  -- U+E0B0, points right (hard divider, left half)
local PL_RIGHT  = ''  -- U+E0B2, points left  (hard divider, right half)
local PL_LOCK   = ''  -- U+E0A2, shown when the file is locked (readonly)
local PL_LINE   = ''  -- U+E0A1, marks the line-number field
local PL_COL    = ''  -- U+E0A3, marks the character-number field

-- The mode segment's color changes per Vim mode, so every transition that
-- touches it needs a per-mode highlight. These are precomputed once (and on
-- ColorScheme) rather than per statusline redraw, which happens constantly.
local PL_MODES = { 'Normal', 'Insert', 'Visual', 'Replace', 'Command', 'Other' }

-- Highlight-group name for a hard-arrow transition in a given mode. Both the
-- highlight definitions (set_pl_hl) and the statusline references (sep, below)
-- build their names through here, so the two cannot drift out of sync.
local function pl_hl(transition, mode)
   return 'MiniStatuslinePL' .. transition .. mode
end
local function set_pl_hl()
   local function bg(name, fallback)
      return vim.api.nvim_get_hl(0, { name = name, link = false }).bg or fallback
   end
   local base = bg('StatusLine', bg('Normal'))
   local dev  = bg('MiniStatuslineDevinfo', base)
   local file = bg('MiniStatuslineFilename', base)
   local info = bg('MiniStatuslineFileinfo', base)
   -- Per-mode highlights for the hard divider arrows: foreground = the mode cap's
   -- background, background = the adjacent segment's, so the triangle blends the
   -- colored mode cap into the neutral bar.
   for _, mode in ipairs(PL_MODES) do
      local mbg = bg('MiniStatuslineMode' .. mode, base)
      -- mode -> devinfo, and (when devinfo/fileinfo are absent) mode <-> filename.
      vim.api.nvim_set_hl(0, pl_hl('ModeDev',  mode), { fg = mbg, bg = dev })
      vim.api.nvim_set_hl(0, pl_hl('ModeFile', mode), { fg = mbg, bg = file })
      -- fileinfo -> mode (right half).
      vim.api.nvim_set_hl(0, pl_hl('InfoMode', mode), { fg = mbg, bg = info })
   end
end

require('mini.statusline').setup({
   content = {
      active = function()
         local MiniStatusline = require('mini.statusline')
         local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
         local suffix        = mode_hl:gsub('MiniStatuslineMode', '')
         local git           = MiniStatusline.section_git({ trunc_width = 40, icon = '' })
         local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
         local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
         local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
         local filename      = (MiniStatusline.section_filename({ trunc_width = 140 }):gsub('%%r', ''))
         if vim.bo.readonly then filename = filename .. ' ' .. PL_LOCK end
         local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
         local location      = PL_COL .. '%v ' .. PL_LINE .. '%l╱%L  %p%%'
         local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

         local function sep(hl, glyph) return '%#' .. hl .. '#' .. glyph end

         ---@type (table|string)[]
         local groups = { { hl = mode_hl, strings = { mode } } }
         -- Left half: mode -> devinfo -> filename, collapsing to mode -> filename
         -- when there is no git/diff/diagnostic/lsp info to show.
         if (git .. diff .. diagnostics .. lsp) ~= '' then
            groups[#groups + 1] = sep(pl_hl('ModeDev', suffix), PL_LEFT)
            groups[#groups + 1] = { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } }
         else
            groups[#groups + 1] = sep(pl_hl('ModeFile', suffix), PL_LEFT)
         end
         groups[#groups + 1] = '%<'
         groups[#groups + 1] = { hl = 'MiniStatuslineFilename', strings = { filename } }
         groups[#groups + 1] = '%='
         -- Right half: filename -> fileinfo -> mode, collapsing to filename -> mode
         -- for special buffers that have no fileinfo.
         if (timew_tracked .. fileinfo) ~= '' then
            groups[#groups + 1] = { hl = 'MiniStatuslineFileinfo', strings = { timew_tracked, fileinfo } }
            groups[#groups + 1] = sep(pl_hl('InfoMode', suffix), PL_RIGHT)
         else
            groups[#groups + 1] = sep(pl_hl('ModeFile', suffix), PL_RIGHT)
         end
         groups[#groups + 1] = { hl = mode_hl, strings = { search, location } }

         return MiniStatusline.combine_groups(groups)
      end,
   },
})

-- Dot colors for the timewarrior segment. They take the fileinfo segment's
-- background so the indicator only changes the dot's foreground, never the
-- statusline background. Re-derived on colorscheme changes (deferred so it
-- runs after mini re-creates its own highlights).
local function set_timew_hl()
   local info = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineFileinfo', link = false })
   local ok   = vim.api.nvim_get_hl(0, { name = 'DiagnosticOk', link = false })
   local cmt  = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
   vim.api.nvim_set_hl(0, 'TimewActive',   { fg = ok.fg,  bg = info.bg })
   vim.api.nvim_set_hl(0, 'TimewInactive', { fg = cmt.fg, bg = info.bg })
end
-- Deferred so it runs after the colorscheme is applied later in init.
vim.schedule(set_timew_hl)
vim.schedule(set_pl_hl)
vim.api.nvim_create_autocmd('ColorScheme', {
   group = vim.api.nvim_create_augroup('config_mini', { clear = true }),
   callback = function()
      vim.schedule(set_timew_hl)
      vim.schedule(set_pl_hl)
   end,
})

require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.snippets').setup()
require('mini.pick').setup({ window = { config = { border = 'rounded' } } })
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
