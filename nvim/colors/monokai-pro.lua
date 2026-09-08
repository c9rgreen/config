-- monokai-pro -- a mini.base16 port of monokai-pro.nvim:
-- https://github.com/loctvl842/monokai-pro.nvim (lua/monokai-pro/palette/*.lua,
-- theme/scheme.lua and theme/groups/*.lua)
-- 'background' picks the filter: "pro" when dark, "light" when light. The
-- other dark filters (classic, machine, octagon, ristretto, spectrum) share
-- the pro layout with different hues and are not ported here.
--
-- Slot notes: Monokai has six accents for eight base16 accent slots, and
-- names them oddly -- upstream's scheme.base.blue is the ORANGE accent,
-- because the palette has no blue. Cyan sits in both base0A (types) and
-- base0C (DiagnosticInfo, Special). base0E is orange so mini's
-- DiagnosticWarn, DiffChange and MiniDiffSignChange land on upstream's
-- colors; Monokai's red keyword family rides in as overrides. base0F is
-- the border gray, which upstream uses for punctuation.
--
-- The blended tints (cursor line, selection, match, fold, diff and
-- diagnostic backgrounds) are upstream's blend() results, computed once
-- here rather than at load time.

local palettes = {
   dark = { -- filter "pro"
      base16 = {
         base00 = '#2d2a2e', -- background
         base01 = '#403e41', -- dimmed5 (floats, popup menu, UI elements)
         base02 = '#4c4a4d', -- text blended 15% into bg (word/match highlight)
         base03 = '#727072', -- dimmed3 (comments)
         base04 = '#939293', -- dimmed2 (borders, punctuation, muted text)
         base05 = '#fcfcfa', -- text
         base06 = '#fcfcfa', -- no lighter tier upstream
         base07 = '#fcfcfa',
         base08 = '#ff6188', -- red (keywords, operators, tags, errors)
         base09 = '#ab9df2', -- purple (numbers, constants, booleans)
         base0A = '#78dce8', -- cyan (types, modules)
         base0B = '#ffd866', -- yellow (strings, search, titles)
         base0C = '#78dce8', -- cyan (info diagnostics)
         base0D = '#a9dc76', -- green (functions, headings)
         base0E = '#fc9867', -- orange (warnings, parameters, special)
         base0F = '#939293', -- dimmed2 (delimiters)
      },
      dark1   = '#221f22', -- sidebar / separators / "black"
      dark2   = '#19181a', -- status bar
      dimmed1 = '#c1c0c0', -- active text (current line number, builtins)
      dimmed4 = '#5b595c', -- line numbers, whitespace
      knock   = '#221f22', -- text knocked out of a yellow block (dark1 upstream)
      line    = '#373538', -- lineHighlightBackground
      select  = '#434144', -- selectionBackground
      fold    = '#423f42', -- foldBackground
      sbar    = '#363437', -- PmenuSbar (dimmed5 darkened 10)
      tab     = { bg = '#3c393d', fg = '#afaeae' }, -- inactive tab
      diff    = { add = '#30322a', change = '#382b29', delete = '#38262c', text = '#593d33', delete_fg = '#b94c68' },
      lens    = { error = '#423037', warn = '#423534', info = '#353c41' },
      term    = {
         '#221f22', '#ff6188', '#a9dc76', '#ffd866', '#fc9867', '#ab9df2', '#78dce8', '#fcfcfa',
         '#727072', '#ff6188', '#a9dc76', '#ffd866', '#fc9867', '#ab9df2', '#78dce8', '#fcfcfa',
      },
   },
   light = { -- filter "light"
      base16 = {
         base00 = '#faf4f2', -- background
         base01 = '#d3cdcc', -- dimmed5
         base02 = '#dbd5d4', -- text blended 15% into bg
         base03 = '#a59fa0', -- dimmed3 (comments)
         base04 = '#918c8e', -- dimmed2
         base05 = '#29242a', -- text
         base06 = '#29242a', -- no darker tier upstream
         base07 = '#29242a',
         base08 = '#e14775', -- red
         base09 = '#7058be', -- purple
         base0A = '#1c8ca8', -- cyan
         base0B = '#cc7a0a', -- yellow
         base0C = '#1c8ca8', -- cyan
         base0D = '#269d69', -- green
         base0E = '#e16032', -- orange
         base0F = '#918c8e', -- dimmed2
      },
      dark1   = '#ede7e5',
      dark2   = '#d3cdcc',
      dimmed1 = '#706b6e',
      dimmed4 = '#bfb9ba',
      knock   = '#29242a', -- upstream uses dark1 here too, but that is 3:1 on the light yellow; the text tone is 4.6:1
      line    = '#f0eae8',
      select  = '#e5dfde',
      fold    = '#e5dfde',
      sbar    = '#c9c3c2',
      tab     = { bg = '#ffffff', fg = '#7f7c7f' },
      diff    = { add = '#d9e0d9', change = '#ecdad3', delete = '#ecd7da', text = '#eac5b8', delete_fg = '#e57998' },
      lens    = { error = '#f8e3e6', warn = '#f8e5df', info = '#e4eaeb' },
      term    = {
         '#ede7e5', '#e14775', '#269d69', '#cc7a0a', '#e16032', '#7058be', '#1c8ca8', '#29242a',
         '#a59fa0', '#e14775', '#269d69', '#cc7a0a', '#e16032', '#7058be', '#1c8ca8', '#29242a',
      },
   },
}

local c = palettes[vim.o.background] or palettes.dark
local p = c.base16

require('mini.base16').setup({ palette = p })
vim.g.colors_name = 'monokai-pro'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- Flat gutter: upstream keeps the number and sign columns on the canvas,
-- numbers in dimmed4, the current line number in dimmed1 and bold, and the
-- fold column in dimmed1 as well.
hi('LineNr',       { fg = c.dimmed4 })
hi('LineNrAbove',  { fg = c.dimmed4 })
hi('LineNrBelow',  { fg = c.dimmed4 })
hi('SignColumn',   { fg = c.dimmed4 })
hi('FoldColumn',   { fg = c.dimmed1 })
hi('CursorLineNr', { fg = c.dimmed1, bold = true })
hi('CursorLine',   { bg = c.line })
hi('CursorColumn', { bg = c.line })
hi('Folded',       { bg = c.fold })
hi('ColorColumn',  { bg = p.base01 })
hi('Conceal',      { fg = p.base03 })

-- Invisibles: whitespace markers in dimmed4, end-of-buffer tildes hidden.
-- Upstream also hides NonText; it stays visible here so listchars and wrap
-- markers do not vanish.
hi('NonText',     { fg = c.dimmed4 })
hi('Whitespace',  { fg = c.dimmed4 })
hi('SpecialKey',  { fg = c.dimmed4 })
hi('EndOfBuffer', { fg = p.base00 })

-- Splits are a hairline in the sidebar tone. The status line sits on the
-- darkest tier (statusBar.background) with dimmed1 text when active and
-- dimmed3 when not.
hi('WinSeparator', { fg = c.dark1 })
hi('VertSplit',    { fg = c.dark1 })
hi('StatusLine',   { fg = c.dimmed1, bg = c.dark2 })
hi('StatusLineNC', { fg = p.base03, bg = c.dark2 })

-- Floats and the popup menu live on dimmed5 (editorSuggestWidget). Upstream
-- draws menu text in dimmed2 and lets the selected row fall back to full
-- text on dimmed3; NormalFloat keeps the full text tone here so hover docs
-- stay readable. The border follows the float's background rather than the
-- editor's so rounded borders read as one box. FloatTitle is upstream's
-- yellow tab.
hi('NormalFloat', { fg = p.base05, bg = p.base01 })
hi('FloatBorder', { fg = p.base04, bg = p.base01 })
hi('FloatTitle',  { fg = c.knock, bg = p.base0B, bold = true })
hi('Pmenu',       { fg = p.base04, bg = p.base01 })
hi('PmenuSel',    { fg = p.base05, bg = p.base03, bold = true })
hi('PmenuSbar',   { bg = c.sbar })
hi('PmenuThumb',  { bg = c.select })

-- Tabs: the active tab is yellow on the canvas, inactive tabs sit on a
-- lightened canvas with faded text, and the fill is the sidebar tone.
hi('TabLine',     { fg = c.tab.fg, bg = c.tab.bg })
hi('TabLineFill', { bg = c.dark1 })
hi('TabLineSel',  { fg = p.base0B, bg = p.base00 })

-- Selection and matches are near-identical low-alpha text blends upstream;
-- Search is background-only so the matched text keeps its syntax color, and
-- the active match is yellow with dark text (inc_search = "background").
hi('Visual',     { bg = c.select })
hi('VisualNOS',  { link = 'Visual' })
hi('Search',     { bg = p.base02 })
hi('IncSearch',  { fg = c.knock, bg = p.base0B, bold = true })
hi('CurSearch',  { fg = c.knock, bg = p.base0B, bold = true })
hi('Substitute', { fg = c.knock, bg = p.base0B, bold = true })
hi('MatchParen', { fg = p.base0B, bold = true, underline = true })
hi('LspReferenceText',  { bg = p.base02 })
hi('LspReferenceRead',  { bg = p.base02 })
hi('LspReferenceWrite', { bg = p.base02 })

-- Messages and titles: yellow is Monokai's heading and prompt color.
hi('Title',      { fg = p.base0B, bold = true })
hi('MoreMsg',    { fg = p.base0B })
hi('ModeMsg',    { link = 'Normal' })
hi('ErrorMsg',   { fg = p.base08 })
hi('WarningMsg', { fg = p.base0E })

-- Diffs: upstream's per-kind tints blended into the sidebar tone. They are
-- background-only here so diff mode keeps syntax highlighting (upstream
-- paints each hunk with a single blended fg); DiffDelete keeps that blended
-- fg for its filler lines, and DiffText is a stronger orange tint since
-- upstream leaves it at plain editor colors.
hi('DiffAdd',    { bg = c.diff.add })
hi('DiffChange', { bg = c.diff.change })
hi('DiffDelete', { fg = c.diff.delete_fg, bg = c.diff.delete })
hi('DiffText',   { bg = c.diff.text })
hi('diffAdded',   { fg = p.base0D })
hi('diffChanged', { fg = p.base0B })
hi('diffRemoved', { fg = p.base08 })
hi('diffFile',    { fg = p.base0B })
hi('diffNewFile', { fg = p.base0B })
hi('diffLine',    { fg = p.base0C })

-- Diagnostics: hint shares info's cyan, underlines are undercurls, virtual
-- text sits on upstream's errorLens tints, and inlay hints are dimmed2 on
-- dimmed5. DiagnosticUnnecessary is an undercurl upstream rather than a fade.
hi('DiagnosticHint',           { fg = p.base0C })
hi('DiagnosticFloatingHint',   { fg = p.base0C, bg = p.base01 })
hi('DiagnosticUnderlineError', { sp = p.base08, undercurl = true })
hi('DiagnosticUnderlineWarn',  { sp = p.base0E, undercurl = true })
hi('DiagnosticUnderlineInfo',  { sp = p.base0C, undercurl = true })
hi('DiagnosticUnderlineHint',  { sp = p.base0C, undercurl = true })
hi('DiagnosticUnnecessary',    { sp = p.base0C, undercurl = true })
hi('DiagnosticVirtualTextError', { fg = p.base08, bg = c.lens.error })
hi('DiagnosticVirtualTextWarn',  { fg = p.base0E, bg = c.lens.warn })
hi('DiagnosticVirtualTextInfo',  { fg = p.base0C, bg = c.lens.info })
hi('DiagnosticVirtualTextHint',  { fg = p.base0C, bg = c.lens.info })
hi('LspInlayHint',               { fg = p.base04, bg = p.base01 })

-- Syntax, per upstream: comments italic; the keyword family (keywords,
-- conditionals, loops, operators, includes, storage, tags, brackets) is
-- red; Statement proper, constants and escapes are purple; strings yellow;
-- functions and attributes green; types and modules cyan; parameters and
-- specials orange; identifiers and delimiters plain text.
hi('Comment',        { fg = p.base03, italic = true })
hi('SpecialComment', { fg = p.base03 })
hi('Character',      { fg = p.base09 })
hi('Identifier',     { fg = p.base05 })
hi('Statement',      { fg = p.base09 })
hi('Conditional',    { fg = p.base08 })
hi('Repeat',         { fg = p.base08 })
hi('Label',          { fg = p.base08 })
hi('Operator',       { fg = p.base08 })
hi('Keyword',        { fg = p.base08, italic = true })
hi('Exception',      { fg = p.base08 })
hi('PreProc',        { fg = p.base0B })
hi('Include',        { fg = p.base08 })
hi('Define',         { fg = p.base08 })
hi('Macro',          { fg = p.base08 })
hi('PreCondit',      { fg = p.base08 })
hi('StorageClass',   { fg = p.base08, italic = true })
hi('Structure',      { fg = p.base0A, italic = true })
hi('Typedef',        { fg = p.base08 })
hi('Special',        { fg = p.base0E })
hi('SpecialChar',    { fg = p.base0E })
hi('Delimiter',      { fg = p.base05 })
hi('Tag',            { fg = p.base08 })
hi('Error',          { fg = p.base08 })
hi('Todo',           { fg = p.base09, bold = true })

hi('@annotation',                { fg = p.base0A, italic = true })
hi('@attribute',                 { fg = p.base0D })
hi('@constructor',               { fg = p.base0D })
hi('@function.builtin',          { fg = p.base0D })
hi('@function.macro',            { fg = p.base0D })
hi('@keyword.function',          { fg = p.base0C, italic = true })
hi('@keyword.type',              { fg = p.base0C, italic = true })
hi('@keyword.return',            { fg = p.base08 })
hi('@keyword.directive',         { fg = p.base08 })
hi('@keyword.storage',           { fg = p.base08 })
hi('@punctuation.bracket',       { fg = p.base08 })
hi('@punctuation.delimiter',     { fg = p.base04 })
hi('@punctuation.special',       { fg = p.base04 })
hi('@variable.builtin',          { fg = c.dimmed1, italic = true })
hi('@variable.member',           { fg = p.base05 })
hi('@variable.parameter',        { fg = p.base0E, italic = true })
hi('@variable.parameter.builtin', { fg = p.base0E, italic = true })
hi('@string.documentation',      { fg = p.base03 })
hi('@string.escape',             { fg = p.base09 })
hi('@string.regexp',             { fg = p.base0B })
hi('@character',                 { fg = p.base0B })
hi('@character.special',         { fg = p.base0B })
hi('@tag',                       { fg = p.base08 })
hi('@tag.attribute',             { fg = p.base0A, italic = true })
hi('@tag.builtin',               { fg = p.base08 })
hi('@tag.delimiter',             { fg = p.base04 })
hi('@type',                      { fg = p.base0A })
hi('@type.builtin',              { fg = p.base0A, italic = true })
hi('@type.definition',           { fg = p.base0D })
hi('@type.qualifier',            { fg = p.base0A })
hi('@module',                    { fg = p.base0A })
hi('@module.builtin',            { fg = p.base0A })
hi('@label',                     { fg = p.base0A })
hi('@diff.plus',                 { fg = p.base0D })
hi('@diff.minus',                { fg = p.base08 })
hi('@diff.delta',                { fg = p.base0B })

-- Markup: headings are green in general and yellow in markdown, links are
-- orange (markdown URLs green), inline code and math are yellow, and
-- fenced blocks sit on the sidebar tone.
hi('@markup.heading',                    { fg = p.base0D, bold = true })
hi('@markup.link',                       { fg = p.base0E, underline = true })
hi('@markup.link.label',                 { fg = p.base0E, underline = true })
hi('@markup.link.url',                   { fg = p.base0E, underline = true })
hi('@markup.link.label.markdown_inline', { fg = p.base08 })
hi('@markup.link.url.markdown_inline',   { fg = p.base0D, underline = true })
hi('@markup.list',                       { fg = p.base05 })
hi('@markup.math',                       { fg = p.base0B })
hi('@markup.raw',                        { fg = p.base0B })
hi('@markup.raw.block.markdown',         { bg = c.dark1 })
hi('@markup.raw.delimiter.markdown',     { fg = p.base04, bg = c.dark1 })
hi('@punctuation.special.markdown',      { fg = p.base04 })
for i = 1, 6 do
   hi('@markup.heading.' .. i .. '.markdown',        { fg = p.base0B, bold = true })
   hi('@markup.heading.' .. i .. '.marker.markdown', { fg = p.base04 })
end

-- Language tweaks upstream carries: Lua and Go color the `function`/`func`
-- keyword red instead of cyan, and YAML keys are red.
hi('@keyword.function.lua', { fg = p.base08 })
hi('@keyword.function.go',  { fg = p.base08 })
hi('@property.yaml',        { fg = p.base08 })

-- mini modules: the mode blocks follow upstream's plugins/mini.lua (normal
-- green, insert yellow, command red, visual cyan, replace orange), the rest
-- of the status line uses the statusBar tiers, diff signs sit flat on the
-- canvas with the gutter's per-kind colors, and the tabline mirrors the
-- Tab* groups above.
hi('MiniStatuslineModeNormal',  { fg = c.knock, bg = p.base0D, bold = true })
hi('MiniStatuslineModeInsert',  { fg = c.knock, bg = p.base0B, bold = true })
hi('MiniStatuslineModeCommand', { fg = c.knock, bg = p.base08, bold = true })
hi('MiniStatuslineModeVisual',  { fg = c.knock, bg = p.base0C, bold = true })
hi('MiniStatuslineModeReplace', { fg = c.knock, bg = p.base0E, bold = true })
hi('MiniStatuslineModeOther',   { fg = c.knock, bg = p.base05, bold = true })
hi('MiniStatuslineDevinfo',     { fg = c.dimmed1, bg = p.base01 })
hi('MiniStatuslineFileinfo',    { fg = c.dimmed1, bg = p.base01 })
hi('MiniStatuslineFilename',    { fg = p.base03, bg = c.dark2 })
hi('MiniStatuscolumnDim',       { fg = p.base02 })
hi('MiniDiffSignAdd',           { fg = p.base0D })
hi('MiniDiffSignChange',        { fg = p.base0E })
hi('MiniDiffSignDelete',        { fg = p.base08 })
hi('MiniIndentscopeSymbol',     { fg = p.base0E })
hi('MiniTablineCurrent',        { fg = p.base0B, bg = p.base00, bold = true })
hi('MiniTablineVisible',        { fg = c.tab.fg, bg = c.tab.bg, bold = true })
hi('MiniTablineHidden',         { fg = c.tab.fg, bg = c.tab.bg })
hi('MiniTablineFill',           { bg = c.dark1 })

-- Terminal palette per upstream's set_terminal_colors: black is the sidebar
-- tone, bright black is the comment gray, ANSI blue is Monokai's orange
-- (the palette has no blue), and the brights repeat the normals.
for i, color in ipairs(c.term) do
   vim.g['terminal_color_' .. (i - 1)] = color
end
