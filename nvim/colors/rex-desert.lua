-- rex-desert -- a mini.base16 port of two Rex themes, from
-- /Applications/Rex Beta.app/Contents/Resources/SuperUI_SuperDesignTokens.bundle/Contents/Resources/themes.json
-- 'background' picks the variant: Sonoran Dusk when dark, Terracotta Noon
-- when light. The surface and text tiers come from Rex's semantic tokens.
-- Rex defines no syntax roles, and neither theme has an orange.
--
-- Sonoran Dusk takes its syntax hues from ANSI; numbers get the bright red
-- and types the amber, which doubles as the accent. Terracotta Noon's ANSI
-- red, yellow, green and blue are too faint on its cream canvas, so those
-- use Rex's semantic text tones; numbers get the terracotta accent.

local palettes = {
   dark = { -- Sonoran Dusk
      base16 = {
         base00 = '#171412', -- canvas
         base01 = '#1e1b19', -- surfaceSubtle
         base02 = '#2c2825', -- controlPressed over surfaceSubtle
         base03 = '#746d64', -- contentTertiary
         base04 = '#938a7e', -- contentSecondary
         base05 = '#ddd0bf', -- content
         base06 = '#f2e9dc', -- selectionForeground
         base07 = '#f2e9dc', -- selectionForeground
         base08 = '#d96e56', -- ANSI 1 / danger
         base09 = '#e88a72', -- ANSI 9
         base0A = '#e0a45c', -- ANSI 3 / warning
         base0B = '#a0b06a', -- ANSI 2 / success
         base0C = '#92b39c', -- ANSI 6
         base0D = '#8598b0', -- ANSI 4 / info
         base0E = '#bd8aa2', -- ANSI 5
         base0F = '#746d64', -- contentTertiary (delimiters)
      },
      accent       = '#e8a860',
      accent_solid = '#e8a860',
      on_accent    = '#171412', -- accentOnSolid
      cursor       = { fg = '#171412', bg = '#e8a860' },
      selection    = '#423528', -- the terminal selection
      stroke       = '#4e4842',
      search       = '#33281e', -- accentContainer
      diff = { add = '#2a291f', change = '#272628', text = '#36393e', delete = '#32211c' },
      term = {
         '#26201c', '#d96e56', '#a0b06a', '#e0a45c', '#8598b0', '#bd8aa2', '#92b39c', '#c2b4a3',
         '#6e6355', '#e88a72', '#b8c786', '#efbc7c', '#a0b2c8', '#d1a5b8', '#accab4', '#f2e9dc',
      },
   },
   light = { -- Terracotta Noon
      base16 = {
         base00 = '#f9efe6', -- canvas
         base01 = '#eee5de', -- surfaceSubtle
         base02 = '#dfd5ce', -- controlPressed over surfaceSubtle
         base03 = '#918276', -- contentTertiary
         base04 = '#766559', -- contentSecondary
         base05 = '#4a382c', -- content
         base06 = '#4a382c', -- content
         base07 = '#4a382c', -- content
         base08 = '#b24226', -- danger
         base09 = '#aa4a26', -- accent
         base0A = '#896000', -- warning
         base0B = '#497125', -- success
         base0C = '#3e8570', -- ANSI 6
         base0D = '#426a98', -- info
         base0E = '#9d5680', -- ANSI 5
         base0F = '#918276', -- contentTertiary (delimiters)
      },
      accent       = '#aa4a26',
      accent_solid = '#be5834',
      on_accent    = '#ffffff', -- accentOnSolid
      cursor       = { fg = '#f9efe6', bg = '#c05a35' },
      selection    = '#f0d4b8', -- the terminal selection
      stroke       = '#d6cac0',
      search       = '#f4e3d8', -- accentContainer
      diff = { add = '#eae5d6', change = '#ebe5e1', text = '#dfdcdb', delete = '#f5e3d8' },
      term = {
         '#4a382c', '#bd4a2d', '#5f8a3a', '#a97a16', '#47709f', '#9d5680', '#3e8570', '#ead9c8',
         '#857262', '#d55c3c', '#72a248', '#c18f22', '#5985b5', '#b36b95', '#4d9d86', '#fefaf5',
      },
   },
}

local c = palettes[vim.o.background] or palettes.dark
local p = c.base16

require('mini.base16').setup({ palette = p })
vim.g.colors_name = 'rex-desert'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- UI: floats sit on the subtle surface inside a stroke-colored frame, splits
-- are a stroke hairline, and the cursor and its line number carry the accent.
hi('NormalFloat',  { fg = p.base05, bg = p.base01 })
hi('FloatBorder',  { fg = c.stroke, bg = p.base01 })
hi('Cursor',       c.cursor)
hi('CursorLineNr', { fg = c.accent, bg = p.base01, bold = true })
hi('MatchParen',   { fg = c.accent, bold = true })
hi('Visual',       { bg = c.selection })
hi('VertSplit',    { fg = c.stroke })
hi('WinSeparator', { fg = c.stroke })
hi('PmenuSel',     { fg = p.base05, bg = p.base02 })

-- Search: resting matches get the accent container, as Rex tints them; the
-- active match is solid accent.
hi('Search',    { fg = c.accent, bg = c.search })
hi('IncSearch', { fg = c.on_accent, bg = c.accent_solid })
hi('CurSearch', { fg = c.on_accent, bg = c.accent_solid })

-- Diffs: background-only tints from Rex's success/info/danger containers, so
-- changed lines keep their syntax colors. DiffText doubles the info tint.
hi('DiffAdd',    { bg = c.diff.add })
hi('DiffChange', { bg = c.diff.change })
hi('DiffText',   { bg = c.diff.text })
hi('DiffDelete', { fg = p.base08, bg = c.diff.delete })

-- Diagnostics follow Rex's semantic colors: mini gives Warn the keyword tone
-- and swaps Info and Hint.
for kind, color in pairs({ Error = p.base08, Warn = p.base0A, Info = p.base0D, Hint = p.base0C, Ok = p.base0B }) do
   hi('Diagnostic' .. kind,          { fg = color })
   hi('DiagnosticFloating' .. kind,  { fg = color, bg = p.base01 })
   hi('DiagnosticUnderline' .. kind, { sp = color, underline = true })
end

-- Syntax: comments use the secondary text tier, so they stay readable while
-- line numbers keep the dimmer tertiary one. Identifier is plain fg and
-- Statement rides the keyword tone (mini gives both the red).
hi('Comment',    { fg = p.base04 })
hi('Identifier', { fg = p.base05 })
hi('Statement',  { fg = p.base0E })

-- Terminal palette: Rex's ANSI colors as-is.
for i, color in ipairs(c.term) do
   vim.g['terminal_color_' .. (i - 1)] = color
end
