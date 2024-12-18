-- cgreen's Neovim config
vim.cmd('filetype plugin indent on')

-- Options
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.mouse = 'a'

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Appearance
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'yes'
vim.opt.fillchars = 'eob: '

-- Search
vim.opt.magic = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignorecase = true
-- vtermguicolors = false

-- Status line (overridden by mini.nvim)
vim.opt.statusline = '[%<%{fnamemodify(getcwd(),":t")}] %f %m %= %y %{&fileencoding?&fileencoding:&encoding} %p%% %l:%c w%{wordcount().words}'

-- Use space for leader
vim.g.mapleader = ' '

-- Mappings
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<leader>c', ':!cat % | pbcopy<CR>')
vim.keymap.set('n', '<A-Right>', ':bn<CR>')
vim.keymap.set('n', '<A-Left>', ':bp<CR>')
vim.keymap.set('n', '<A-Up>', ':tabn<CR>')
vim.keymap.set('n', '<A-Down>', ':tabp<CR>')
vim.keymap.set('n', '-', ':lua MiniFiles.open()<CR>')
vim.keymap.set('n', '<leader>p', ':lua MiniPick.builtin.files()<CR>')
vim.keymap.set('n', '<leader>g', ':lua MiniPick.builtin.grep_live()<CR>')
vim.keymap.set('n', '<leader>b', ':lua MiniPick.builtin.buffers()<CR>')
vim.keymap.set('n', '<leader>h', ':lua MiniPick.builtin.help()<CR>')
vim.keymap.set('n', '<leader>l', ':lua MiniExtra.pickers.lsp({ scope = "document_symbol" })<CR>')
vim.keymap.set('n', 'd<Space>', ':lua MiniBufremove.delete()<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- In terminal mode, use Esc to go back to normal mode
vim.keymap.set('t', '<C-v><Esc>', '<Esc>') -- Use C-v Esc to send Esc in terminal mode

-- Colorscheme
vim.cmd.colorscheme('retrobox')

-- Override highlight groups
vim.api.nvim_create_autocmd({'Colorscheme'}, {
  group = vim.api.nvim_create_augroup('Mini Fixes', { clear = true }),
  callback = function()
    -- vim.cmd('highlight link MiniPickMatchCurrent Cursor')
    -- vim.cmd('highlight link MiniCursorword EndofBuffer')
    vim.cmd('highlight link MiniIndentscopeSymbol LineNr')
  end
})

-- Delete buffer without closing window
vim.api.nvim_create_user_command('Clear', function()
    vim.cmd("bufdo bwipeout")
end, {})

-- Biome (for JavaScript formatting)
vim.api.nvim_create_augroup('biome', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'biome',
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' },
  callback = function()
    vim.bo.formatprg = 'biome format --stdin-file-path=%'
  end,
})

-- Initialize mini.nvim; automatically clone it if necessary...
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- ...end. Now we are ready to use use mini.nvim.

now(function()
    require('mini.basics').setup()
    require('mini.bracketed').setup()
    require('mini.bufremove').setup()
    require('mini.completion').setup()
    require('mini.cursorword').setup()
    require('mini.diff').setup()
    require('mini.extra').setup()
    require('mini.files').setup()
    require('mini.fuzzy').setup()
    require('mini.git').setup()
    require('mini.hipatterns').setup()
    require('mini.icons').setup({ style = 'ascii' })
    require('mini.indentscope').setup({ symbol = "🞍" })
    require('mini.map').setup()
    require('mini.notify').setup()
    require('mini.pairs').setup()
    require('mini.pick').setup()
    require('mini.sessions').setup()
    require('mini.starter').setup()
    require('mini.statusline').setup({ use_icons = false })
    require('mini.surround').setup()
    require('mini.tabline').setup()
    require('mini.hipatterns').setup({
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    })
end)

--
-- LSP
--
-- npm install -g
-- typescript typescript-language-server
-- @vue/typescript-plugin
-- @vue/language-server
-- Use absolute paths. Relative paths like "~/" do not work

later(function()
  add("neovim/nvim-lspconfig")

  -- JavaScript/Typescript language server with Vue plugin
  require('lspconfig').ts_ls.setup {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/Users/cgreen/.npm-global/lib/node_modules/@vue/typescript-plugin",
          languages = {"javascript", "typescript", "vue"},
        },
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
  }

  -- Vue language server
  require('lspconfig').volar.setup {
    init_options = {
      typescript = {
        tsdk = '/Users/cgreen/.npm-global/lib/node_modules/typescript/lib'
      }
    }
  }
end)

--
-- Treesitter
--
-- Don't forget to install the tree-sitter CLI
-- Treesitter (highlight, edit, navigate code)
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    })

    require('nvim-treesitter.configs').setup({
        ensure_installed = { "html", "javascript", "python", "lua", "css", "bash", "dockerfile",
            "gitcommit", "json", "rst", "markdown", "yaml", "vimdoc", "vim", "vue",
        },
        highlight = { enable = true },
        indent = {
            enable = true,
        },
    })
end)

