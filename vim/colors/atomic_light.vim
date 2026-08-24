" Atomic Light
" A Vimscript port of atomic.nvim's light style; hexes match
" nvim/colors/atomic.lua and ghostty/themes/atomic_light.

set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

if has("termguicolors")
  set termguicolors
endif

let g:colors_name = "atomic_light"

let s:bg        = "#f2f0e8"
let s:bg_surf   = "#e9e7df"
let s:bg_elem   = "#cbc8bc"
let s:border    = "#d4d1c7"
let s:fg        = "#2a2920"
let s:muted     = "#4a4538"
let s:faint     = "#8a8478"
let s:accent    = "#b84820"

let s:red       = "#b83a2e"
let s:amber     = "#a07828"
let s:yellow    = "#8a7520"
let s:green     = "#3a7a4a"
let s:blue      = "#3a6a90"
let s:teal      = "#1a8580"
let s:purple    = "#6a558a"
let s:pink      = "#a85878"

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
