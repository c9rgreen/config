filetype plugin indent on

syntax enable

colorscheme modus

" Options
set nocompatible
set autoindent
set smartindent
set infercase
set nowrap
set linebreak
set breakindent
set hidden
set guioptions=mc
set clipboard^=unnamed,unnamedplus
set formatoptions=tcroqjn
set showmatch
set expandtab
set tabstop=4
set shiftwidth=0
set diffopt=vertical
set autowrite
set autowriteall
set shortmess+=Ic
set noswapfile
set showcmd
set hlsearch
set incsearch
set wildmenu
set wildignore+=*.git,*venv/*,*node_modules/*,*vendor/*,*__pycache__/*,*.aux,*.cls,*dist/*,*output/*,tags
set wildignorecase
set statusline=
set statusline+=\[%<%{fnamemodify(getcwd(),':t')}]\ 
set statusline+=\ %f\ 
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ w%{wordcount().words}
set spelllang=en_us
set tags^=./.git/tags
set laststatus=2
set showtabline=2
set foldlevel=5
set foldmethod=indent
set virtualedit=all
set isfname+=32
set belloff+=ctrlg
set mouse=a
set number
set ttyfast
set signcolumn=yes
set fillchars+=vert:\ 
set fillchars+=fold:\ 
set completeopt=menu,menuone,preview,noselect,longest
set omnifunc=syntaxcomplete#Complete
set cursorline
set backspace=indent,eol,start
set smarttab
set ttimeout
set ttimeoutlen=100
set ruler
set scrolloff=5
set sidescroll=1
set sidescrolloff=5
set display+=lastline
set display+=truncate
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set sessionoptions-=options
set viewoptions-=options
set nolangremap
set linespace=1

" Make solarized work with Terminal.app
" The active profile in Terminal.app must already be configured to use the
" Solarized color palette.
" https://github.com/lifepillar/vim-solarized8#but-my-terminal-has-only-256-colors
" set t_Co=16

if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
endif

" Use <space> instead of <\> as the leader key
let mapleader = "\<Space>"

" Commands
command! Search :execute 'vimgrep '.expand('<cword>').' **/*' | :copen | :cc

" Abbreviations
iabbrev <expr> :date: strftime("%Y-%m-%d")
iabbrev <expr> [[]] strftime("[[%Y%m%d%H%M%S]]")
iabbrev :qa: (🦺 QA Verify)

" Mappings
noremap <silent> k gk
noremap <silent> j gj
vnoremap < <gv
vnoremap > >gv

" Terminal mode mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

" Go to file
nnoremap <leader>e :edit **/*

" Edit a neigboring file
nnoremap <leader>n :e <C-R>=expand("%:p:h") . "/" <CR>

" Go to buffer
nnoremap <leader>r :buffer **/*

" Go to tag
nnoremap <leader>a :tag *

" Hard wrap
nnoremap <leader>h gqip$

" List buffers
nnoremap ,, :ls<CR>

" CtrlP
if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif

nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPTag<CR>

" Editorconfig
packadd! editorconfig

" Variables
let g:markdown_folding = 1


" Plugins
" ALE
" CtrlP
" vim-commentary
" vim-flagship
" vim-fugitive
" vim-unimpaired
" vim-vinegar
" vim-go
" vim-fern
" emmet-vim
" vim-gutentags
" vista.vim

" ALE
set omnifunc=ale#completion#OmniFunc

" Autocomplete
let g:ale_completion_enabled = 1

" Use Prettier for code formatting
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'vue': ['prettier'],
\   'json': ['prettier'],
\}

let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'vue': ['eslint', 'typescript', 'volar'],
\}

" let g:ale_vue_volar_init_options = {'typescript': {'tsdk': '/Users/cgreen/.npm-global/lib/node_modules/typescript/lib/'}}
let g:ale_javascript_tsserver_options = '-p jsconfig.json'

" NERDTree
let NERDTreeMinimalUI=1

nnoremap <leader>n :NERDTreeToggle<CR>

" Get highlight group under cursor
" https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>

" Change the cursor shape depending on mode
" https://stackoverflow.com/questions/12030278/how-to-change-cursor-shape-in-vim-when-entering-insert-mode-with-macos-terminal
let &t_SI="\033[5 q" " Blinking bar for insert mode
let &t_EI="\033[2 q" " Steady block for normal mode

" MacVim
if has('gui_macvim')
    function! MacAppearance()
        if v:os_appearance == 1
            set background=dark
        else
            set background=light
        endif
    endfunction

    augroup Appearance
        autocmd!
        autocmd OSAppearanceChanged * call MacAppearance()
    augroup END

    set macligatures
    set guifont=SFMono-Regular:h13
endif

" LilyPond
" set runtimepath+=/opt/homebrew/share/lilypond/2.24.3/vim
