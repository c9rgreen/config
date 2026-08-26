-- circadia-forest -- a mini.base16 port of the Circadia palette spec:
-- https://github.com/tanmaymanojgandhi/circadia (spec/palette.json, v2.0.0)
-- 'background' picks the variant: dark_forest when dark, light_parchment when
-- light. Circadia intentionally ships no red -- its terminal ports map ANSI
-- color1 to the amber type tone, and base08 follows suit.
--
-- The overrides below mirror the official Neovim port
-- (ports/neovim/lua/circadia/init.lua): the accent and border tokens live
-- outside the base16 palette, the gutter is flat, search and the pmenu
-- thumb fill with the accent, and the Statement family diverges from mini's
-- slot conventions.

local palettes = {
   dark = {
      base16 = {
         base00 = '#131714', -- bg_canvas
         base01 = '#1a1e1b', -- bg_surface
         base02 = '#242a25', -- bg_element
         base03 = '#909890', -- comments
         base04 = '#9fa9a1', -- text_muted
         base05 = '#c4ccc5', -- text_primary
         base06 = '#c4ccc5', -- text_primary
         base07 = '#c4ccc5', -- text_primary
         base08 = '#d1aa73', -- "red" (circadia has none; ANSI color1 is the amber type tone)
         base09 = '#d19b66', -- numbers
         base0A = '#d1aa73', -- types
         base0B = '#92b87e', -- strings
         base0C = '#d092a9', -- properties
         base0D = '#b29ace', -- functions
         base0E = '#6cb0c5', -- keywords
         base0F = '#838d85', -- text_faint (delimiters)
      },
      border = '#353c36',
      accent = '#83b384',
      diff = { add = '#262f24', change = '#202e2f', text = '#2e4549', delete = '#302d22' },
      term = {
         '#131714', '#d1aa73', '#92b87e', '#d19b66', '#6cb0c5', '#b29ace', '#d19b66', '#c4ccc5',
         '#838d85', '#83bc97', '#92b87e', '#b8e2c4', '#6cb0c5', '#d092a9', '#6cb0c5', '#c4ccc5',
      },
   },
   light = {
      base16 = {
         base00 = '#f7f2e6', -- bg_canvas
         base01 = '#eee7d6', -- bg_surface
         base02 = '#e5dcc6', -- bg_element
         base03 = '#524b42', -- comments
         base04 = '#46535f', -- text_muted
         base05 = '#28323a', -- text_primary
         base06 = '#28323a', -- text_primary
         base07 = '#28323a', -- text_primary
         base08 = '#843900', -- "red" (circadia has none; ANSI color1 is the amber type tone)
         base09 = '#095b62', -- numbers
         base0A = '#843900', -- types
         base0B = '#005f2f', -- strings
         base0C = '#4b1fa3', -- properties
         base0D = '#7a1f7a', -- functions
         base0E = '#0048b3', -- keywords / accent
         base0F = '#43505c', -- text_faint (delimiters)
      },
      border = '#d7cdb7',
      accent = '#0048b3',
      diff = { add = '#d2dccb', change = '#d2d8de', text = '#adbfd7', delete = '#e6d6c4' },
      term = {
         '#e5dcc6', '#843900', '#005f2f', '#095b62', '#0048b3', '#7a1f7a', '#095b62', '#28323a',
         '#43505c', '#1c60a2', '#005f2f', '#1c4470', '#0048b3', '#4b1fa3', '#0048b3', '#28323a',
      },
   },
}

local c = palettes[vim.o.background] or palettes.dark
local p = c.base16

require('mini.base16').setup({ palette = p })
vim.g.colors_name = 'circadia-forest'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- UI, per the official port: floats sit on the surface tier inside a
-- border-colored frame, the cursor and its line number carry the accent,
-- and splits are a border-colored hairline. The port gives LineNr the faint
-- text tone with no background; SignColumn and FoldColumn follow so the
-- whole gutter sits flat on the canvas.
hi('NormalFloat',  { fg = p.base05, bg = p.base01 })
hi('FloatBorder',  { fg = c.border, bg = p.base01 })
hi('Cursor',       { fg = p.base00, bg = c.accent })
hi('CursorLine',   { bg = p.base01 })
hi('CursorLineNr', { fg = c.accent, bold = true })
hi('LineNr',       { fg = p.base0F })
hi('LineNrAbove',  { fg = p.base0F })
hi('LineNrBelow',  { fg = p.base0F })
hi('SignColumn',   { fg = p.base0F })
hi('FoldColumn',   { fg = p.base0F })
hi('MatchParen',   { fg = c.accent, bold = true })
hi('Visual',       { bg = p.base02 })
hi('StatusLine',   { fg = p.base04, bg = p.base01 })
hi('StatusLineNC', { fg = p.base0F, bg = p.base01 })
hi('VertSplit',    { fg = c.border })
hi('WinSeparator', { fg = c.border })
hi('Pmenu',        { fg = p.base05, bg = p.base01 })
hi('PmenuSel',     { fg = p.base05, bg = p.base02 })
hi('PmenuThumb',   { bg = c.accent })
hi('LspReferenceText',  { bg = p.base02 })
hi('LspReferenceRead',  { bg = p.base02 })
hi('LspReferenceWrite', { bg = p.base02 })

-- Search fills with the accent; the active match uses the number tone so it
-- stands apart from the resting matches. The port defines only IncSearch,
-- but CurSearch is what nvim actually paints the current match with, so it
-- follows IncSearch here.
hi('Search',    { fg = p.base00, bg = c.accent })
hi('IncSearch', { fg = p.base00, bg = p.base09 })
hi('CurSearch', { fg = p.base00, bg = p.base09 })

-- Diffs: background-only tints, so diff mode keeps normal syntax
-- highlighting as the foreground of changed sections (mini's default paints
-- Diff* with a fg of its own, which flattens every hunk to one color). The
-- tints are the string/keyword/type tones blended into the canvas; delete
-- keeps the amber fg for its filler lines, which carry no syntax of their
-- own.
hi('DiffAdd',    { bg = c.diff.add })
hi('DiffChange', { bg = c.diff.change })
hi('DiffText',   { bg = c.diff.text })
hi('DiffDelete', { fg = p.base08, bg = c.diff.delete })

-- Syntax, per the official port: comments italic, keywords bold, the whole
-- Statement/PreProc/Tag family rides the keyword tone, Identifier stays
-- plain fg (mini gives it base08), and Special is the accent.
hi('Comment',    { fg = p.base03, italic = true })
hi('Keyword',    { fg = p.base0E, bold = true })
hi('Statement',  { fg = p.base0E })
hi('PreProc',    { fg = p.base0E })
hi('Identifier', { fg = p.base05 })
hi('Constant',   { fg = p.base09 })
hi('Boolean',    { fg = p.base09 })
hi('Tag',        { fg = p.base0E })
hi('Special',    { fg = c.accent })

-- Terminal palette from the upstream kitty port: ANSI "red" is the amber
-- type tone and the brights lean on the heading tints.
for i, color in ipairs(c.term) do
   vim.g['terminal_color_' .. (i - 1)] = color
end
