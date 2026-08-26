-- ef-tritanopia-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#15050f', -- bg
      base01 = '#352f2f', -- bg_dim
      base02 = '#293140', -- selection
      base03 = '#b07f7f', -- comments
      base04 = '#908890', -- fg_dim
      base05 = '#dfd0d5', -- fg
      base06 = '#dfd0d5', -- fg
      base07 = '#dfd0d5', -- fg
      base08 = '#df4f4f', -- error / red
      base09 = '#dfd0d5', -- numbers / constants
      base0A = '#3f9aaf', -- types
      base0B = '#3fafcf', -- strings
      base0C = '#b0648f', -- special
      base0D = '#a6699f', -- functions
      base0E = '#cf4f5f', -- keywords
      base0F = '#b07f7f', -- delimiters
   },
})
vim.g.colors_name = 'ef-tritanopia-dark'

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
hi('Boolean', { fg = '#d24f7f' })
hi('Bracket', { fg = '#908890' })
hi('Character', { fg = '#3fafcf' })
hi('ColorColumn', { bg = '#554f4f' })
hi('Comment', { fg = '#b07f7f', italic = true })
hi('Conditional', { fg = '#cf4f5f', bold = true })
hi('Constant', { fg = '#d24f7f' })
hi('Cursor', { bg = '#fd3333' })
hi('CursorLine', { bg = '#3f1515' })
hi('CursorLineNr', { fg = '#3fafcf', bold = true })
hi('Debug', { fg = '#c560aa', bold = true })
hi('Define', { fg = '#cf4f5f', bold = true })
hi('Delimiter', { fg = '#b07f7f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#3fafcf' })
hi('Error', { fg = '#df4f4f', bold = true })
hi('ErrorMsg', { fg = '#df4f4f', bold = true })
hi('Exception', { fg = '#cf4f5f', bold = true })
hi('Float', { fg = '#d24f7f' })
hi('FloatBorder', { fg = '#555564' })
hi('FoldColumn', { fg = '#dfd0d5' })
hi('Folded', { fg = '#908890' })
hi('Function', { fg = '#a6699f' })
hi('FunctionCall', { fg = '#a6699f' })
hi('Identifier', { fg = '#4fafaf' })
hi('Ignore', { fg = '#908890' })
hi('Include', { fg = '#cf4f5f', bold = true })
hi('Keyword', { fg = '#cf4f5f', bold = true })
hi('Label', { fg = '#cf4f5f', bold = true })
hi('LineNr', { fg = '#908890' })
hi('Macro', { fg = '#a6699f' })
hi('MoreMsg', { fg = '#3fafcf', bold = true })
hi('NonText', { fg = '#908890' })
hi('Normal', { fg = '#dfd0d5', bg = '#15050f' })
hi('NormalFloat', { fg = '#dfd0d5', bg = '#554f4f' })
hi('Number', { fg = '#dfd0d5' })
hi('Operator', { fg = '#dfd0d5' })
hi('Parameter', { fg = '#c48702' })
hi('PmenuSbar', { fg = '#555564', bg = '#15050f' })
hi('PmenuThumb', { fg = '#dfd0d5', bg = '#00405f' })
hi('PreCondit', { fg = '#cf4f5f', bold = true })
hi('PreProc', { fg = '#a6699f' })
hi('Property', { fg = '#3f9aaf' })
hi('Repeat', { fg = '#cf4f5f', bold = true })
hi('SignColumn', { fg = '#dfd0d5' })
hi('Special', { fg = '#b0648f', bold = true })
hi('SpecialChar', { fg = '#df4f4f' })
hi('SpecialComment', { fg = '#82a0af', italic = true })
hi('SpecialKey', { fg = '#d24f7f', bold = true })
hi('Statement', { fg = '#cf4f5f', bold = true })
hi('StatusLine', { fg = '#ffffff', bg = '#671822', underline = true })
hi('StatusLineNC', { fg = '#908890', bg = '#352f2f', underline = true })
hi('StorageClass', { fg = '#cf4f5f', bold = true })
hi('String', { fg = '#3fafcf' })
hi('Structure', { fg = '#cf4f5f', bold = true })
hi('TabLine', { bg = '#352f2f' })
hi('TabLineFill', { bg = '#352f2f' })
hi('TabLineSel', { bg = '#15050f', bold = true })
hi('Tag', { fg = '#c590af', italic = true })
hi('Title', { fg = '#a6699f' })
hi('Todo', { fg = '#c560aa', bold = true })
hi('Type', { fg = '#3f9aaf', bold = true })
hi('Typedef', { fg = '#cf4f5f', bold = true })
hi('Underlined', { fg = '#3fafcf', underline = true })
hi('VertSplit', { fg = '#555564' })
hi('Visual', { bg = '#293140' })
hi('VisualNOS', { fg = '#dfd0d5', bg = '#5e3e5b' })
hi('WarningMsg', { fg = '#c560aa', bold = true })
hi('WinSeparator', { fg = '#555564' })

-- Terminal palette from the official theme.
local term = {
   '#15050f', '#cf4f5f', '#2fa526', '#c48702', '#379cf6', '#b0648f', '#3fafcf', '#908890',
   '#554f4f', '#df4f4f', '#00b066', '#d0730f', '#6a88ff', '#a6699f', '#4fafaf', '#dfd0d5',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
