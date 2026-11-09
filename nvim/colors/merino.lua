-- merino -- a mini.base16 port of Rex's Merino Dark and Merino Light, from
-- /Applications/Rex Beta.app/Contents/Resources/SuperUI_SuperDesignTokens.bundle/Contents/Resources/themes.json
-- 'background' picks the variant. The surface and text tiers come from Rex's
-- semantic tokens and the syntax hues from its ANSI colors, whose normal
-- tones clear 4.9:1 on both backgrounds. Rex defines no syntax roles, and
-- Merino has no orange, so numbers take ANSI 9 (bright red).
--
-- base00 is the terminal background rather than Rex's canvas, so the editor
-- matches the pane it runs in. Merino Dark's subtle surface is 1.04:1 against
-- that background, so its base01 is the raised surface instead.
--
-- Visual is the accent at Rex's accent-ring alpha over the background: Rex's
-- terminal selection is a full fg/bg inversion, which would hide syntax.

local palettes = {
   dark = { -- Merino Dark
      base16 = {
         base00 = '#0d1117', -- terminalBackground
         base01 = '#1e2023', -- surfaceRaised
         base02 = '#2d2f32', -- controlPressed over surfaceRaised
         base03 = '#666a6f', -- contentTertiary
         base04 = '#82878c', -- contentSecondary
         base05 = '#e6edf3', -- content
         base06 = '#ffffff', -- ANSI 15
         base07 = '#ffffff', -- ANSI 15
         base08 = '#ff7b72', -- ANSI 1 / danger
         base09 = '#ffa198', -- ANSI 9
         base0A = '#d29922', -- ANSI 3 / warning
         base0B = '#3fb950', -- ANSI 2 / success
         base0C = '#39c5cf', -- ANSI 6
         base0D = '#58a6ff', -- ANSI 4 / info
         base0E = '#bc8cff', -- ANSI 5
         base0F = '#666a6f', -- contentTertiary (delimiters)
      },
      accent       = '#3485fa',
      accent_solid = '#2f81f7',
      on_accent    = '#0d1117', -- accentOnSolid
      cursor       = { fg = '#eff8ff', bg = '#2f81f7' },
      selection    = '#152946', -- accent at accentRingOuter alpha over the background
      stroke       = '#424549',
      search       = '#142134', -- accentContainer
      diff = { add = '#162822', change = '#182536', text = '#233955', delete = '#2e2125' },
      term = {
         '#484f58', '#ff7b72', '#3fb950', '#d29922', '#58a6ff', '#bc8cff', '#39c5cf', '#b1bac4',
         '#6e7681', '#ffa198', '#56d364', '#e3b341', '#79c0ff', '#d2a8ff', '#56d4dd', '#ffffff',
      },
   },
   light = { -- Merino Light
      base16 = {
         base00 = '#ffffff', -- terminalBackground
         base01 = '#eceef2', -- surfaceSubtle
         base02 = '#dcdee2', -- controlPressed over surfaceSubtle
         base03 = '#878a8e', -- contentTertiary
         base04 = '#696d71', -- contentSecondary
         base05 = '#1f2328', -- content
         base06 = '#1f2328', -- content
         base07 = '#1f2328', -- content
         base08 = '#cf222e', -- ANSI 1 / danger
         base09 = '#a40e26', -- ANSI 9
         base0A = '#9d5c00', -- ANSI 3 / warning
         base0B = '#116329', -- ANSI 2 / success
         base0C = '#1b7c83', -- ANSI 6
         base0D = '#0969da', -- ANSI 4 / accentSolid
         base0E = '#8250df', -- ANSI 5
         base0F = '#878a8e', -- contentTertiary (delimiters)
      },
      accent       = '#0667d8',
      accent_solid = '#0969da',
      on_accent    = '#ffffff', -- accentOnSolid
      cursor       = { fg = '#b6d8ff', bg = '#0969da' },
      selection    = '#d2e4f8', -- accent at accentRingOuter alpha over the background
      stroke       = '#d1d2d5',
      search       = '#e6effc', -- accentContainer
      diff = { add = '#e5ede6', change = '#e6effc', text = '#cddff9', delete = '#fee9e7' },
      term = {
         '#24292f', '#cf222e', '#116329', '#9d5c00', '#0969da', '#8250df', '#1b7c83', '#6e7781',
         '#57606a', '#a40e26', '#1a7f37', '#c47a00', '#218bff', '#a475f9', '#3192aa', '#8c959f',
      },
   },
}

local c = palettes[vim.o.background] or palettes.dark
local p = c.base16

require('mini.base16').setup({ palette = p })
vim.g.colors_name = 'merino'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- UI: floats sit on the base01 surface inside a stroke-colored frame, splits
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
