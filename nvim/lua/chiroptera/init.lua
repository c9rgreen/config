-- Shared implementation behind colors/chiroptera.lua and its -hard and
-- -soft siblings: a mini.base16 port of Chiroptera, Dawid Kurek's LAB-space
-- day/night color system (MIT):
--   https://dawikur.dev/chiroptera/
--   https://github.com/dawikur/chiroptera
--
-- The values below are the generated colors/chiroptera_{dark,light}_*.vim
-- palettes. Each wing (mode) fixes its foreground and chromatic tones;
-- the contrast level moves only the three background tiers and the six
-- "dim" backgrounds. M.load() then mirrors the upstream colorscheme files:
-- the raw palette is folded into the fg / bg / ui role tables, mini.base16
-- lays the base from those roles, and every group upstream's core.vim and
-- plugins/tree-sitter.vim define is applied on top with upstream's default
-- of italic comments. Upstream's other plugin files cover plugins this
-- config does not install and are left out.

local M = {}

local wings = {
   dark = {
      fg_dim = '#8b8a84', fg = '#a4a29b', fg_bright = '#bdbbb2',
      red     = '#fe7a65', red_bright     = '#fea391',
      green   = '#a9a72d', green_bright   = '#c3bf46',
      blue    = '#6dadaf', blue_bright    = '#85c6c9',
      yellow  = '#e68d32', yellow_bright  = '#fea753',
      magenta = '#dc89ad', magenta_bright = '#f6a2c6',
      cyan    = '#61b197', cyan_bright    = '#79caaf',
      contrast = {
         hard = {
            bg_dim = '#232424', bg = '#2d2d2e', bg_bright = '#424141',
            red_dim = '#630100', green_dim = '#302f00', blue_dim = '#003335',
            yellow_dim = '#462500', magenta_dim = '#580e37', cyan_dim = '#003527',
         },
         normal = {
            bg_dim = '#2d2d2e', bg = '#373737', bg_bright = '#4c4c4a',
            red_dim = '#760004', green_dim = '#3a3900', blue_dim = '#003e41',
            yellow_dim = '#552d00', magenta_dim = '#641b41', cyan_dim = '#004030',
         },
         soft = {
            bg_dim = '#373737', bg = '#424141', bg_bright = '#575755',
            red_dim = '#8a0009', green_dim = '#444400', blue_dim = '#004a4c',
            yellow_dim = '#653600', magenta_dim = '#70264b', cyan_dim = '#004b3a',
         },
      },
   },
   light = {
      fg_dim = '#74736f', fg = '#5d5c5a', fg_bright = '#474745',
      red     = '#b3201b', red_bright     = '#94000b',
      green   = '#5f6000', green_bright   = '#494900',
      blue    = '#226569', blue_bright    = '#004f52',
      yellow  = '#8b4c00', yellow_bright  = '#6c3a00',
      magenta = '#8f4367', magenta_bright = '#762c51',
      cyan    = '#0f6952', cyan_bright    = '#00513e',
      contrast = {
         hard = {
            bg_dim = '#f7f5e7', bg = '#eae7db', bg_bright = '#d0cec3',
            red_dim = '#fee1db', green_dim = '#f2ec71', blue_dim = '#b2f3f6',
            yellow_dim = '#fee2cc', magenta_dim = '#fedfec', cyan_dim = '#a6f8dc',
         },
         normal = {
            bg_dim = '#eae7db', bg = '#dddacf', bg_bright = '#c3c1b8',
            red_dim = '#fed0c6', green_dim = '#e4df65', blue_dim = '#a5e6e9',
            yellow_dim = '#fed2ae', magenta_dim = '#fecde1', cyan_dim = '#99eacf',
         },
         soft = {
            bg_dim = '#dddacf', bg = '#d0cec3', bg_bright = '#b7b4ac',
            red_dim = '#febeb1', green_dim = '#d7d259', blue_dim = '#98d9dc',
            yellow_dim = '#fec18d', magenta_dim = '#febad7', cyan_dim = '#8cddc2',
         },
      },
   },
}

local hues = { 'red', 'green', 'blue', 'yellow', 'magenta', 'cyan' }

-- Mirrors the g:chiroptera dictionary each upstream colors file builds:
-- foreground roles are the bright tones, background roles the dim ones,
-- UI roles the middle ones.
local function roles(contrast)
   local wing = wings[vim.o.background] or wings.dark
   local raw = vim.tbl_extend('force', {}, wing, wing.contrast[contrast])
   raw.contrast = nil

   local fg = { normal = raw.fg, note = raw.fg_dim, mark = raw.fg_bright, ignore = raw.bg_bright }
   local bg = { normal = raw.bg, highlight = raw.bg_dim, mark = raw.bg_bright }
   local ui = { normal = raw.bg_bright, highlight = raw.bg_dim }
   for _, hue in ipairs(hues) do
      fg[hue] = raw[hue .. '_bright']
      bg[hue] = raw[hue .. '_dim']
      ui[hue] = raw[hue]
   end
   return raw, fg, bg, ui
end

-- base16 slots: the UI tier (floats, popup menu, folds) is the "lighter
-- background" slot and the highlight tier (cursor line, selections) the
-- "selection" slot, so mini's own groups for things Chiroptera leaves
-- undefined land on the tiers Chiroptera uses for the same jobs. The
-- syntax slots take Chiroptera's roles: cyan constants, blue types, green
-- strings, bright-magenta functions and specials, yellow statements.
-- Brackets and tag delimiters are fg_dim, which fills the delimiter slot.
local function slots(raw)
   return {
      base00 = raw.bg,
      base01 = raw.bg_bright,
      base02 = raw.bg_dim,
      base03 = raw.fg_dim,
      base04 = raw.fg_dim,
      base05 = raw.fg,
      base06 = raw.fg_bright,
      base07 = raw.fg_bright,
      base08 = raw.red,
      base09 = raw.cyan,
      base0A = raw.blue,
      base0B = raw.green,
      base0C = raw.magenta_bright,
      base0D = raw.magenta_bright,
      base0E = raw.yellow,
      base0F = raw.fg_dim,
   }
end

function M.load(contrast, name)
   local raw, fg, bg, ui = roles(contrast)
   require('mini.base16').setup({ palette = slots(raw) })
   vim.g.colors_name = name

   local hi = function(group, spec) vim.api.nvim_set_hl(0, group, spec) end

   -- Vim, per upstream core.vim. Chiroptera leans on the terminal: the
   -- cursor, Search and IncSearch are reverse video, the gutter and status
   -- line sit flat on the canvas, floats and the popup menu on the UI
   -- tier, and selections are the dim blue.
   hi('ColorColumn',    { bg = ui.normal })
   hi('Conceal',        { fg = fg.ignore })
   hi('Cursor',         { reverse = true })
   hi('CursorColumn',   { bg = bg.highlight })
   hi('CursorIM',       { link = 'Cursor' })
   hi('CursorLine',     { bg = bg.highlight })
   hi('CursorLineNr',   { fg = fg.note, bg = bg.highlight })
   hi('CursorLineFold', { fg = fg.note, bg = bg.highlight })
   hi('CursorLineSign', { bg = bg.highlight })
   hi('DiffAdd',        { bg = bg.green })
   hi('DiffChange',     {})
   hi('DiffDelete',     { bg = bg.red })
   hi('DiffText',       { bg = bg.yellow })
   hi('Directory',      { fg = fg.mark, bold = true })
   hi('EndOfBuffer',    {})
   hi('ErrorMsg',       { fg = ui.red })
   hi('FoldColumn',     { fg = fg.ignore })
   hi('Folded',         { fg = fg.note, bg = ui.normal, italic = true })
   hi('IncSearch',      { reverse = true, underline = true })
   hi('LineNr',         { fg = fg.note })
   hi('LineNrAbove',    { link = 'LineNr' })
   hi('LineNrBelow',    { link = 'LineNr' })
   hi('MatchParen',     { bg = bg.blue, bold = true })
   hi('ModeMsg',        { fg = fg.cyan, italic = true })
   hi('MoreMsg',        { link = 'ModeMsg' })
   hi('MsgArea',        { fg = fg.note })
   hi('MsgSeparator',   {})
   hi('NonText',        { fg = fg.note, italic = true })
   hi('Normal',         { fg = fg.normal, bg = bg.normal })
   hi('NormalFloat',    { fg = fg.normal, bg = ui.normal })
   hi('NormalNC',       { fg = fg.note, bg = bg.normal })
   hi('FloatBorder',    { fg = fg.note, bg = ui.normal })
   hi('FloatFooter',    { link = 'FloatBorder' })
   hi('FloatTitle',     { fg = fg.mark, bg = ui.normal, bold = true })
   hi('Pmenu',          { fg = fg.normal, bg = ui.normal })
   hi('PmenuExtra',     { fg = fg.note, bg = ui.normal })
   hi('PmenuExtraSel',  { fg = fg.note, bg = ui.highlight })
   hi('PmenuKind',      { fg = fg.cyan, bg = ui.normal })
   hi('PmenuKindSel',   { fg = fg.cyan, bg = ui.highlight })
   hi('PmenuMatch',     { fg = fg.mark, bg = ui.normal, bold = true })
   hi('PmenuMatchSel',  { fg = fg.mark, bg = ui.highlight, bold = true })
   hi('PmenuSbar',      { bg = ui.normal })
   hi('PmenuSel',       { fg = fg.normal, bg = ui.highlight })
   hi('PmenuThumb',     { fg = fg.note, reverse = true })
   hi('Question',       { fg = fg.magenta, italic = true })
   hi('QuickFixLine',   { fg = fg.blue })
   hi('Search',         { reverse = true })
   hi('SignColumn',     {})
   hi('SpecialKey',     { fg = fg.ignore })
   hi('SpellBad',       { fg = fg.red, sp = fg.red, undercurl = true })
   hi('SpellCap',       { fg = fg.yellow, sp = fg.yellow, undercurl = true })
   hi('SpellLocal',     { fg = fg.blue, sp = fg.blue, undercurl = true })
   hi('SpellRare',      { fg = fg.magenta, sp = fg.magenta, undercurl = true })
   hi('StatusLine',     { bg = bg.normal })
   hi('StatusLineNC',   { fg = fg.note, bg = bg.normal })
   hi('StatusLineTerm', { link = 'StatusLine' })
   hi('StatusLineTermNC', { link = 'StatusLineNC' })
   hi('Substitute',     { bg = bg.yellow })
   hi('TabLine',        { fg = fg.note })
   hi('TabLineFill',    { fg = fg.note })
   hi('TabLineSel',     { fg = fg.normal })
   hi('TermCursor',     { link = 'Cursor' })
   hi('TermCursorNC',   { fg = fg.note, reverse = true })
   hi('Title',          { fg = fg.cyan })
   hi('VertSplit',      { fg = ui.normal, bold = true })
   hi('WinBar',         { fg = fg.normal, bold = true })
   hi('WinBarNC',       { fg = fg.note })
   hi('WinSeparator',   { fg = ui.normal, bold = true })
   hi('Visual',         { bg = bg.blue })
   hi('VisualNOS',      { link = 'Visual' })
   hi('WarningMsg',     { fg = fg.yellow })
   hi('Whitespace',     { fg = fg.ignore })
   hi('WildMenu',       { bg = ui.normal, reverse = true })
   hi('lCursor',        { link = 'Cursor' })

   -- Syntax, straight from the raw palette as upstream does. Red carries
   -- flow control (conditionals, loops, storage classes), yellow the rest
   -- of the statements, magenta the preprocessor and operators; errors
   -- and Debug are background tints with no foreground of their own.
   hi('Comment',        { fg = raw.fg_dim, italic = true })
   hi('Constant',       { fg = raw.cyan })
   hi('Boolean',        { fg = raw.magenta_bright })
   hi('Character',      { fg = raw.yellow })
   hi('Number',         { fg = raw.blue })
   hi('Float',          { link = 'Number' })
   hi('String',         { fg = raw.green })
   hi('Error',          { bg = raw.red_dim })
   hi('Identifier',     { fg = raw.fg_bright })
   hi('Function',       { fg = raw.magenta_bright })
   hi('Ignore',         {})
   hi('PreProc',        { fg = raw.magenta })
   hi('Define',         { link = 'PreProc' })
   hi('Include',        { link = 'PreProc' })
   hi('Macro',          { fg = raw.cyan_bright })
   hi('PreCondit',      { link = 'PreProc' })
   hi('Special',        { fg = raw.magenta_bright })
   hi('SpecialChar',    { fg = raw.yellow_bright })
   hi('Tag',            { fg = raw.fg_bright, bold = true })
   hi('Delimiter',      {})
   hi('SpecialComment', { fg = raw.magenta })
   hi('Debug',          { bg = raw.blue_dim })
   hi('Statement',      { fg = raw.yellow })
   hi('Conditional',    { fg = raw.red })
   hi('Exception',      { fg = raw.red_bright })
   hi('Keyword',        { link = 'Statement' })
   hi('Label',          { fg = raw.cyan })
   hi('Operator',       { fg = raw.magenta })
   hi('Repeat',         { fg = raw.red })
   hi('Todo',           { fg = raw.yellow_bright, bold = true })
   hi('Type',           { fg = raw.blue })
   hi('StorageClass',   { fg = raw.red })
   hi('Structure',      { link = 'Type' })
   hi('Typedef',        { fg = raw.cyan_bright })
   hi('Underlined',     { underline = true })
   hi('Added',          { link = 'DiffAdd' })
   hi('Changed',        { link = 'DiffChange' })
   hi('Removed',        { link = 'DiffDelete' })

   -- Diagnostics and LSP: bright foregrounds, dim tints behind virtual
   -- text, undercurls that keep a chromatic fg as the terminal fallback.
   local severities = { Error = 'red', Warn = 'yellow', Info = 'blue', Hint = 'cyan', Ok = 'green' }
   for severity, hue in pairs(severities) do
      hi('Diagnostic' .. severity,                { fg = fg[hue] })
      hi('DiagnosticSign' .. severity,            { link = 'Diagnostic' .. severity })
      hi('DiagnosticVirtualText' .. severity,     { fg = fg[hue], bg = bg[hue] })
      hi('DiagnosticUnderline' .. severity,       { fg = fg[hue], sp = fg[hue], undercurl = true })
      hi('DiagnosticFloating' .. severity,        { fg = fg[hue], bg = ui.normal })
      hi('DiagnosticVirtualLines' .. severity,    { link = 'DiagnosticVirtualText' .. severity })
   end
   hi('DiagnosticDeprecated',  { fg = fg.note, strikethrough = true })
   hi('DiagnosticUnnecessary', { fg = fg.ignore })
   hi('LspReferenceText',      { link = 'CursorLine' })
   hi('LspReferenceRead',      { link = 'CursorLine' })
   hi('LspReferenceWrite',     { link = 'CursorLine' })

   -- The Nvim* groups behind Neovim's default colorscheme.
   hi('NvimDarkBlue',     { fg = raw.blue_dim })
   hi('NvimDarkCyan',     { fg = raw.cyan_dim })
   hi('NvimDarkGreen',    { fg = raw.green_dim })
   hi('NvimDarkGrey1',    { fg = raw.bg_dim })
   hi('NvimDarkGrey2',    { fg = raw.bg })
   hi('NvimDarkGrey3',    { fg = raw.bg_bright })
   hi('NvimDarkGrey4',    { fg = raw.fg_dim })
   hi('NvimDarkMagenta',  { fg = raw.magenta_dim })
   hi('NvimDarkRed',      { fg = raw.red_dim })
   hi('NvimDarkYellow',   { fg = raw.yellow_dim })
   hi('NvimLightBlue',    { fg = raw.blue_bright })
   hi('NvimLightCyan',    { fg = raw.cyan_bright })
   hi('NvimLightGreen',   { fg = raw.green_bright })
   hi('NvimLightGrey1',   { fg = raw.fg_bright })
   hi('NvimLightGrey2',   { fg = raw.fg })
   hi('NvimLightGrey3',   { fg = raw.fg_dim })
   hi('NvimLightGrey4',   { fg = raw.bg_bright })
   hi('NvimLightMagenta', { fg = raw.magenta_bright })
   hi('NvimLightRed',     { fg = raw.red_bright })
   hi('NvimLightYellow',  { fg = raw.yellow_bright })

   -- Tree-sitter and LSP semantic tokens, per upstream
   -- plugins/tree-sitter.vim.
   hi('@comment',                   { link = 'Comment' })
   hi('@comment.documentation',     { link = 'Comment' })
   hi('@comment.error',             { fg = raw.red_bright })
   hi('@comment.warning',           { fg = raw.yellow_bright })
   hi('@comment.note',              { fg = raw.cyan_bright })
   hi('@comment.todo',              { link = 'Todo' })
   hi('@constant',                  { link = 'Constant' })
   hi('@constant.builtin',          { fg = raw.cyan_bright })
   hi('@constant.macro',            { fg = raw.cyan_bright })
   hi('@boolean',                   { link = 'Boolean' })
   hi('@character',                 { link = 'Character' })
   hi('@character.special',         { fg = raw.yellow_bright })
   hi('@function',                  { link = 'Function' })
   hi('@function.builtin',          { fg = raw.cyan_bright })
   hi('@function.call',             { fg = raw.magenta_bright })
   hi('@function.method',           { fg = raw.magenta_bright })
   hi('@function.method.call',      { fg = raw.magenta_bright })
   hi('@function.macro',            { fg = raw.cyan_bright })
   hi('@function.special',          { fg = raw.cyan_bright })
   hi('@constructor',               { fg = raw.blue })
   hi('@keyword',                   { link = 'Keyword' })
   hi('@keyword.coroutine',         { fg = raw.red })
   hi('@keyword.debug',             { fg = raw.red_bright })
   hi('@keyword.directive',         { fg = raw.magenta })
   hi('@keyword.directive.define',  { fg = raw.magenta })
   hi('@keyword.modifier',          { fg = raw.red })
   hi('@keyword.return',            { fg = raw.red })
   hi('@keyword.conditional',       { fg = raw.red })
   hi('@keyword.repeat',            { fg = raw.red })
   hi('@keyword.exception',         { fg = raw.red_bright })
   hi('@keyword.function',          { fg = raw.yellow })
   hi('@keyword.import',            { fg = raw.magenta })
   hi('@keyword.operator',          { fg = raw.magenta })
   hi('@keyword.type',              { fg = raw.blue })
   hi('@number',                    { link = 'Number' })
   hi('@number.float',              { link = 'Number' })
   hi('@operator',                  { link = 'Operator' })
   hi('@parameter',                 { fg = raw.fg_bright })
   hi('@property',                  { fg = raw.fg_bright })
   hi('@module',                    { fg = raw.cyan })
   hi('@attribute',                 { fg = raw.cyan_bright })
   hi('@punctuation.delimiter',     {})
   hi('@punctuation.bracket',       { fg = raw.fg_dim })
   hi('@string',                    { link = 'String' })
   hi('@string.documentation',      { link = 'String' })
   hi('@string.escape',             { fg = raw.yellow_bright })
   hi('@string.regexp',             { fg = raw.cyan })
   hi('@string.special',            { fg = raw.yellow_bright })
   hi('@string.special.path',       { fg = raw.cyan })
   hi('@string.special.symbol',     { fg = raw.yellow_bright })
   hi('@string.special.url',        { fg = raw.cyan, underline = true })
   hi('@tag',                       { link = 'Tag' })
   hi('@tag.attribute',             { fg = raw.cyan_bright })
   hi('@tag.builtin',               { link = 'Tag' })
   hi('@tag.delimiter',             { fg = raw.fg_dim })
   hi('@type',                      { link = 'Type' })
   hi('@type.builtin',              { link = 'Type' })
   hi('@type.definition',           { fg = raw.cyan_bright })
   hi('@type.qualifier',            { fg = raw.red })
   hi('@variable',                  { link = 'Identifier' })
   hi('@variable.builtin',          { fg = raw.cyan_bright })
   hi('@variable.member',           { link = '@variable' })
   hi('@variable.parameter',        { link = '@variable' })
   hi('@lsp.type.class',            { link = '@type' })
   hi('@lsp.type.decorator',        { link = '@attribute' })
   hi('@lsp.type.enum',             { link = '@type' })
   hi('@lsp.type.enumMember',       { link = '@module' })
   hi('@lsp.type.event',            { link = '@module' })
   hi('@lsp.type.function',         { link = '@function' })
   hi('@lsp.type.interface',        { link = '@type' })
   hi('@lsp.type.macro',            { link = '@attribute' })
   hi('@lsp.type.method',           { link = '@function' })
   hi('@lsp.type.namespace',        { link = '@module' })
   hi('@lsp.type.parameter',        { link = '@variable' })
   hi('@lsp.type.property',         { link = '@variable' })
   hi('@lsp.type.struct',           { link = '@type' })
   hi('@lsp.type.typeParameter',    { link = '@type' })
   hi('@lsp.type.variable',         { link = '@variable' })
   hi('@lsp.mod.deprecated',        { strikethrough = true })
   hi('@markup.heading',            { fg = raw.cyan, bold = true })
   hi('@markup.heading.1',          { fg = raw.red_bright, bold = true })
   hi('@markup.heading.2',          { fg = raw.yellow_bright, bold = true })
   hi('@markup.heading.3',          { fg = raw.green_bright, bold = true })
   hi('@markup.heading.4',          { fg = raw.cyan_bright, bold = true })
   hi('@markup.heading.5',          { fg = raw.blue_bright, bold = true })
   hi('@markup.heading.6',          { fg = raw.magenta_bright, bold = true })
   hi('@markup.strong',             { bold = true })
   hi('@markup.italic',             { italic = true })
   hi('@markup.link',               { fg = raw.cyan, underline = true })
   hi('@markup.link.label',         { fg = raw.cyan_bright })
   hi('@markup.link.url',           { fg = raw.cyan, underline = true })
   hi('@markup.list',               { fg = raw.yellow })
   hi('@markup.list.checked',       { fg = raw.green_bright })
   hi('@markup.list.unchecked',     { fg = raw.fg_dim })
   hi('@markup.math',               { fg = raw.blue })
   hi('@markup.quote',              { fg = raw.fg_dim, italic = true })
   hi('@markup.raw',                { fg = raw.green })
   hi('@markup.raw.block',          { link = '@markup.raw' })
   hi('@diff.plus',                 { fg = raw.green_bright })
   hi('@diff.minus',                { fg = raw.red_bright })
   hi('@diff.delta',                { fg = raw.yellow_bright })

   -- Terminal palette, per upstream: black is the highlight tier, bright
   -- black the UI tier, white the text and bright white the mark tone.
   local term = {
      raw.bg_dim, raw.red, raw.green, raw.yellow, raw.blue, raw.magenta, raw.cyan, raw.fg,
      raw.bg_bright, raw.red_bright, raw.green_bright, raw.yellow_bright,
      raw.blue_bright, raw.magenta_bright, raw.cyan_bright, raw.fg_bright,
   }
   for i, color in ipairs(term) do
      vim.g['terminal_color_' .. (i - 1)] = color
   end
end

return M
