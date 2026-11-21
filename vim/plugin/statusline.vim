" Powerline status line, after mini.statusline's default layout as set up in
" nvim/lua/plugins/mini.lua:
"   mode > git > filename ... fileinfo + words < search, location
" Sections shrink as the window narrows, like mini's trunc_width.
" Glyphs are written as \u escapes so they survive editing.

let s:PL_BRANCH = ""
let s:PL_LINE   = ""
let s:PL_COL    = ""
let s:SEP_L     = ""
let s:SEP_R     = ""

" mode() -> [long name, short name, highlight suffix]
let s:modes = {
      \ 'n':      ['NORMAL',   'N',   'Normal'],
      \ 'v':      ['VISUAL',   'V',   'Visual'],
      \ 'V':      ['V-LINE',   'V-L', 'Visual'],
      \ "\<C-v>": ['V-BLOCK',  'V-B', 'Visual'],
      \ 's':      ['SELECT',   'S',   'Visual'],
      \ 'S':      ['S-LINE',   'S-L', 'Visual'],
      \ "\<C-s>": ['S-BLOCK',  'S-B', 'Visual'],
      \ 'i':      ['INSERT',   'I',   'Insert'],
      \ 'R':      ['REPLACE',  'R',   'Replace'],
      \ 'c':      ['COMMAND',  'C',   'Command'],
      \ 'r':      ['PROMPT',   'P',   'Other'],
      \ '!':      ['SHELL',    'Sh',  'Other'],
      \ 't':      ['TERMINAL', 'T',   'Other'],
      \ }

function! s:truncated(width) abort
  return winwidth(g:statusline_winid) < a:width
endfunction

" Like mini's combine_groups(): a highlight, then the non-empty strings
" padded with spaces. An empty group still sets its highlight so the
" surrounding wedges keep their colors.
function! s:group(hl, strings) abort
  let l:parts = filter(copy(a:strings), 'v:val !=# ""')
  return '%#' . a:hl . '#' . (empty(l:parts) ? '' : ' ' . join(l:parts, ' ') . ' ')
endfunction

function! s:mode() abort
  let l:m = get(s:modes, mode(), get(s:modes, mode()[0], ['UNKNOWN', 'U', 'Other']))
  return [s:truncated(120) ? l:m[1] : l:m[0], 'StatusLineMode' . l:m[2]]
endfunction

" The branch is looked up when a buffer is entered or written, not on every
" redraw.
function! s:update_git() abort
  let l:dir = expand('%:p:h')
  if &buftype !=# '' || !isdirectory(l:dir)
    let b:status_git = ''
    return
  endif
  let l:branch = trim(system('git -C ' . shellescape(l:dir) . ' branch --show-current 2>/dev/null'))
  let b:status_git = v:shell_error ? '' : l:branch
endfunction

function! s:git() abort
  let l:branch = getbufvar(winbufnr(g:statusline_winid), 'status_git', '')
  if l:branch ==# '' || s:truncated(40)
    return ''
  endif
  return s:PL_BRANCH . ' ' . substitute(l:branch, '%', '%%', 'g')
endfunction

function! s:filename() abort
  if &buftype ==# 'terminal'
    return '%t'
  endif
  return (s:truncated(140) ? '%f' : '%F') . '%m%r'
endfunction

function! s:filesize() abort
  let l:size = line2byte(line('$') + 1) - 1
  if l:size < 1024
    return max([l:size, 0]) . 'B'
  elseif l:size < 1048576
    return printf('%.2fKiB', l:size / 1024.0)
  endif
  return printf('%.2fMiB', l:size / 1048576.0)
endfunction

function! s:fileinfo() abort
  if &filetype ==# ''
    return ''
  endif
  if s:truncated(120)
    return &filetype
  endif
  let l:enc = &fileencoding !=# '' ? &fileencoding : &encoding
  return printf('%s %s[%s] %s', &filetype, l:enc, &fileformat, s:filesize())
endfunction

" Words in the buffer, or selected/total while in Visual mode.
function! s:words() abort
  if &buftype !=# ''
    return ''
  endif
  let l:wc = wordcount()
  let l:count = has_key(l:wc, 'visual_words')
        \ ? l:wc.visual_words . '/' . l:wc.words
        \ : l:wc.words
  return l:count . (s:truncated(120) ? 'w' : ' words')
endfunction

function! s:searchcount() abort
  if !v:hlsearch || s:truncated(75)
    return ''
  endif
  try
    let l:sc = searchcount({'recompute': 1, 'maxcount': 999})
  catch
    return ''
  endtry
  if get(l:sc, 'total', 0) == 0
    return ''
  endif
  let l:total = l:sc.incomplete == 2 ? '>' . l:sc.maxcount : l:sc.total
  return l:sc.current . '/' . l:total
endfunction

function! s:location() abort
  if s:truncated(75)
    return s:PL_LINE . '%l ' . s:PL_COL . '%2v'
  endif
  return s:PL_LINE . '%l/%L ' . s:PL_COL . '%2v/%-2{virtcol("$") - 1}'
endfunction

function! StatusLine() abort
  if g:statusline_winid != win_getid()
    return '%#StatusLineInactive# %F%m%='
  endif
  let [l:mode, l:mode_hl] = s:mode()
  return s:group(l:mode_hl, [l:mode])
        \ . '%#' . l:mode_hl . 'SepL#' . s:SEP_L
        \ . s:group('StatusLineDevinfo', [s:git()])
        \ . '%#StatusLineDevinfoSep#' . s:SEP_L
        \ . '%<'
        \ . s:group('StatusLineFilename', [s:filename()])
        \ . '%='
        \ . '%#StatusLineFileinfoSep#' . s:SEP_R
        \ . s:group('StatusLineFileinfo', [s:fileinfo(), s:words()])
        \ . '%#' . l:mode_hl . 'SepR#' . s:SEP_R
        \ . s:group(l:mode_hl, [s:searchcount(), s:location()])
endfunction

" Wedge highlights: the nearer segment's background as fg over the farther
" one's. Each mode gets a left and right group; the filename boundaries get
" one each. Groups the colorscheme doesn't define fall back to StatusLine.
function! s:bg(name) abort
  let l:id = hlexists(a:name) ? hlID(a:name) : hlID('StatusLine')
  let l:bg = synIDattr(synIDtrans(l:id), 'bg#', 'gui')
  return l:bg !=# '' ? l:bg : 'NONE'
endfunction

function! s:sep(name, fg, bg) abort
  execute 'hi' a:name 'guifg=' . s:bg(a:fg) 'guibg=' . s:bg(a:bg) 'gui=NONE cterm=NONE'
endfunction

function! s:define_separators() abort
  for l:m in ['Normal', 'Insert', 'Visual', 'Replace', 'Command', 'Other']
    let l:hl = 'StatusLineMode' . l:m
    call s:sep(l:hl . 'SepL', l:hl, 'StatusLineDevinfo')
    call s:sep(l:hl . 'SepR', l:hl, 'StatusLineFileinfo')
  endfor
  call s:sep('StatusLineDevinfoSep',  'StatusLineDevinfo',  'StatusLineFilename')
  call s:sep('StatusLineFileinfoSep', 'StatusLineFileinfo', 'StatusLineFilename')
endfunction

augroup statusline
  autocmd!
  autocmd BufEnter,BufWritePost,FocusGained,ShellCmdPost * call s:update_git()
  autocmd ColorScheme * call s:define_separators()
  " Vim's colorresp plugin sets 'background' from the terminal's reply inside
  " an autocommand, so the colorscheme reload it causes fires no ColorScheme
  " event. It does fire this one afterwards.
  autocmd TermResponseAll background call s:define_separators()
augroup END

call s:define_separators()

set noshowmode
set laststatus=2
set statusline=%!StatusLine()
