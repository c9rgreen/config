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
vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden --follow'
vim.opt.path = '$PWD/**'
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Behavior
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 5
vim.opt.eb = false -- No error bells
vim.opt.swapfile = false -- No swap file
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.virtualedit = 'all'
vim.opt.formatoptions = 'tcroqjn'
vim.opt.termguicolors = false

-- Status line
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

vim.api.nvim_create_user_command('Clear', function()
    vim.cmd("bufdo bwipeout")
end, {})

vim.cmd.colorscheme('wildcharm')

-- Mini (colorscheme, picker, pairs, filebrowser)
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    require('mini.basics').setup()
    require('mini.bracketed').setup()
    require('mini.bufremove').setup()
    require('mini.completion').setup()
    require('mini.cursorword').setup()
    require('mini.diff').setup()
    require('mini.extra').setup()
    require('mini.fuzzy').setup()
    require('mini.git').setup()
    require('mini.hipatterns').setup()
    require('mini.map').setup()
    require('mini.notify').setup()
    require('mini.pairs').setup()
    require('mini.starter').setup()
    require('mini.statusline').setup()
    require('mini.surround').setup()
    require('mini.tabline').setup()

    require('mini.indentscope').setup({
        symbol = "░"
    })

    require('mini.files').setup()
    require('mini.pick').setup()

    local hipatterns = require('mini.hipatterns')

    hipatterns.setup({
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    vim.api.nvim_create_autocmd({'Colorscheme'}, {
        group = vim.api.nvim_create_augroup('Mini Fixes', { clear = true }),
        callback = function()
            -- vim.cmd('highlight link MiniPickMatchCurrent Cursor')
            vim.cmd('highlight link MiniIndentscopeSymbol EndofBuffer')
        end
    })

end)

-- Treesitter (highlight, edit, navigate code)
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    })

    require('nvim-treesitter.configs').setup({
        ensure_installed = { "html", "javascript", "python", "lua", "css", "bash", "go", "gomod", "dockerfile",
            "gitcommit", "json", "latex", "rst", "markdown", "yaml", "vimdoc", "vim", "vue",
        },
        highlight = { enable = true },
        indent = {
            enable = true,
        },
    })
end)

-- LSP
later(function()
    add('williamboman/mason.nvim')
    add('williamboman/mason-lspconfig.nvim')
    add('neovim/nvim-lspconfig')

    require('mason').setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls", "tsserver", "volar", "cssls", "html", "jsonls", "gopls", "tailwindcss", "theme_check",
        },
    })

    require("mason-lspconfig").setup_handlers {
        function (server_name)
            require("lspconfig")[server_name].setup({
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
        end,

        ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
                on_attach = on_attach,
                setings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim', 'MiniDeps' }
                        }
                    }
                }
            })
        end,
    }
end)          

