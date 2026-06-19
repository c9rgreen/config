-- Options
vim.opt.clipboard:append('unnamedplus')
vim.opt.virtualedit = 'all'
vim.opt.fillchars = { diff = '╱' }
vim.opt.wildignorecase = true
vim.opt.shell = 'fish'
vim.opt.diffopt:append('vertical,iwhiteall,algorithm:histogram')
vim.opt.splitright = true
vim.opt.number = false
vim.opt.path:append { '**' }
vim.opt.wildoptions:append('fuzzy')
vim.opt.foldlevel = 5

-- Use virtual text for diagnostics
vim.diagnostic.config({ virtual_text = true })

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

-- Packages
vim.pack.add({
   'https://github.com/nvim-mini/mini.nvim',
   'https://github.com/nvim-treesitter/nvim-treesitter',
   'https://github.com/nvim-treesitter/nvim-treesitter-context',
   'https://github.com/neovim/nvim-lspconfig',
   'https://github.com/mason-org/mason.nvim',
   'https://github.com/mason-org/mason-lspconfig.nvim',
   'https://github.com/zk-org/zk-nvim',
   'https://github.com/ThorstenRhau/token',
   'https://github.com/folke/snacks.nvim',
   'https://github.com/folke/trouble.nvim',
   'https://github.com/folke/sidekick.nvim',
})

-- Mini
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
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.align').setup()
require('mini.sessions').setup()

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
      { mode = 'n', keys = '<Leader>n', desc = 'Notes' },
      { mode = 'n', keys = '<Leader>a', desc = 'AI' },
      { mode = 'x', keys = '<Leader>a', desc = 'AI' },
      { mode = 'n', keys = '<Leader>g', desc = 'Git' },
      { mode = 'n', keys = '<Leader>c', desc = 'Code' },
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
vim.keymap.set('n', '-', function() MiniFiles.open() end, { desc = 'File browser' })

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
require('zk').setup({ picker = 'minipick' })

vim.keymap.set('n', '<leader>nn', function() vim.cmd('ZkNew { title = vim.fn.input("Title: ") }') end, { desc = 'New note' })
vim.keymap.set('n', '<leader>no', function() vim.cmd('ZkNotes { sort = { "modified" } }') end, { desc = 'Open note' })
vim.keymap.set('n', '<leader>nt', function() vim.cmd('ZkTags') end, { desc = 'Browse tags' })
vim.keymap.set('n', '<leader>nf', function() vim.cmd('ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }') end, { desc = 'Find notes' })

-- Snacks
require('snacks').setup({
   explorer = { enabled = true, replace_netrw = false },
   gitbrowse = { enabled = true },
   image = { enabled = true },
   lazygit = { enabled = true },
})

vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File explorer' })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = 'Git blame line' })
vim.keymap.set({ 'n', 'x' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git browse' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Toggle lazygit' })

-- Trouble
require('trouble').setup()

vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols overview' })

-- Sidekick (AI CLI)
require('sidekick').setup()

vim.keymap.set('n', '<leader>cc', function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end, { desc = 'Toggle Claude' })
vim.keymap.set('x', '<leader>cv', function() require('sidekick.cli').send({ msg = '{selection}' }) end, { desc = 'Send selection to Claude' })

-- New UI
require('vim._core.ui2').enable({})

-- Colorscheme
vim.cmd.colorscheme('token')
