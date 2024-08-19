filetype plugin indent on

syntax enable

colorscheme wildcharm

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
" set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

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
  let g:ctrlp_user_command = 'find %s -type f'
  let g:ctrlp_use_caching = 0
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

" Airline
"let g:airline_theme='wildcharm'

" ALE
set omnifunc=ale#completion#OmniFunc

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
set runtimepath+=/opt/homebrew/share/lilypond/2.24.3/vim

