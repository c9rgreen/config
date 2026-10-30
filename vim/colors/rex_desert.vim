" rex_desert -- Rex's Terracotta Noon (light) and Sonoran Dusk (dark) themes.
" Hexes and role choices match nvim/colors/rex-desert.lua: syntax hues from
" Rex's ANSI colors, with Terracotta Noon swapping in the darker semantic
" tones where the ANSI ones are too faint on its cream canvas.
" 'background' picks the variant, so set it before :colorscheme.

hi clear

if exists("syntax_on")
  syntax reset
endif

if has("termguicolors")
  set termguicolors
endif

let g:colors_name = "rex_desert"

if &background ==# "light"
  " Terracotta Noon
  let s:bg           = "#f9efe6"
  let s:bg_surf      = "#eee5de"
  let s:bg_elem      = "#dfd5ce"
  let s:border       = "#d6cac0"
  let s:fg           = "#4a382c"
  let s:muted        = "#766559"
  let s:faint        = "#918276"
  let s:accent       = "#aa4a26"
  let s:accent_solid = "#be5834"
  let s:on_accent    = "#ffffff"
  let s:selection    = "#f0d4b8"
  let s:search       = "#f4e3d8"

  let s:keyword      = "#9d5680"
  let s:type         = "#896000"
  let s:func         = "#426a98"
  let s:string       = "#497125"
  let s:number       = "#aa4a26"
  let s:special      = "#3e8570"
  let s:comment      = "#766559"
  let s:error        = "#b24226"
  let s:ok           = "#497125"
  let s:info         = "#426a98"
else
  " Sonoran Dusk
  let s:bg           = "#171412"
  let s:bg_surf      = "#1e1b19"
  let s:bg_elem      = "#2c2825"
  let s:border       = "#4e4842"
  let s:fg           = "#ddd0bf"
  let s:muted        = "#938a7e"
  let s:faint        = "#746d64"
  let s:accent       = "#e8a860"
  let s:accent_solid = "#e8a860"
  let s:on_accent    = "#171412"
  let s:selection    = "#423528"
  let s:search       = "#33281e"

  let s:keyword      = "#bd8aa2"
  let s:type         = "#e0a45c"
  let s:func         = "#8598b0"
  let s:string       = "#a0b06a"
  let s:number       = "#e88a72"
  let s:special      = "#92b39c"
  let s:comment      = "#938a7e"
  let s:error        = "#d96e56"
  let s:ok           = "#a0b06a"
  let s:info         = "#8598b0"
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
