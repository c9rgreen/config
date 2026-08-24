" Atomic Dark
" A Vimscript port of atomic.nvim's flagship navy-teal style; hexes match
" nvim/colors/atomic.lua and ghostty/themes/atomic.

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

if has("termguicolors")
  set termguicolors
endif

let g:colors_name = "atomic_dark"

let s:bg        = "#162830"
let s:bg_surf   = "#1e3038"
let s:bg_elem   = "#354a52"
let s:border    = "#2a3d44"
let s:fg        = "#f5ecd7"
let s:muted     = "#d9cdb8"
let s:faint     = "#8a7d6b"
let s:accent    = "#e05a2d"

let s:red       = "#c9392b"
let s:amber     = "#d4953a"
let s:yellow    = "#e8c547"
let s:green     = "#4dcb8a"
let s:blue      = "#4a7fa5"
let s:teal      = "#2fb8b0"
let s:purple    = "#7b68b0"
let s:pink      = "#c47a98"

function! s:hi(group, guifg, guibg, attr)
  let l:cmd = "hi " . a:group
  if a:guifg != ""
    let l:cmd .= " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let l:cmd .= " guibg=" . a:guibg
  endif
  " Always set gui=, otherwise groups Vim defaults to bold after `hi clear`
  " (Statement, Type) keep that weight.
  let l:cmd .= " gui=" . (a:attr != "" ? a:attr : "none")
  execute l:cmd
endfunction

call s:hi("Normal",        s:fg,       s:bg,      "")
call s:hi("CursorLine",    "",         s:bg_surf, "")
call s:hi("CursorColumn",  "",         s:bg_surf, "")
call s:hi("ColorColumn",   "",         s:bg_surf, "")
call s:hi("LineNr",        s:faint,    s:bg,      "")
call s:hi("CursorLineNr",  s:accent,   s:bg,      "bold")
call s:hi("VertSplit",     s:border,   s:bg,      "none")
call s:hi("StatusLine",    s:muted,    s:bg_surf, "none")
call s:hi("StatusLineNC",  s:faint,    s:bg_surf, "none")
call s:hi("Pmenu",         s:fg,       s:bg_surf, "")
call s:hi("PmenuSel",      s:fg,       s:bg_elem, "")
call s:hi("Visual",        "",         s:bg_elem, "")
call s:hi("Search",        s:bg,       s:yellow,  "")
" Teal, not the accent: ghostty paints the cursor accent-orange, so an
" accent-colored active match would swallow the block cursor.
call s:hi("IncSearch",     s:bg,       s:teal,    "bold")

" Syntax Groups
call s:hi("Comment",       s:faint,    "",        "italic")
call s:hi("Constant",      s:amber,    "",        "")
call s:hi("String",        s:green,    "",        "")
call s:hi("Character",     s:green,    "",        "")
call s:hi("Number",        s:amber,    "",        "")
call s:hi("Boolean",       s:amber,    "",        "")
call s:hi("Identifier",    s:fg,       "",        "")
call s:hi("Function",      s:teal,     "",        "")
call s:hi("Statement",     s:accent,   "",        "")
call s:hi("Operator",      s:muted,    "",        "")
call s:hi("PreProc",       s:pink,     "",        "")
call s:hi("Type",          s:yellow,   "",        "")
call s:hi("StorageClass",  s:purple,   "",        "")
call s:hi("Special",       s:amber,    "",        "")
call s:hi("Underlined",    s:teal,     "",        "underline")
call s:hi("Error",         s:red,      s:bg,      "bold")
call s:hi("Todo",          s:bg,       s:yellow,  "bold")
