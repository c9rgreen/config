" Monokai Pro Light
" From Monokai Pro (https://monokai.pro/), following the "light" filter of
" loctvl842/monokai-pro.nvim (lua/monokai-pro/palette/light.lua):
" https://github.com/loctvl842/monokai-pro.nvim
" Hexes match nvim/colors/monokai-pro.lua and Ghostty's bundled
" "Monokai Pro Light" theme.

set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

if has("termguicolors")
  set termguicolors
endif

let g:colors_name = "monokai_pro_light"

let s:bg        = "#faf4f2"
let s:dark1     = "#ede7e5"
let s:dark2     = "#d3cdcc"
let s:line      = "#f0eae8"
let s:sel       = "#bfb9ba"
let s:text      = "#29242a"
let s:dimmed1   = "#706b6e"
let s:dimmed2   = "#918c8e"
let s:dimmed3   = "#a59fa0"
let s:dimmed4   = "#bfb9ba"
let s:dimmed5   = "#d3cdcc"
let s:knock     = "#29242a"

let s:red       = "#e14775"
let s:orange    = "#e16032"
let s:yellow    = "#cc7a0a"
let s:green     = "#269d69"
let s:cyan      = "#1c8ca8"
let s:purple    = "#7058be"

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

call s:hi("Normal",        s:text,     s:bg,      "")
call s:hi("Cursor",        s:bg,       s:dimmed1, "")
call s:hi("CursorLine",    "",         s:line,    "")
call s:hi("CursorColumn",  "",         s:line,    "")
call s:hi("ColorColumn",   "",         s:dimmed5, "")
call s:hi("LineNr",        s:dimmed4,  s:bg,      "")
call s:hi("CursorLineNr",  s:dimmed1,  s:bg,      "bold")
call s:hi("SignColumn",    s:dimmed4,  s:bg,      "")
call s:hi("FoldColumn",    s:dimmed1,  s:bg,      "")
call s:hi("Folded",        s:text,     s:dimmed5, "")
call s:hi("NonText",       s:dimmed4,  "",        "")
call s:hi("SpecialKey",    s:dimmed4,  "",        "")
call s:hi("EndOfBuffer",   s:bg,       "",        "")
call s:hi("MatchParen",    s:yellow,   "NONE",    "bold,underline")
call s:hi("VertSplit",     s:dark1,    s:bg,      "none")
call s:hi("StatusLine",    s:dimmed1,  s:dark2,   "none")
call s:hi("StatusLineNC",  s:dimmed3,  s:dark2,   "none")
call s:hi("TabLine",       s:dimmed2,  s:dark1,   "none")
call s:hi("TabLineFill",   s:dimmed2,  s:dark1,   "none")
call s:hi("TabLineSel",    s:yellow,   s:bg,      "none")
call s:hi("Pmenu",         s:dimmed2,  s:dimmed5, "")
call s:hi("PmenuSel",      s:text,     s:dimmed3, "bold")
call s:hi("PmenuSbar",     "",         s:dimmed5, "")
call s:hi("PmenuThumb",    "",         s:dimmed4, "")
call s:hi("Visual",        "",         s:sel,     "")
call s:hi("Search",        "",         s:dimmed4, "")
call s:hi("IncSearch",     s:knock,    s:yellow,  "bold")
call s:hi("Title",         s:yellow,   "",        "bold")
call s:hi("MoreMsg",       s:yellow,   "",        "")
call s:hi("ErrorMsg",      s:red,      "",        "")
call s:hi("WarningMsg",    s:orange,   "",        "")
call s:hi("Directory",     s:green,    "",        "")
call s:hi("DiffAdd",       s:green,    s:dark1,   "")
call s:hi("DiffChange",    s:orange,   s:dark1,   "")
call s:hi("DiffDelete",    s:red,      s:dark1,   "")
call s:hi("DiffText",      s:text,     s:dimmed5, "")
call s:hi("SpellBad",      "",         "",        "undercurl")
call s:hi("SpellCap",      "",         "",        "undercurl")

" Syntax groups, per upstream: comments italic; keywords, operators,
" includes, storage and tags red; constants, numbers and Statement proper
" purple; strings yellow; functions green; types and structures cyan;
" specials and parameters orange; identifiers and delimiters plain text.
call s:hi("Comment",       s:dimmed3,  "",        "italic")
call s:hi("Constant",      s:purple,   "",        "")
call s:hi("String",        s:yellow,   "",        "")
call s:hi("Character",     s:purple,   "",        "")
call s:hi("Number",        s:purple,   "",        "")
call s:hi("Boolean",       s:purple,   "",        "")
call s:hi("Float",         s:purple,   "",        "")
call s:hi("Identifier",    s:text,     "",        "")
call s:hi("Function",      s:green,    "",        "")
call s:hi("Statement",     s:purple,   "",        "")
call s:hi("Conditional",   s:red,      "",        "")
call s:hi("Repeat",        s:red,      "",        "")
call s:hi("Label",         s:red,      "",        "")
call s:hi("Operator",      s:red,      "",        "")
call s:hi("Keyword",       s:red,      "",        "italic")
call s:hi("Exception",     s:red,      "",        "")
call s:hi("PreProc",       s:yellow,   "",        "")
call s:hi("Include",       s:red,      "",        "")
call s:hi("Define",        s:red,      "",        "")
call s:hi("Macro",         s:red,      "",        "")
call s:hi("PreCondit",     s:red,      "",        "")
call s:hi("Type",          s:cyan,     "",        "")
call s:hi("StorageClass",  s:red,      "",        "italic")
call s:hi("Structure",     s:cyan,     "",        "italic")
call s:hi("Typedef",       s:red,      "",        "")
call s:hi("Special",       s:orange,   "",        "")
call s:hi("SpecialChar",   s:orange,   "",        "")
call s:hi("Tag",           s:red,      "",        "")
call s:hi("Delimiter",     s:text,     "",        "")
call s:hi("SpecialComment", s:dimmed3, "",        "")
call s:hi("Underlined",    s:orange,   "",        "underline")
call s:hi("Error",         s:red,      "",        "bold")
call s:hi("Todo",          s:purple,   "",        "bold")
