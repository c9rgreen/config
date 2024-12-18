" vim: filetype=vim foldmethod=marker foldlevel=0

filetype plugin indent on
syntax enable

colorscheme solarized8

" Options {{
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

" Status line {{{
" Reset status line
set statusline=
" Working directory
set statusline+=\[%<%{fnamemodify(getcwd(),':t')}]
" Filename
set statusline+=\ %f
" Modified flag
set statusline+=%m
" Everything after this right-aligned
set statusline+=%=
" Filetype
set statusline+=\ %y
" File encoding
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" Percentage through the file
set statusline+=\ %p%%
" Location
set statusline+=\ %l:%c
" Word count
set statusline+=\ w%{wordcount().words}
" }}}

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
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:\ ,foldopen:\ ,foldsep:\ ,diff:-
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
set termguicolors

" Make lifepillar/solarized8 work with Terminal.app {{{
" The active profile in Terminal.app must already be configured to use the
" Solarized color palette.
" https://github.com/lifepillar/vim-solarized8#but-my-terminal-has-only-256-colors
" set t_Co=16
" }}}

if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
endif

" Use <space> instead of <\> as the leader key
let mapleader = "\<Space>"

" Commands
command! Search :execute 'vimgrep '.expand('<cword>').' **/*' | :copen | :cc

" Abbreviations {{{
iabbrev <expr> :date: strftime("%Y-%m-%d")
iabbrev <expr> [[]] strftime("[[%Y%m%d%H%M%S]]")
iabbrev :qa: (🦺 QA Verify)
" }}}

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

" Fugitive {{{
nnoremap <leader>m :Gdiff main<CR>
" }}}


" CtrlP {{{
if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif

nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPTag<CR>
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
" }}}

" Editorconfig
packadd! editorconfig

" Markdown {{{
" Enable folding in markdown
let g:markdown_folding = 1
" Highlight fenced code in markdown
let g:markdown_fenced_languages = ['html', 'javascript', 'mermaid']
" }}}

" ALE {{{

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
" let g:ale_javascript_tsserver_options = '-p jsconfig.json'

" }}}

" NetRW
let g:netrw_liststyle = 3

" LSP {{{
if executable('typescript-language-server') && executable('volar-server')
  let g:lsp_settings_filetype_vue = ['typescript-language-server', 'volar-server']
endif

let g:lsp_diagnostics_virtual_text_align = "right"
let g:lsp_diagnostics_virtual_text_wrap = "truncate"
" }}}

" Async Complete {{{
" OmniComplete
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
    \ 'name': 'omni',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['c', 'cpp', 'html'],
    \ 'completor': function('asyncomplete#sources#omni#completor'),
    \ 'config': {
    \   'show_source_kind': 1,
    \ },
    \ }))

" Emmet
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({
    \ 'name': 'emmet',
    \ 'whitelist': ['html'],
    \ 'completor': function('asyncomplete#sources#emmet#completor'),
    \ }))

" Buffer
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
" }}}

" Get highlight group under cursor {{{
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
" }}}

" Change the cursor shape depending on mode
" https://stackoverflow.com/questions/12030278/how-to-change-cursor-shape-in-vim-when-entering-insert-mode-with-macos-terminal
let &t_SI="\033[5 q" " Blinking bar for insert mode
let &t_EI="\033[2 q" " Steady block for normal mode

" MacVim {{{
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
    set guifont=BerkeleyMono-Regular:h14
endif
" }}}

" LilyPond
set runtimepath+=/opt/homebrew/share/lilypond/2.24.3/vim
