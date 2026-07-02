-- Options
vim.opt.clipboard:append('unnamedplus')
vim.opt.virtualedit = 'all'
vim.opt.fillchars = { diff = '╱', fold = '─' }
vim.opt.wildignorecase = true
vim.opt.shell = 'fish'
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
   function _G.ripgrep(cmdarg)
      local fnames = vim.fn.systemlist({ 'rg', '--files', '--follow' })
      if cmdarg ~= '' then
         return vim.fn.matchfuzzy(fnames, cmdarg)
      end
      return fnames
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

require('mini.statusline').setup({
   content = {
      active = function()
         local MiniStatusline = require('mini.statusline')
         local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
         local git           = MiniStatusline.section_git({ trunc_width = 40 })
         local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
         local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
         local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
         local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
         local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
         local location      = MiniStatusline.section_location({ trunc_width = 75 })
         local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

         return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode } },
            { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { timew_tracked, fileinfo } },
            { hl = mode_hl,                  strings = { search, location } },
         })
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
vim.api.nvim_create_autocmd('ColorScheme', { callback = function() vim.schedule(set_timew_hl) end })

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
      { mode = 'n', keys = [[\]] },
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
      { mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
      { mode = 'n', keys = '<Leader>c', desc = 'Claude/AI' },
      { mode = 'x', keys = '<Leader>c', desc = 'Claude/AI' },
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
vim.keymap.set('n', '<leader><Right>', function() MiniExtra.pickers.explorer() end, { desc = 'File exlporer' })
vim.keymap.set('n', '<leader><leader>', function() MiniPick.builtin.buffers() end, { desc = 'Buffer picker' })
vim.keymap.set('n', '<leader>bd', function() MiniBufremove.delete() end, { desc = 'Delete buffer' })
vim.keymap.set('n', '-', function() MiniFiles.open() end, { desc = 'File browser' })
vim.keymap.set('n', '<leader>gd', function() MiniDiff.toggle_overlay() end, { desc = 'Toggle diff overlay' })
vim.keymap.set('n', '<leader>m', function() MiniMap.toggle() end, { desc = 'Toggle minimap' })

-- Colorscheme
vim.pack.add({'https://github.com/savq/melange-nvim'})
vim.cmd.colorscheme('melange')

-- Treesitter
vim.pack.add({
   'https://github.com/nvim-treesitter/nvim-treesitter',
   'https://github.com/nvim-treesitter/nvim-treesitter-context',
})

-- Install treesitter parsers on demand, driven by the buffer's filetype
local ts = require('nvim-treesitter')
local available = ts.get_available()

local function start(buf, lang)
   vim.treesitter.start(buf, lang)
   vim.wo[0][0].foldmethod = 'expr'
   vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
   vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_autocmd('FileType', {
   callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match) or args.match
      if not vim.list_contains(available, lang) then
         return
      end
      if vim.list_contains(ts.get_installed(), lang) then
         start(args.buf, lang)
      else
         ts.install({ lang }):await(vim.schedule_wrap(function(err)
            if not err then
               start(args.buf, lang)
            end
         end))
      end
   end,
})

-- Display the context of the cursor in a sticky header
require('treesitter-context').setup()

-- LSP config
vim.pack.add({
   'https://github.com/neovim/nvim-lspconfig',
   'https://github.com/mason-org/mason.nvim',
   'https://github.com/mason-org/mason-lspconfig.nvim',
})

vim.lsp.enable({
   'cssls',
   'eslint',
   'expert',
   'html',
   'intelephense',
   'jsonls',
   'lua_ls',
   'marksman',
   'ruff',
   'shopify_theme_ls',
   'tailwindcss',
   'tinymist',
   'ts_ls',
   'ty',
   'yamlls'
})

require('mason').setup()
require('mason-lspconfig').setup({
   ensure_installed = vim.tbl_keys(vim.lsp._enabled_configs),
})

-- Spell checking and line wrapping for prose
vim.api.nvim_create_autocmd('FileType', {
   pattern = 'markdown',
   callback = function()
      vim.opt_local.spell = true
      vim.opt_local.wrap = true
   end,
})

-- zk (Zettelkasten notebook)
vim.pack.add({'https://github.com/zk-org/zk-nvim'})

require('zk').setup({ picker = 'minipick' })

vim.keymap.set('n', '<leader>nn', function() vim.cmd('ZkNew { title = vim.fn.input("Title: ") }') end, { desc = 'New note' })
vim.keymap.set('n', '<leader>no', function() vim.cmd('ZkNotes { sort = { "modified" } }') end, { desc = 'Open note' })
vim.keymap.set('n', '<leader>nt', function() vim.cmd('ZkTags') end, { desc = 'Browse tags' })
vim.keymap.set('n', '<leader>nf', function() vim.cmd('ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }') end, { desc = 'Find notes' })

-- Diffview (git diff and file history views)
vim.pack.add({'https://github.com/dlyongemallo/diffview-plus.nvim'})

require('diffview').setup()

vim.keymap.set('n', '<leader>gv', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview open' })
vim.keymap.set('n', '<leader>gV', '<cmd>DiffviewClose<cr>', { desc = 'Diffview close' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory<cr>', { desc = 'File history (repo)' })
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', { desc = 'File history (current)' })

-- Open a Diffview against the commit sha reported by the `git last` alias
vim.api.nvim_create_user_command('DiffLast', function()
   local sha = vim.trim(vim.fn.system({ 'git', 'last' }))
   if vim.v.shell_error ~= 0 or sha == '' then
      vim.notify('git last failed: ' .. sha, vim.log.levels.ERROR)
      return
   end
   vim.cmd('DiffviewOpen ' .. sha)
end, { desc = 'Diffview of the commit from `git last`' })

-- Snacks
vim.pack.add({'https://github.com/folke/snacks.nvim'})

require('snacks').setup({
   explorer = { enabled = true, replace_netrw = false },
   gitbrowse = { enabled = true },
   image = { enabled = true },
   lazygit = { enabled = true },
   terminal = { enabled = true },
})

vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File explorer' })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = 'Git blame line' })
vim.keymap.set({ 'n', 'x' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git browse' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Toggle lazygit' })
vim.keymap.set({ 'n' }, '<leader>t', function() Snacks.terminal.toggle() end, { desc = 'Toggle terminal' })

-- Trouble
vim.pack.add({'https://github.com/folke/trouble.nvim'})

require('trouble').setup()

vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols overview' })

-- Sidekick (AI CLI)
vim.pack.add({'https://github.com/folke/sidekick.nvim'})

require('sidekick').setup()

vim.keymap.set('n', '<leader>cp', function() require('sidekick.cli').toggle({ name = 'pi', focus = true }) end, { desc = 'Toggle pi' })

-- Oil (buffer-based file explorer)
vim.pack.add({'https://github.com/stevearc/oil.nvim'})

require('oil').setup()

vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Open Oil' })

-- Taskwarrior
vim.pack.add({'https://github.com/MattHandzel/taskwarrior.nvim'})

require('taskwarrior').setup()

-- Claude Code (native WebSocket/MCP integration; uses snacks.nvim for its terminal)
vim.pack.add({'https://github.com/coder/claudecode.nvim'})

require('claudecode').setup()

vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
vim.keymap.set('n', '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
vim.keymap.set('n', '<leader>cr', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
vim.keymap.set('n', '<leader>cC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
vim.keymap.set('n', '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
vim.keymap.set('n', '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
vim.keymap.set('x', '<leader>cv', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send selection to Claude' })
vim.keymap.set('n', '<leader>ct', '<cmd>ClaudeCodeTreeAdd<cr>', { desc = 'Add file from tree' })
vim.keymap.set('n', '<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
vim.keymap.set('n', '<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })
