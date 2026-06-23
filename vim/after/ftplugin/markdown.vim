" after/ftplugin/markdown.vim — writing tweaks for markdown buffers

" Spell-check on (spelllang=en_us is set globally in vimrc)
setlocal spell

" Soft-wrap prose at the window edge (global is nowrap);
" linebreak + breakindent are already set globally, and j/k are remapped to gj/gk
setlocal wrap

" Conceal **, _, and link URLs using the built-in markdown syntax;
" keep markup visible on the line the cursor is on so editing stays easy
setlocal conceallevel=2
setlocal concealcursor=

" Emphasis helpers (visual mode): wrap the selection
xnoremap <buffer> <leader>b c**<C-r>"**<Esc>
xnoremap <buffer> <leader>i c*<C-r>"*<Esc>
xnoremap <buffer> <leader>c c`<C-r>"`<Esc>

" Toggle spell quickly
nnoremap <buffer> <leader>s :setlocal spell!<CR>
