" Circadia Forest Dark (Obsidian Pine)
" The official Vim port ships only dark/light; this follows its structure
" with the dark_forest tokens from spec/palette.json:
" https://github.com/tanmaymanojgandhi/circadia
" Hexes match nvim/colors/circadia-forest.lua and
" ghostty/themes/circadia_forest_dark.

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

if has("termguicolors")
  set termguicolors
endif

let g:colors_name = "circadia_forest_dark"

let s:bg        = "#131714"
let s:bg_surf   = "#1a1e1b"
let s:bg_elem   = "#242a25"
let s:border    = "#353c36"
let s:fg        = "#c4ccc5"
let s:muted     = "#9fa9a1"
let s:faint     = "#838d85"
let s:accent    = "#83b384"

let s:keyword   = "#6cb0c5"
let s:type      = "#d1aa73"
let s:func      = "#b29ace"
let s:string    = "#92b87e"
let s:number    = "#d19b66"
let s:comment   = "#909890"

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
call s:hi("Cursor",        s:bg,       s:accent,  "")
call s:hi("CursorLine",    "",         s:bg_surf, "")
call s:hi("CursorColumn",  "",         s:bg_surf, "")
call s:hi("ColorColumn",   "",         s:bg_surf, "")
call s:hi("LineNr",        s:faint,    s:bg,      "")
call s:hi("CursorLineNr",  s:accent,   s:bg_surf, "bold")
call s:hi("MatchParen",    s:accent,   "NONE",    "bold")
call s:hi("VertSplit",     s:border,   s:bg,      "none")
call s:hi("StatusLine",    s:fg,       s:bg_surf, "none")
call s:hi("StatusLineNC",  s:faint,    s:bg_surf, "none")
call s:hi("Pmenu",         s:fg,       s:bg_surf, "")
call s:hi("PmenuSel",      s:bg,       s:accent,  "")
call s:hi("Visual",        "",         s:bg_elem, "")
call s:hi("Search",        s:bg,       s:accent,  "")
call s:hi("IncSearch",     s:bg,       s:accent,  "bold")

" Syntax Groups
call s:hi("Comment",       s:comment,  "",        "italic")
call s:hi("Constant",      s:number,   "",        "")
call s:hi("String",        s:string,   "",        "")
call s:hi("Character",     s:string,   "",        "")
call s:hi("Number",        s:number,   "",        "")
call s:hi("Boolean",       s:number,   "",        "")
call s:hi("Identifier",    s:fg,       "",        "")
call s:hi("Function",      s:func,     "",        "")
call s:hi("Statement",     s:keyword,  "",        "bold")
call s:hi("PreProc",       s:keyword,  "",        "")
call s:hi("Type",          s:type,     "",        "")
call s:hi("Special",       s:keyword,  "",        "")
call s:hi("Underlined",    s:accent,   "",        "underline")
call s:hi("Error",         "#e06c75",  s:bg,      "bold")
call s:hi("Todo",          s:accent,   s:bg_elem, "bold")
