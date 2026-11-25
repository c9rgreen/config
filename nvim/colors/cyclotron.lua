-- Cyclotron -- a mini.base16 colorscheme in the atomic-age palette: warm paper
-- neutrals, an orange accent, teal functions. 'background' picks the variant.
--
-- The light palette is an OKLCH approximation of atomic.nvim's light style
-- (https://github.com/kurund/atomic.nvim). The dark palette is derived from
-- the light one rather than from upstream: each neutral keeps its relative
-- position between bg and fg on a dark lightness ramp (bg 21%, fg 92%), and
-- each accent keeps its hue and chroma with lightness raised 20 points. The
-- diag and diff tints are the background nudged toward the accent's hue.
-- Tune both in the Cyclotron Theme Workbench artifact and paste its export here.
--
-- Slot notes: base0C carries the blue and base0D the teal so mini's
-- DiagnosticInfo/Hint land on those colors unchanged; base0E is the orange
-- accent (keywords/statements), so the pink preprocessor and purple
-- storage-class roles ride in as overrides. base0F duplicates base04 because
-- delimiters and operators are drawn in the dim tier.

local palettes = {
   dark = {
      base16 = {
         base00 = '#1a1813', -- bg
         base01 = '#201f19', -- surface (status line, floats)
         base02 = '#3a382e', -- highlight (selection)
         base03 = '#7c766a', -- muted (comments, gutter)
         base04 = '#c4beaf', -- dim (operators, delimiters)
         base05 = '#cfcec3', -- fg (set 7 points below the ramp's 92%)
         base06 = '#cfcec3', -- no further tier
         base07 = '#cfcec3',
         base08 = '#fe7a6a', -- red (errors, diff delete)
         base09 = '#e0b669', -- amber (numbers, constants)
         base0A = '#c8b362', -- yellow (types, search bg)
         base0B = '#77b884', -- green (strings)
         base0C = '#75a6cf', -- blue (modules, info)
         base0D = '#64c3bd', -- teal (functions)
         base0E = '#fd8760', -- orange (keywords, accent)
         base0F = '#c4beaf', -- dim (delimiters)
      },
      border = '#323028',
      purple = '#a690c9',
      pink   = '#eb94b5',
      diag   = { error = '#2d1b18', warn = '#25200f', info = '#14222e', hint = '#0d2524' },
      diff   = {
         add = '#122c19', change = '#0e283b', delete = '#3a1c18',
         text = '#003354', add_text = '#013b17', delete_text = '#521b15',
      },
   },
   light = {
      base16 = {
         base00 = '#f2f0e8', -- bg
         base01 = '#e9e7df', -- surface (status line, floats)
         base02 = '#cbc8bc', -- highlight (selection)
         base03 = '#8a8478', -- muted (comments, gutter)
         base04 = '#4a4538', -- dim (operators, delimiters)
         base05 = '#2a2920', -- fg
         base06 = '#2a2920', -- no further tier
         base07 = '#2a2920',
         base08 = '#b83a2e', -- red (errors, diff delete)
         base09 = '#a07828', -- amber (numbers, constants)
         base0A = '#8a7520', -- yellow (types, search bg)
         base0B = '#3a7a4a', -- green (strings)
         base0C = '#3a6a90', -- blue (modules, info)
         base0D = '#188580', -- teal (functions)
         base0E = '#b84820', -- orange (keywords, accent)
         base0F = '#4a4538', -- dim (delimiters)
      },
      border = '#d4d1c7',
      purple = '#6a558a',
      pink   = '#a85878',
      diag   = { error = '#fbe1dc', warn = '#eee8d2', info = '#d7eafb', hint = '#d2eeec' },
      diff   = {
         add = '#c9ecce', change = '#c7e5ff', delete = '#ffd6cf',
         text = '#b1dbff', add_text = '#a8e8b4', delete_text = '#ffc6bc',
      },
   },
}

local c = palettes[vim.o.background] or palettes.dark
local p = c.base16

require('mini.base16').setup({ palette = p })
vim.g.colors_name = 'cyclotron'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- Flat gutter: Cyclotron keeps the number/sign columns on the canvas, no
-- surface stripe, and gives the current line number the orange accent.
hi('LineNr',       { fg = p.base03 })
hi('LineNrAbove',  { fg = p.base03 })
hi('LineNrBelow',  { fg = p.base03 })
hi('SignColumn',   { fg = p.base03 })
hi('FoldColumn',   { fg = p.base03 })
hi('CursorLineNr', { fg = p.base0E, bold = true })

-- Signs drawn in that gutter drop mini's surface background too, or every
-- changed or diagnosed line would get a stripe cell.
hi('MiniDiffSignAdd',    { fg = p.base0B })
hi('MiniDiffSignChange', { fg = p.base0C })
hi('MiniDiffSignDelete', { fg = p.base08 })
hi('DiagnosticSignWarn', { fg = p.base0A })

-- Invisibles sit below comments: Cyclotron draws them with the border tone,
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

-- Accent moments: Cyclotron marks matches and titles with orange, and paints
-- Search with the type yellow. atomic.nvim gives the active search the orange
-- accent too, but the terminal theme paints the cursor that exact orange (see
-- ghostty/themes/cyclotron_*), so an accent-colored match under it would render
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

-- Diffs use dedicated tinted backgrounds instead of mini's fg-on-surface
-- treatment, so syntax colors survive on changed lines. Each hue has a line
-- tint and a stronger char tint for the characters that changed within it.
-- DiffDelete is bg-only like DiffAdd: in :diffthis it paints blank filler
-- rows ('fillchars' diff is a space), and mini links Neogit's deleted lines
-- to it, which now read like added ones -- plain text on the tint, instead
-- of red text on red. DiffTextDelete is not a Neovim group: it gives plugins
-- that take a group name (codediff's char_delete) the deleted-char tint.
hi('DiffAdd',        { bg = c.diff.add })
hi('DiffChange',     { bg = c.diff.change })
hi('DiffDelete',     { bg = c.diff.delete })
hi('DiffText',       { bg = c.diff.text })
hi('DiffTextAdd',    { bg = c.diff.add_text })
hi('DiffTextDelete', { bg = c.diff.delete_text })

-- Change is blue to match the change tints; mini puts it in the orange
-- accent slot, which sits right next to the red used for deletions.
hi('Added',       { fg = p.base0B })
hi('Changed',     { fg = p.base0C })
hi('Removed',     { fg = p.base08 })
hi('diffAdded',   { link = 'Added' })
hi('diffChanged', { link = 'Changed' })
hi('diffRemoved', { link = 'Removed' })

-- Patch headers in diff and git buffers: old/new file in the delete/add hues,
-- index lines muted, and the hunk's function context in the function teal.
hi('diffOldFile',   { fg = p.base08 })
hi('diffNewFile',   { fg = p.base0B })
hi('diffIndexLine', { fg = p.base03 })
hi('diffSubname',   { fg = p.base0D })

-- mini.diff overlay reads as before/after: reference lines (and their changed
-- characters) take the delete tints, buffer lines take the add tints.
hi('MiniDiffOverDelete',     { bg = c.diff.delete })
hi('MiniDiffOverContext',    { bg = c.diff.delete })
hi('MiniDiffOverChange',     { bg = c.diff.delete_text })
hi('MiniDiffOverContextBuf', { bg = c.diff.add })
hi('MiniDiffOverChangeBuf',  { bg = c.diff.add_text })

-- Plugin char-level groups. codediff reads DiffTextAdd/DiffTextDelete through
-- its config (plugins/codediff.lua); Neogit defines its groups as defaults, so
-- these win, and keeping them bg-only leaves the line's text color in place.
hi('NeogitDiffAddInline',    { bg = c.diff.add_text })
hi('NeogitDiffDeleteInline', { bg = c.diff.delete_text })
hi('CodeDiffFiller',         { fg = c.border })

-- Diagnostics: warnings are yellow (mini uses the base0E slot,
-- which is orange here), underlines are undercurls, and virtual text gets
-- per-severity tinted backgrounds.
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

-- Syntax roles where Cyclotron and the base16 conventions disagree: variables
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

-- Terminal palette matching ghostty/themes/cyclotron_*: bright red is the
-- orange accent, bright magenta is pink, bright black is fg_dim.
local term = {
   c.border, p.base08, p.base0B, p.base0A, p.base0C, c.purple, p.base0D, p.base05,
   p.base04, p.base0E, p.base0B, p.base0A, p.base0C, c.pink, p.base0D, p.base05,
}
for i, color in ipairs(term) do
   vim.g['terminal_color_' .. (i - 1)] = color
end
