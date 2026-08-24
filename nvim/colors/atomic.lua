-- Atomic -- a mini.base16 port of atomic.nvim:
-- https://github.com/kurund/atomic.nvim (lua/atomic/palette.lua)
-- 'background' picks the variant the same way upstream's colors/atomic.lua
-- does: the flagship navy-teal "default" style when dark, the "light" style
-- when light. (Upstream also ships a near-black "dark" style; this port
-- keeps the default.)
--
-- Slot notes: base0C carries atomic's blue and base0D its signature teal so
-- mini's DiagnosticInfo/Hint land on the upstream colors unchanged; base0E
-- is the orange accent (keywords/statements), so the pink preprocessor and
-- purple storage-class roles ride in as overrides. base0F duplicates base04
-- because atomic draws delimiters and operators in fg_dim.

local palettes = {
   dark = {
      base16 = {
         base00 = '#162830', -- bg
         base01 = '#1e3038', -- bg_surface
         base02 = '#354a52', -- bg_hl
         base03 = '#8a7d6b', -- fg_muted (comments, gutter)
         base04 = '#d9cdb8', -- fg_dim
         base05 = '#f5ecd7', -- fg
         base06 = '#f5ecd7', -- no lighter tier upstream
         base07 = '#f5ecd7',
         base08 = '#c9392b', -- red (errors, diff delete)
         base09 = '#d4953a', -- amber (numbers, constants)
         base0A = '#e8c547', -- yellow (types, search bg)
         base0B = '#4dcb8a', -- green (strings)
         base0C = '#4a7fa5', -- blue (modules, info)
         base0D = '#2fb8b0', -- teal (functions)
         base0E = '#e05a2d', -- orange (keywords, accent)
         base0F = '#d9cdb8', -- fg_dim (delimiters)
      },
      border = '#2a3d44', -- bg_border
      purple = '#7b68b0',
      pink   = '#c47a98',
      diag   = { error = '#1e1215', warn = '#1e1a12', info = '#121a1e', hint = '#121e1c' },
      diff   = { add = '#1a3328', change = '#1a2a33', delete = '#2a1a1a', text = '#1e3545' },
   },
   light = {
      base16 = {
         base00 = '#f2f0e8', -- bg
         base01 = '#e9e7df', -- bg_surface
         base02 = '#cbc8bc', -- bg_hl
         base03 = '#8a8478', -- fg_muted
         base04 = '#4a4538', -- fg_dim
         base05 = '#2a2920', -- fg
         base06 = '#2a2920', -- no darker tier upstream
         base07 = '#2a2920',
         base08 = '#b83a2e', -- red
         base09 = '#a07828', -- amber
         base0A = '#8a7520', -- yellow
         base0B = '#3a7a4a', -- green
         base0C = '#3a6a90', -- blue
         base0D = '#1a8580', -- teal
         base0E = '#b84820', -- orange
         base0F = '#4a4538', -- fg_dim
      },
      border = '#d4d1c7',
      purple = '#6a558a',
      pink   = '#a85878',
      diag   = { error = '#fce8e6', warn = '#faf0d8', info = '#e4eef6', hint = '#e2f2ee' },
      diff   = { add = '#d6ead4', change = '#dfe8f0', delete = '#f0d0d0', text = '#c8dce8' },
   },
}

local c = palettes[vim.o.background] or palettes.dark
local p = c.base16

require('mini.base16').setup({ palette = p })
vim.g.colors_name = 'atomic'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- Flat gutter: atomic keeps the number/sign columns on the canvas, no
-- surface stripe, and gives the current line number the orange accent.
hi('LineNr',       { fg = p.base03 })
hi('LineNrAbove',  { fg = p.base03 })
hi('LineNrBelow',  { fg = p.base03 })
hi('SignColumn',   { fg = p.base03 })
hi('FoldColumn',   { fg = p.base03 })
hi('CursorLineNr', { fg = p.base0E, bold = true })

-- Invisibles sit below comments: atomic draws them with the border tone,
-- and hides the end-of-buffer tildes entirely.
hi('NonText',     { fg = c.border })
hi('Whitespace',  { fg = c.border })
hi('SpecialKey',  { fg = c.border })
hi('EndOfBuffer', { fg = p.base00 })

-- Splits are a border-colored line, not mini's solid base02 bar; the status
-- line sits on the surface tier rather than the (stronger) highlight tier.
hi('WinSeparator', { fg = c.border })
hi('VertSplit',    { fg = c.border })
hi('StatusLine',   { fg = p.base04, bg = p.base01 })
hi('FloatBorder',  { fg = p.base03, bg = p.base01 })
hi('Folded',       { fg = p.base04, bg = p.base01 })
hi('PmenuSel',     { fg = p.base05, bg = p.base02 })
hi('TabLineSel',   { fg = p.base05, bg = p.base00, bold = true })

-- Accent moments: atomic marks matches and titles with orange, and paints
-- Search with the type yellow. Upstream gives the active search the orange
-- accent too, but ghostty paints the cursor that exact orange (see
-- ghostty/themes/atomic), so an accent-colored match under it would render
-- identically with or without the cursor and the cursor would vanish on
-- every jump. Recolor the match rather than the cursor: teal is the far
-- side of the wheel from the cursor's orange, and still distinct from
-- Search's yellow on the matches the cursor isn't on.
hi('MatchParen', { fg = p.base0E, bold = true, underline = true })
hi('Title',      { fg = p.base0E, bold = true })
hi('Search',     { fg = p.base00, bg = p.base0A })
hi('IncSearch',  { fg = p.base00, bg = p.base0D })
hi('CurSearch',  { fg = p.base00, bg = p.base0D })
hi('Substitute', { fg = p.base00, bg = p.base0D })
hi('ModeMsg',    { fg = p.base04, bold = true })
hi('MoreMsg',    { fg = p.base0D })
hi('Error',      { fg = p.base08 })
hi('Todo',       { fg = p.base00, bg = p.base0A, bold = true })

-- Diffs use atomic's dedicated tinted backgrounds instead of mini's
-- fg-on-surface treatment.
hi('DiffAdd',    { bg = c.diff.add })
hi('DiffChange', { bg = c.diff.change })
hi('DiffDelete', { fg = p.base08, bg = c.diff.delete })
hi('DiffText',   { bg = c.diff.text })

-- Diagnostics: warnings are yellow upstream (mini uses the base0E slot,
-- which is orange here), underlines are undercurls, and virtual text gets
-- atomic's per-severity tinted backgrounds.
hi('DiagnosticWarn',           { fg = p.base0A })
hi('DiagnosticFloatingWarn',   { fg = p.base0A, bg = p.base01 })
hi('DiagnosticUnderlineError', { sp = p.base08, undercurl = true })
hi('DiagnosticUnderlineWarn',  { sp = p.base0A, undercurl = true })
hi('DiagnosticUnderlineInfo',  { sp = p.base0C, undercurl = true })
hi('DiagnosticUnderlineHint',  { sp = p.base0D, undercurl = true })
hi('DiagnosticVirtualTextError', { fg = p.base08, bg = c.diag.error })
hi('DiagnosticVirtualTextWarn',  { fg = p.base0A, bg = c.diag.warn })
hi('DiagnosticVirtualTextInfo',  { fg = p.base0C, bg = c.diag.info })
hi('DiagnosticVirtualTextHint',  { fg = p.base0D, bg = c.diag.hint })
hi('DiagnosticUnnecessary',      { fg = p.base03 })
hi('DiagnosticDeprecated',       { fg = p.base03, strikethrough = true })

-- The diagnostic signs are shaded cells (see init.lua): severity is carried
-- by density, so all four share one hue rather than mini's per-severity
-- colors. Link to DiagnosticSignWarn instead of hardcoding the yellow.
hi('DiagnosticSignError', { link = 'DiagnosticSignWarn' })
hi('DiagnosticSignInfo',  { link = 'DiagnosticSignWarn' })
hi('DiagnosticSignHint',  { link = 'DiagnosticSignWarn' })

-- Syntax roles where atomic and the base16 conventions disagree: variables
-- stay plain fg, the whole statement family is the orange accent, operators
-- drop to fg_dim, and the preprocessor family is pink with purple storage.
hi('Comment',        { fg = p.base03, italic = true })
hi('Identifier',     { fg = p.base05 })
hi('Statement',      { fg = p.base0E })
hi('Repeat',         { fg = p.base0E })
hi('Label',          { fg = p.base0E })
hi('Operator',       { fg = p.base04 })
hi('Character',      { fg = p.base0B })
hi('PreProc',        { fg = c.pink })
hi('Include',        { fg = c.pink })
hi('Define',         { fg = c.pink })
hi('Macro',          { fg = c.pink })
hi('PreCondit',      { fg = c.pink })
hi('StorageClass',   { fg = c.purple })
hi('Structure',      { fg = p.base0A })
hi('Special',        { fg = p.base09 })
hi('SpecialChar',    { fg = p.base09 })
hi('SpecialComment', { fg = p.base03, bold = true })
hi('Tag',            { fg = p.base0D })

hi('@variable.builtin',    { fg = c.pink })
hi('@variable.parameter',  { fg = p.base04 })
hi('@module',              { fg = p.base0C })
hi('@function.builtin',    { fg = p.base0D, italic = true })
hi('@function.macro',      { fg = c.pink })
hi('@constructor',         { fg = p.base0A })
hi('@keyword.return',      { fg = p.base0E })
hi('@keyword.exception',   { fg = p.base08 })
hi('@keyword.import',      { fg = c.pink })
hi('@keyword.modifier',    { fg = c.purple })
hi('@type.builtin',        { fg = p.base0A, italic = true })
hi('@type.qualifier',      { fg = p.base0E })
hi('@attribute',           { fg = c.pink })
hi('@string.regexp',       { fg = c.pink })
hi('@string.escape',       { fg = p.base09 })
hi('@punctuation.special', { fg = p.base09 })
hi('@tag',                 { fg = p.base0E })
hi('@tag.attribute',       { fg = p.base0D })
hi('@tag.delimiter',       { fg = p.base03 })
hi('@markup.heading',      { fg = p.base0E, bold = true })
hi('@markup.link',         { fg = p.base0D, underline = true })
hi('@markup.link.url',     { fg = p.base0C, underline = true })
hi('@markup.list',         { fg = p.base0E })
hi('@markup.raw',          { fg = p.base0B })

-- Terminal palette straight from upstream's editor.lua: bright red is the
-- orange accent, bright magenta is pink, bright black is fg_dim.
local term = {
   c.border, p.base08, p.base0B, p.base0A, p.base0C, c.purple, p.base0D, p.base05,
   p.base04, p.base0E, p.base0B, p.base0A, p.base0C, c.pink, p.base0D, p.base05,
}
for i, color in ipairs(term) do
   vim.g['terminal_color_' .. (i - 1)] = color
end
