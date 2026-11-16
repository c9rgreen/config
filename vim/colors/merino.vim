" merino -- Rex's Merino Light and Merino Dark themes.
" Hexes and role choices match nvim/colors/merino.lua: surfaces and text tiers
" from Rex's semantic tokens, syntax hues from its normal ANSI colors, and
" numbers on ANSI 9 since Merino has no orange.
" 'background' picks the variant, so set it before :colorscheme.

hi clear

if exists("syntax_on")
  syntax reset
endif

if has("termguicolors")
  set termguicolors
endif

let g:colors_name = "merino"

if &background ==# "light"
  " Merino Light
  let s:bg           = "#ffffff"
  let s:bg_surf      = "#eceef2"
  let s:bg_elem      = "#dcdee2"
  let s:border       = "#d1d2d5"
  let s:fg           = "#1f2328"
  let s:muted        = "#696d71"
  let s:faint        = "#878a8e"
  let s:accent       = "#0667d8"
  let s:accent_solid = "#0969da"
  let s:on_accent    = "#ffffff"
  let s:selection    = "#d2e4f8"
  let s:search       = "#e6effc"

  let s:keyword      = "#8250df"
  let s:type         = "#9d5c00"
  let s:func         = "#0969da"
  let s:string       = "#116329"
  let s:number       = "#a40e26"
  let s:special      = "#1b7c83"
  let s:comment      = "#696d71"
  let s:error        = "#cf222e"
  let s:ok           = "#116329"
  let s:info         = "#0969da"
else
  " Merino Dark
  let s:bg           = "#0d1117"
  let s:bg_surf      = "#1e2023"
  let s:bg_elem      = "#2d2f32"
  let s:border       = "#424549"
  let s:fg           = "#e6edf3"
  let s:muted        = "#82878c"
  let s:faint        = "#666a6f"
  let s:accent       = "#3485fa"
  let s:accent_solid = "#2f81f7"
  let s:on_accent    = "#0d1117"
  let s:selection    = "#152946"
  let s:search       = "#142134"

  let s:keyword      = "#bc8cff"
  let s:type         = "#d29922"
  let s:func         = "#58a6ff"
  let s:string       = "#3fb950"
  let s:number       = "#ffa198"
  let s:special      = "#39c5cf"
  let s:comment      = "#82878c"
  let s:error        = "#ff7b72"
  let s:ok           = "#3fb950"
  let s:info         = "#58a6ff"
endif

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

call s:hi("Normal",        s:fg,        s:bg,           "")
call s:hi("Cursor",        s:bg,        s:accent,       "")
call s:hi("CursorLine",    "",          s:bg_surf,      "")
call s:hi("CursorColumn",  "",          s:bg_surf,      "")
call s:hi("ColorColumn",   "",          s:bg_surf,      "")
call s:hi("LineNr",        s:faint,     s:bg,           "")
call s:hi("CursorLineNr",  s:accent,    s:bg_surf,      "bold")
call s:hi("SignColumn",    s:faint,     s:bg,           "")
call s:hi("FoldColumn",    s:faint,     s:bg,           "")
call s:hi("Folded",        s:muted,     s:bg_surf,      "")
call s:hi("NonText",       s:faint,     "",             "")
call s:hi("SpecialKey",    s:faint,     "",             "")
call s:hi("MatchParen",    s:accent,    "NONE",         "bold")
call s:hi("VertSplit",     s:border,    s:bg,           "none")
call s:hi("StatusLine",    s:fg,        s:bg_surf,      "none")
call s:hi("StatusLineNC",  s:faint,     s:bg_surf,      "none")
call s:hi("TabLine",       s:muted,     s:bg_surf,      "none")
call s:hi("TabLineFill",   "",          s:bg_surf,      "none")
call s:hi("TabLineSel",    s:fg,        s:bg,           "bold")
call s:hi("Pmenu",         s:fg,        s:bg_surf,      "")
call s:hi("PmenuSel",      s:fg,        s:bg_elem,      "")
call s:hi("PmenuSbar",     "",          s:bg_surf,      "")
call s:hi("PmenuThumb",    "",          s:border,       "")
call s:hi("WildMenu",      s:on_accent, s:accent_solid, "")
call s:hi("Visual",        "",          s:selection,    "")
" Resting matches get the accent container, as Rex tints them; the active
" match is solid accent.
call s:hi("Search",        s:accent,    s:search,       "")
call s:hi("IncSearch",     s:on_accent, s:accent_solid, "")
call s:hi("CurSearch",     s:on_accent, s:accent_solid, "")
call s:hi("Directory",     s:func,      "",             "")
call s:hi("Title",         s:func,      "",             "bold")
call s:hi("ErrorMsg",      s:error,     "",             "bold")
call s:hi("WarningMsg",    s:type,      "",             "")
call s:hi("MoreMsg",       s:ok,        "",             "")
call s:hi("Question",      s:info,      "",             "")
call s:hi("ModeMsg",       s:muted,     "",             "")
call s:hi("DiffAdd",       s:ok,        s:bg_surf,      "")
call s:hi("DiffChange",    s:info,      s:bg_surf,      "")
call s:hi("DiffText",      s:info,      s:bg_elem,      "bold")
call s:hi("DiffDelete",    s:error,     s:bg_surf,      "")
call s:hi("SpellBad",      "",          "",             "undercurl")
call s:hi("SpellCap",      "",          "",             "undercurl")

" Syntax Groups. Comments use the secondary text tier, so they stay readable
" while line numbers keep the dimmer tertiary one.
call s:hi("Comment",       s:comment,   "",             "")
call s:hi("Constant",      s:number,    "",             "")
call s:hi("String",        s:string,    "",             "")
call s:hi("Character",     s:string,    "",             "")
call s:hi("Number",        s:number,    "",             "")
call s:hi("Boolean",       s:number,    "",             "")
call s:hi("Float",         s:number,    "",             "")
call s:hi("Identifier",    s:fg,        "",             "")
call s:hi("Function",      s:func,      "",             "")
call s:hi("Statement",     s:keyword,   "",             "")
call s:hi("PreProc",       s:type,      "",             "")
call s:hi("Type",          s:type,      "",             "")
call s:hi("Special",       s:special,   "",             "")
call s:hi("Delimiter",     s:faint,     "",             "")
call s:hi("Underlined",    s:accent,    "",             "underline")
call s:hi("Error",         s:error,     s:bg,           "bold")
call s:hi("Todo",          s:accent,    s:bg_surf,      "bold")
