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

" s:hi(group, fg, bg, attr [, sp])
" Vim in a terminal takes colors from gui*= when 'termguicolors' is on, but
" attributes from cterm=, so both are set. Always set them, otherwise groups
" Vim defaults to bold/reverse after `hi clear` keep that weight. sp is the
" underline color (spelling, diagnostics); terminals draw it through t_8u.
function! s:hi(group, fg, bg, attr, ...)
  let l:attr = a:attr != "" ? a:attr : "NONE"
  let l:cmd = "hi " . a:group . " gui=" . l:attr . " cterm=" . l:attr
        \ . " term=NONE ctermfg=NONE ctermbg=NONE"
  let l:cmd .= " guifg=" . (a:fg != "" ? a:fg : "NONE")
  let l:cmd .= " guibg=" . (a:bg != "" ? a:bg : "NONE")
  let l:cmd .= " guisp=" . (a:0 && a:1 != "" ? a:1 : "NONE")
  execute l:cmd
endfunction

function! s:link(from, to)
  execute "hi! link " . a:from . " " . a:to
endfunction

" Editor {{{
call s:hi("Normal",        s:fg,        s:bg,           "")
call s:hi("Cursor",        s:bg,        s:accent,       "")
call s:hi("lCursor",       s:bg,        s:accent,       "")
call s:hi("CursorIM",      s:bg,        s:accent,       "")
call s:hi("CursorLine",    "",          s:bg_surf,      "")
call s:hi("CursorColumn",  "",          s:bg_surf,      "")
call s:hi("ColorColumn",   "",          s:bg_surf,      "")
call s:hi("LineNr",        s:faint,     "",             "")
call s:hi("LineNrAbove",   s:faint,     "",             "")
call s:hi("LineNrBelow",   s:faint,     "",             "")
call s:hi("CursorLineNr",  s:accent,    "",             "bold")
call s:hi("CursorLineSign","",          "",             "")
call s:hi("CursorLineFold",s:muted,     "",             "")
call s:hi("SignColumn",    s:faint,     "",             "")
call s:hi("FoldColumn",    s:faint,     "",             "")
" Folds are how long markdown documents get navigated (g:markdown_folding), so
" closed sections read as quiet headings rather than a highlighted block.
call s:hi("Folded",        s:muted,     s:bg_surf,      "italic")
call s:hi("NonText",       s:faint,     "",             "")
call s:hi("EndOfBuffer",   s:faint,     "",             "")
call s:hi("SpecialKey",    s:faint,     "",             "")
call s:hi("Whitespace",    s:border,    "",             "")
call s:hi("Conceal",       s:faint,     "",             "")
call s:hi("MatchParen",    s:accent,    s:bg_elem,      "bold")
call s:hi("VertSplit",     s:border,    "",             "")
call s:hi("StatusLine",    s:fg,        s:bg_surf,      "")
call s:hi("StatusLineNC",  s:faint,     s:bg_surf,      "")
call s:hi("StatusLineTerm",  s:fg,      s:bg_surf,      "")
call s:hi("StatusLineTermNC",s:faint,   s:bg_surf,      "")
" Powerline sections (plugin/statusline.vim), mapped as mini.base16 maps
" mini.statusline's groups so Vim and Neovim match.
call s:hi("StatusLineModeNormal",  s:bg, s:fg,      "bold")
call s:hi("StatusLineModeInsert",  s:bg, s:info,    "bold")
call s:hi("StatusLineModeVisual",  s:bg, s:string,  "bold")
call s:hi("StatusLineModeReplace", s:bg, s:keyword, "bold")
call s:hi("StatusLineModeCommand", s:bg, s:error,   "bold")
call s:hi("StatusLineModeOther",   s:bg, s:faint,   "bold")
call s:hi("StatusLineDevinfo",     s:muted, s:bg_elem, "")
call s:hi("StatusLineFileinfo",    s:muted, s:bg_elem, "")
call s:hi("StatusLineFilename",    s:faint, s:bg_surf, "")
call s:link("StatusLineInactive",  "StatusLineNC")
call s:hi("TabLine",       s:muted,     s:bg_surf,      "")
call s:hi("TabLineFill",   "",          s:bg_surf,      "")
call s:hi("TabLineSel",    s:fg,        s:bg,           "bold")
call s:hi("ToolbarLine",   s:fg,        s:bg_surf,      "")
call s:hi("ToolbarButton", s:fg,        s:bg_elem,      "bold")
call s:hi("Pmenu",         s:fg,        s:bg_surf,      "")
call s:hi("PmenuSel",      s:fg,        s:bg_elem,      "bold")
call s:hi("PmenuKind",     s:keyword,   s:bg_surf,      "")
call s:hi("PmenuKindSel",  s:keyword,   s:bg_elem,      "bold")
call s:hi("PmenuExtra",    s:muted,     s:bg_surf,      "")
call s:hi("PmenuExtraSel", s:muted,     s:bg_elem,      "bold")
call s:hi("PmenuMatch",    s:accent,    s:bg_surf,      "bold")
call s:hi("PmenuMatchSel", s:accent,    s:bg_elem,      "bold")
call s:hi("PmenuSbar",     "",          s:bg_surf,      "")
call s:hi("PmenuThumb",    "",          s:border,       "")
call s:hi("WildMenu",      s:on_accent, s:accent_solid, "")
call s:hi("Visual",        "",          s:selection,    "")
call s:hi("VisualNOS",     "",          s:selection,    "")
call s:hi("QuickFixLine",  "",          s:selection,    "")
" Resting matches get the accent container, as Rex tints them; the active
" match is solid accent.
call s:hi("Search",        s:accent,    s:search,       "")
call s:hi("IncSearch",     s:on_accent, s:accent_solid, "")
call s:hi("CurSearch",     s:on_accent, s:accent_solid, "")
call s:hi("Directory",     s:func,      "",             "")
call s:hi("Title",         s:accent,    "",             "bold")
call s:hi("ErrorMsg",      s:error,     "",             "bold")
call s:hi("WarningMsg",    s:type,      "",             "")
call s:hi("MoreMsg",       s:ok,        "",             "")
call s:hi("Question",      s:info,      "",             "")
call s:hi("ModeMsg",       s:muted,     "",             "")
call s:hi("Terminal",      s:fg,        s:bg,           "")
" }}}

" Diff {{{
call s:hi("DiffAdd",       s:ok,        s:bg_surf,      "")
call s:hi("DiffChange",    s:info,      s:bg_surf,      "")
call s:hi("DiffText",      s:info,      s:bg_elem,      "bold")
call s:hi("DiffDelete",    s:error,     s:bg_surf,      "")
call s:hi("Added",         s:ok,        "",             "")
call s:hi("Changed",       s:info,      "",             "")
call s:hi("Removed",       s:error,     "",             "")
call s:link("diffAdded",   "Added")
call s:link("diffChanged", "Changed")
call s:link("diffRemoved", "Removed")
call s:link("diffFile",    "Title")
call s:link("diffLine",    "Special")
" }}}

" Spelling {{{
" Misspellings get a red undercurl; the softer checks (capitalisation, rare
" and regional words) a plain colored underline, so prose with a lot of
" proper nouns or sentence fragments doesn't look like an error log.
call s:hi("SpellBad",      "",          "",             "undercurl", s:error)
call s:hi("SpellCap",      "",          "",             "underline", s:info)
call s:hi("SpellRare",     "",          "",             "underline", s:keyword)
call s:hi("SpellLocal",    "",          "",             "underline", s:special)
" }}}

" Syntax {{{
" Comments use the secondary text tier, so they stay readable while line
" numbers keep the dimmer tertiary one.
call s:hi("Comment",       s:comment,   "",             "italic")
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
call s:hi("Ignore",        s:faint,     "",             "")
call s:hi("Error",         s:error,     "",             "bold")
call s:hi("Todo",          s:accent,    s:bg_surf,      "bold")
" }}}

" Prose {{{
" Markdown's syntax links emphasis, headings and links through the html*
" groups, so they are set here and apply to markdown, html and help alike.
" Text keeps the body color: emphasis is carried by weight and slant, not hue,
" so a paragraph reads as one voice.
call s:hi("htmlBold",                s:fg,      "", "bold")
call s:hi("htmlItalic",              s:fg,      "", "italic")
call s:hi("htmlBoldItalic",          s:fg,      "", "bold,italic")
call s:hi("htmlUnderline",           s:fg,      "", "underline")
call s:hi("htmlBoldUnderline",       s:fg,      "", "bold,underline")
call s:hi("htmlUnderlineItalic",     s:fg,      "", "italic,underline")
call s:hi("htmlBoldUnderlineItalic", s:fg,      "", "bold,italic,underline")
call s:hi("htmlStrike",              s:muted,   "", "strikethrough")
call s:hi("htmlLink",                s:accent,  "", "")

" Headings step down in color rather than size: the top two levels carry the
" accent, the next two the body color, and the deepest fade to secondary.
" All stay bold so the outline is easy to scan.
call s:hi("htmlH1",                  s:accent,  "", "bold")
call s:hi("htmlH2",                  s:accent,  "", "bold")
call s:hi("htmlH3",                  s:fg,      "", "bold")
call s:hi("htmlH4",                  s:fg,      "", "bold")
call s:hi("htmlH5",                  s:muted,   "", "bold")
call s:hi("htmlH6",                  s:muted,   "", "bold")
" }}}

" Markdown {{{
" Markup characters (#, **, _, `, [ ], > ) sit on the faint tier so the words
" lead; with conceallevel=2 most of them disappear off the cursor line anyway.
call s:hi("markdownHeadingDelimiter",   s:faint,   "", "bold")
call s:hi("markdownHeadingRule",        s:faint,   "", "")
call s:hi("markdownRule",               s:faint,   "", "")

call s:link("markdownItalicDelimiter",     "markdownDelimiter")
call s:link("markdownBoldDelimiter",       "markdownDelimiter")
call s:link("markdownBoldItalicDelimiter", "markdownDelimiter")
call s:link("markdownStrikeDelimiter",     "markdownDelimiter")
call s:hi("markdownDelimiter",          s:faint,   "", "")

" ==highlight== reads like a marker pen: the search tint behind body text.
call s:hi("markdownHighlight",          s:fg,      s:search, "")

" Code is set apart by hue alone. A surface chip would look good inline, but
" Vim uses the same group for unlabelled ``` blocks, where it gives every line
" a ragged background. Labelled fences use their language's syntax instead.
call s:hi("markdownCode",               s:special, "",        "")
call s:hi("markdownCodeBlock",          s:special, "",        "")
call s:hi("markdownCodeDelimiter",      s:faint,   "",        "")

" Link text is the accent; the URL behind it is secondary and usually
" concealed.
call s:hi("markdownLinkText",           s:accent,  "", "")
call s:hi("markdownLinkTextDelimiter",  s:faint,   "", "")
call s:hi("markdownLinkDelimiter",      s:faint,   "", "")
call s:hi("markdownUrl",                s:muted,   "", "underline")
call s:hi("markdownUrlDelimiter",       s:faint,   "", "")
call s:hi("markdownUrlTitle",           s:string,  "", "")
call s:hi("markdownUrlTitleDelimiter",  s:faint,   "", "")
call s:hi("markdownAutomaticLink",      s:accent,  "", "underline")
call s:hi("markdownId",                 s:muted,   "", "")
call s:hi("markdownIdDeclaration",      s:accent,  "", "")
call s:hi("markdownIdDelimiter",        s:faint,   "", "")
call s:hi("markdownFootnote",           s:special, "", "")
call s:hi("markdownFootnoteDefinition", s:special, "", "")

call s:hi("markdownListMarker",         s:accent,  "", "bold")
call s:hi("markdownOrderedListMarker",  s:accent,  "", "bold")
call s:hi("markdownBlockquote",         s:faint,   "", "bold")
call s:hi("markdownEscape",             s:faint,   "", "")
" Two trailing spaces mean a hard line break; show them as a faint chip so
" they're not invisible.
call s:hi("markdownLineBreak",          "",        s:bg_elem, "")
" Vim flags intraword underscores (snake_case, file_names) as errors; in
" prose that's noise.
" (A group with no attributes at all gets re-linked to Error by the syntax
" file, so it carries the body color explicitly.)
call s:hi("markdownError",              s:fg,      "", "")

call s:link("markdownYamlHead",         "Comment")
call s:link("yamlBlockMappingKey",      "Statement")
" }}}

" Help {{{
call s:link("helpHyperTextJump",  "markdownLinkText")
call s:link("helpHyperTextEntry", "Title")
call s:link("helpHeader",         "Title")
call s:link("helpSectionDelim",   "Delimiter")
call s:hi("helpExample",          s:special, "", "")
" }}}

" vim: foldmethod=marker foldlevel=0
