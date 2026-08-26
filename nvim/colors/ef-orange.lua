-- ef-orange -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#ffedc9', -- bg
      base01 = '#e9d0a8', -- bg_dim
      base02 = '#eeb48f', -- selection
      base03 = '#6f6a70', -- comments
      base04 = '#6f6a70', -- fg_dim
      base05 = '#6c4631', -- fg
      base06 = '#6c4631', -- fg
      base07 = '#6c4631', -- fg
      base08 = '#c13f00', -- error / red
      base09 = '#6c4631', -- numbers / constants
      base0A = '#aa4f30', -- types
      base0B = '#5f7200', -- strings
      base0C = '#ba2d2f', -- special
      base0D = '#cf2030', -- functions
      base0E = '#c13f00', -- keywords
      base0F = '#6f6a70', -- delimiters
   },
})
vim.g.colors_name = 'ef-orange'

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
hi('Boolean', { fg = '#a05a22' })
hi('Bracket', { fg = '#6f6a70' })
hi('Character', { fg = '#5f7200' })
hi('ColorColumn', { bg = '#c9b088' })
hi('Comment', { fg = '#6f6a70', italic = true })
hi('Conditional', { fg = '#c13f00', bold = true })
hi('Constant', { fg = '#a05a22' })
hi('Cursor', { bg = '#cf5f00' })
hi('CursorLine', { bg = '#ffdaa6' })
hi('CursorLineNr', { fg = '#c13f00', bold = true })
hi('Debug', { fg = '#a05a22', bold = true })
hi('Define', { fg = '#c13f00', bold = true })
hi('Delimiter', { fg = '#6f6a70' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#c13f00' })
hi('Error', { fg = '#c13f00', bold = true })
hi('ErrorMsg', { fg = '#c13f00', bold = true })
hi('Exception', { fg = '#c13f00', bold = true })
hi('Float', { fg = '#a05a22' })
hi('FloatBorder', { fg = '#cfbe9b' })
hi('FoldColumn', { fg = '#6c4631' })
hi('Folded', { fg = '#6f6a70' })
hi('Function', { fg = '#cf2030' })
hi('FunctionCall', { fg = '#cf2030' })
hi('Identifier', { fg = '#2f783f' })
hi('Ignore', { fg = '#6f6a70' })
hi('Include', { fg = '#c13f00', bold = true })
hi('Keyword', { fg = '#c13f00', bold = true })
hi('Label', { fg = '#c13f00', bold = true })
hi('LineNr', { fg = '#6f6a70' })
hi('Macro', { fg = '#3f6fa2' })
hi('MoreMsg', { fg = '#5f7200', bold = true })
hi('NonText', { fg = '#6f6a70' })
hi('Normal', { fg = '#6c4631', bg = '#ffedc9' })
hi('NormalFloat', { fg = '#6c4631', bg = '#c9b088' })
hi('Number', { fg = '#6c4631' })
hi('Operator', { fg = '#6c4631' })
hi('Parameter', { fg = '#a05a22' })
hi('PmenuSbar', { fg = '#cfbe9b', bg = '#ffedc9' })
hi('PmenuThumb', { fg = '#6c4631', bg = '#c0e47f' })
hi('PreCondit', { fg = '#c13f00', bold = true })
hi('PreProc', { fg = '#3f6fa2' })
hi('Property', { fg = '#a05a22' })
hi('Repeat', { fg = '#c13f00', bold = true })
hi('SignColumn', { fg = '#6c4631' })
hi('Special', { fg = '#ba2d2f', bold = true })
hi('SpecialChar', { fg = '#c13f00' })
hi('SpecialComment', { fg = '#527545', italic = true })
hi('SpecialKey', { fg = '#c13f00', bold = true })
hi('Statement', { fg = '#c13f00', bold = true })
hi('StatusLine', { fg = '#742f18', bg = '#ffc255', underline = true })
hi('StatusLineNC', { fg = '#6f6a70', bg = '#e9d0a8', underline = true })
hi('StorageClass', { fg = '#c13f00', bold = true })
hi('String', { fg = '#5f7200' })
hi('Structure', { fg = '#c13f00', bold = true })
hi('TabLine', { bg = '#e9d0a8' })
hi('TabLineFill', { bg = '#e9d0a8' })
hi('TabLineSel', { bg = '#ffedc9', bold = true })
hi('Tag', { fg = '#a04450', italic = true })
hi('Title', { fg = '#cf2030' })
hi('Todo', { fg = '#a05a22', bold = true })
hi('Type', { fg = '#aa4f30', bold = true })
hi('Typedef', { fg = '#c13f00', bold = true })
hi('Underlined', { fg = '#5f7200', underline = true })
hi('VertSplit', { fg = '#cfbe9b' })
hi('Visual', { bg = '#eeb48f' })
hi('VisualNOS', { fg = '#6c4631', bg = '#ebdc8f' })
hi('WarningMsg', { fg = '#a05a22', bold = true })
hi('WinSeparator', { fg = '#cfbe9b' })

-- Terminal palette from the official theme.
local term = {
   '#6c4631', '#ba2d2f', '#007a0a', '#a05a22', '#375cc6', '#ba3e54', '#467080', '#c9b088',
   '#6f6a70', '#c13f00', '#2f783f', '#b05115', '#5f50df', '#8448aa', '#0f738f', '#ffedc9',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
