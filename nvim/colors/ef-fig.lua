-- ef-fig -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#3b2043', -- bg
      base01 = '#4a385e', -- bg_dim
      base02 = '#643270', -- selection
      base03 = '#9d9d9d', -- comments
      base04 = '#9d9d9d', -- fg_dim
      base05 = '#e4d3e1', -- fg
      base06 = '#e4d3e1', -- fg
      base07 = '#e4d3e1', -- fg
      base08 = '#ef797f', -- error / red
      base09 = '#e4d3e1', -- numbers / constants
      base0A = '#79d081', -- types
      base0B = '#e088af', -- strings
      base0C = '#ffb2d6', -- special
      base0D = '#eec27f', -- functions
      base0E = '#aad05a', -- keywords
      base0F = '#9d9d9d', -- delimiters
   },
})
vim.g.colors_name = 'ef-fig'

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
hi('Boolean', { fg = '#afb1ff' })
hi('Bracket', { fg = '#9d9d9d' })
hi('Character', { fg = '#e088af' })
hi('ColorColumn', { bg = '#6a586e' })
hi('Comment', { fg = '#9d9d9d', italic = true })
hi('Conditional', { fg = '#aad05a', bold = true })
hi('Constant', { fg = '#afb1ff' })
hi('Cursor', { bg = '#e0646a' })
hi('CursorLine', { bg = '#47275f' })
hi('CursorLineNr', { fg = '#aad05a', bold = true })
hi('Debug', { fg = '#e4c53f', bold = true })
hi('Define', { fg = '#aad05a', bold = true })
hi('Delimiter', { fg = '#9d9d9d' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#aad05a' })
hi('Error', { fg = '#ef797f', bold = true })
hi('ErrorMsg', { fg = '#ef797f', bold = true })
hi('Exception', { fg = '#aad05a', bold = true })
hi('Float', { fg = '#afb1ff' })
hi('FloatBorder', { fg = '#796f6e' })
hi('FoldColumn', { fg = '#e4d3e1' })
hi('Folded', { fg = '#9d9d9d' })
hi('Function', { fg = '#eec27f' })
hi('FunctionCall', { fg = '#eec27f' })
hi('Identifier', { fg = '#f2a85f' })
hi('Ignore', { fg = '#9d9d9d' })
hi('Include', { fg = '#aad05a', bold = true })
hi('Keyword', { fg = '#aad05a', bold = true })
hi('Label', { fg = '#aad05a', bold = true })
hi('LineNr', { fg = '#9d9d9d' })
hi('Macro', { fg = '#ff7f5f' })
hi('MoreMsg', { fg = '#7fbb3f', bold = true })
hi('NonText', { fg = '#9d9d9d' })
hi('Normal', { fg = '#e4d3e1', bg = '#3b2043' })
hi('NormalFloat', { fg = '#e4d3e1', bg = '#6a586e' })
hi('Number', { fg = '#e4d3e1' })
hi('Operator', { fg = '#e4d3e1' })
hi('Parameter', { fg = '#e4c53f' })
hi('PmenuSbar', { fg = '#796f6e', bg = '#3b2043' })
hi('PmenuThumb', { fg = '#e4d3e1', bg = '#7f5a60' })
hi('PreCondit', { fg = '#aad05a', bold = true })
hi('PreProc', { fg = '#ff7f5f' })
hi('Property', { fg = '#f2a85f' })
hi('Repeat', { fg = '#aad05a', bold = true })
hi('SignColumn', { fg = '#e4d3e1' })
hi('Special', { fg = '#ffb2d6', bold = true })
hi('SpecialChar', { fg = '#ef797f' })
hi('SpecialComment', { fg = '#c59fcf', italic = true })
hi('SpecialKey', { fg = '#7fbb3f', bold = true })
hi('Statement', { fg = '#aad05a', bold = true })
hi('StatusLine', { fg = '#c8c597', bg = '#57602e', underline = true })
hi('StatusLineNC', { fg = '#9d9d9d', bg = '#4a385e', underline = true })
hi('StorageClass', { fg = '#aad05a', bold = true })
hi('String', { fg = '#e088af' })
hi('Structure', { fg = '#aad05a', bold = true })
hi('TabLine', { bg = '#4a385e' })
hi('TabLineFill', { bg = '#4a385e' })
hi('TabLineSel', { bg = '#3b2043', bold = true })
hi('Tag', { fg = '#c59fcf', italic = true })
hi('Title', { fg = '#eec27f' })
hi('Todo', { fg = '#e4c53f', bold = true })
hi('Type', { fg = '#79d081', bold = true })
hi('Typedef', { fg = '#aad05a', bold = true })
hi('Underlined', { fg = '#ffb2d6', underline = true })
hi('VertSplit', { fg = '#796f6e' })
hi('Visual', { bg = '#643270' })
hi('VisualNOS', { fg = '#e4d3e1', bg = '#6a4f6f' })
hi('WarningMsg', { fg = '#e4c53f', bold = true })
hi('WinSeparator', { fg = '#796f6e' })

-- Terminal palette from the official theme.
local term = {
   '#3b2043', '#ef797f', '#7fbb3f', '#e4c53f', '#57aff6', '#ffb2d6', '#5fc0dc', '#9d9d9d',
   '#6a586e', '#ff7f5f', '#79d081', '#f2a85f', '#78b2ff', '#afb1ff', '#80dfbf', '#e4d3e1',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
