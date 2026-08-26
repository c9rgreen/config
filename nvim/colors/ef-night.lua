-- ef-night -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#000e17', -- bg
      base01 = '#242e39', -- bg_dim
      base02 = '#253146', -- selection
      base03 = '#cf9f7f', -- comments
      base04 = '#70819f', -- fg_dim
      base05 = '#afbcbf', -- fg
      base06 = '#afbcbf', -- fg
      base07 = '#afbcbf', -- fg
      base08 = '#ef656a', -- error / red
      base09 = '#afbcbf', -- numbers / constants
      base0A = '#c59fcf', -- types
      base0B = '#029fff', -- strings
      base0C = '#00a972', -- special
      base0D = '#3dc0b0', -- functions
      base0E = '#6a88ff', -- keywords
      base0F = '#cf9f7f', -- delimiters
   },
})
vim.g.colors_name = 'ef-night'

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end
hi('@comment', { link = 'Comment' })
hi('@constant', { link = 'Constant' })
hi('@constant.builtin', { link = 'Special' })
hi('@constant.macro', { link = 'Identifier' })
hi('@constructor', { link = 'Special' })
hi('@function', { link = 'Function' })
hi('@function.builtin', { link = 'Special' })
hi('@function.call', { link = 'FunctionCall' })
hi('@function.macro', { link = 'Macro' })
hi('@keyword', { link = 'Keyword' })
hi('@keyword.conditional', { link = 'Conditional' })
hi('@keyword.coroutine', { link = 'Keyword' })
hi('@keyword.directive', { link = 'Keyword' })
hi('@keyword.directive.define', { link = 'Keyword' })
hi('@keyword.exception', { link = 'Exception' })
hi('@keyword.function', { link = 'Keyword' })
hi('@keyword.import', { link = 'Keyword' })
hi('@keyword.repeat', { link = 'Repeat' })
hi('@keyword.storage', { link = 'Keyword' })
hi('@keyword.type', { link = 'Keyword' })
hi('@label', { link = 'Label' })
hi('@lsp.type.class', { link = 'Type' })
hi('@lsp.type.comment', { link = 'Comment' })
hi('@lsp.type.decorator', { link = 'Function' })
hi('@lsp.type.enum', { link = 'Type' })
hi('@lsp.type.enumMember', { link = 'Constant' })
hi('@lsp.type.function', { link = 'Function' })
hi('@lsp.type.interface', { link = 'Type' })
hi('@lsp.type.keyword', { link = 'Keyword' })
hi('@lsp.type.macro', { link = 'Macro' })
hi('@lsp.type.method', { link = 'Function' })
hi('@lsp.type.modifier', { link = 'Keyword' })
hi('@lsp.type.namespace', { link = 'Include' })
hi('@lsp.type.number', { link = 'Number' })
hi('@lsp.type.operator', { link = 'Operator' })
hi('@lsp.type.parameter', { link = 'Parameter' })
hi('@lsp.type.property', { link = 'Property' })
hi('@lsp.type.string', { link = 'String' })
hi('@lsp.type.struct', { link = 'Type' })
hi('@lsp.type.type', { link = 'Type' })
hi('@lsp.type.type.defaultLibrary', { link = 'Special' })
hi('@lsp.type.typeParameter', { link = 'Type' })
hi('@lsp.type.variable', { link = 'Identifier' })
hi('@lsp.typemod.function.declaration', { link = 'Function' })
hi('@lsp.typemod.function.definition', { link = 'Function' })
hi('@lsp.typemod.parameter.declaration', { link = 'Parameter' })
hi('@lsp.typemod.property.declaration', { link = 'Property' })
hi('@lsp.typemod.property.readonly', { link = 'Property' })
hi('@lsp.typemod.type.declaration', { link = 'Type' })
hi('@lsp.typemod.type.defaultLibrary', { link = 'Special' })
hi('@lsp.typemod.type.definition', { link = 'Type' })
hi('@lsp.typemod.variable.declaration', { link = 'Identifier' })
hi('@lsp.typemod.variable.globalScope', { link = 'Identifier' })
hi('@module', { link = 'Include' })
hi('@number', { link = 'Number' })
hi('@operator', { link = 'Operator' })
hi('@property', { link = 'Identifier' })
hi('@punctuation', { link = 'Delimiter' })
hi('@punctuation.bracket', { link = 'Bracket' })
hi('@punctuation.delimiter', { link = 'Delimiter' })
hi('@string', { link = 'String' })
hi('@structure', { link = 'Keyword' })
hi('@tag', { link = 'Tag' })
hi('@type', { link = 'Type' })
hi('@type.builtin', { link = 'Special' })
hi('@type.definition', { link = 'Type' })
hi('@type.enum', { link = 'Type' })
hi('@type.qualifier', { link = 'Keyword' })
hi('@type.struct', { link = 'Type' })
hi('@variable', { link = 'Identifier' })
hi('@variable.builtin', { link = 'Special' })
hi('@variable.member', { link = 'Property' })
hi('@variable.parameter', { link = 'Parameter' })
hi('Boolean', { fg = '#af8aff' })
hi('Bracket', { fg = '#70819f' })
hi('Character', { fg = '#029fff' })
hi('ColorColumn', { bg = '#444e59' })
hi('Comment', { fg = '#cf9f7f', italic = true })
hi('Conditional', { fg = '#6a88ff', bold = true })
hi('Constant', { fg = '#af8aff' })
hi('Cursor', { bg = '#00ccff' })
hi('CursorLine', { bg = '#002255' })
hi('CursorLineNr', { fg = '#029fff', bold = true })
hi('Debug', { fg = '#e6832f', bold = true })
hi('Define', { fg = '#6a88ff', bold = true })
hi('Delimiter', { fg = '#cf9f7f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#029fff' })
hi('Error', { fg = '#ef656a', bold = true })
hi('ErrorMsg', { fg = '#ef656a', bold = true })
hi('Exception', { fg = '#6a88ff', bold = true })
hi('Float', { fg = '#af8aff' })
hi('FloatBorder', { fg = '#3a4a66' })
hi('FoldColumn', { fg = '#afbcbf' })
hi('Folded', { fg = '#70819f' })
hi('Function', { fg = '#3dc0b0' })
hi('FunctionCall', { fg = '#3dc0b0' })
hi('Identifier', { fg = '#6fafff' })
hi('Ignore', { fg = '#70819f' })
hi('Include', { fg = '#6a88ff', bold = true })
hi('Keyword', { fg = '#6a88ff', bold = true })
hi('Label', { fg = '#6a88ff', bold = true })
hi('LineNr', { fg = '#70819f' })
hi('Macro', { fg = '#d56f72' })
hi('MoreMsg', { fg = '#00a972', bold = true })
hi('NonText', { fg = '#70819f' })
hi('Normal', { fg = '#afbcbf', bg = '#000e17' })
hi('NormalFloat', { fg = '#afbcbf', bg = '#444e59' })
hi('Number', { fg = '#afbcbf' })
hi('Operator', { fg = '#afbcbf' })
hi('Parameter', { fg = '#c48502' })
hi('PmenuSbar', { fg = '#3a4a66', bg = '#000e17' })
hi('PmenuThumb', { fg = '#afbcbf', bg = '#6f345a' })
hi('PreCondit', { fg = '#6a88ff', bold = true })
hi('PreProc', { fg = '#d56f72' })
hi('Property', { fg = '#3dc0b0' })
hi('Repeat', { fg = '#6a88ff', bold = true })
hi('SignColumn', { fg = '#afbcbf' })
hi('Special', { fg = '#00a972', bold = true })
hi('SpecialChar', { fg = '#ef656a' })
hi('SpecialComment', { fg = '#92b4df', italic = true })
hi('SpecialKey', { fg = '#00a972', bold = true })
hi('Statement', { fg = '#6a88ff', bold = true })
hi('StatusLine', { fg = '#ceeeff', bg = '#003a7f', underline = true })
hi('StatusLineNC', { fg = '#70819f', bg = '#242e39', underline = true })
hi('StorageClass', { fg = '#6a88ff', bold = true })
hi('String', { fg = '#029fff' })
hi('Structure', { fg = '#6a88ff', bold = true })
hi('TabLine', { bg = '#242e39' })
hi('TabLineFill', { bg = '#242e39' })
hi('TabLineSel', { bg = '#000e17', bold = true })
hi('Tag', { fg = '#c59fcf', italic = true })
hi('Title', { fg = '#3dc0b0' })
hi('Todo', { fg = '#e6832f', bold = true })
hi('Type', { fg = '#c59fcf', bold = true })
hi('Typedef', { fg = '#6a88ff', bold = true })
hi('Underlined', { fg = '#6fafff', underline = true })
hi('VertSplit', { fg = '#3a4a66' })
hi('Visual', { bg = '#253146' })
hi('VisualNOS', { fg = '#afbcbf', bg = '#493737' })
hi('WarningMsg', { fg = '#e6832f', bold = true })
hi('WinSeparator', { fg = '#3a4a66' })

-- Terminal palette from the official theme.
local term = {
   '#000e17', '#ef656a', '#1fa526', '#c48502', '#379cf6', '#d570af', '#4fb0cf', '#70819f',
   '#444e59', '#f47360', '#00a972', '#e6832f', '#6a88ff', '#af8aff', '#3dc0b0', '#afbcbf',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
