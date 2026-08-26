-- ef-autumn -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#0f0e06', -- bg
      base01 = '#36322f', -- bg_dim
      base02 = '#3f1324', -- selection
      base03 = '#cf9f7f', -- comments
      base04 = '#887c8a', -- fg_dim
      base05 = '#cfbcba', -- fg
      base06 = '#cfbcba', -- fg
      base07 = '#cfbcba', -- fg
      base08 = '#f06a3f', -- error / red
      base09 = '#cfbcba', -- numbers / constants
      base0A = '#2fa526', -- types
      base0B = '#f06a3f', -- strings
      base0C = '#ff7a7f', -- special
      base0D = '#3dbbb0', -- functions
      base0E = '#c48702', -- keywords
      base0F = '#cf9f7f', -- delimiters
   },
})
vim.g.colors_name = 'ef-autumn'

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
hi('Boolean', { fg = '#64aa0f' })
hi('Bracket', { fg = '#887c8a' })
hi('Character', { fg = '#f06a3f' })
hi('ColorColumn', { bg = '#56524f' })
hi('Comment', { fg = '#cf9f7f', italic = true })
hi('Conditional', { fg = '#c48702', bold = true })
hi('Constant', { fg = '#64aa0f' })
hi('Cursor', { bg = '#ffaa33' })
hi('CursorLine', { bg = '#302a3a' })
hi('CursorLineNr', { fg = '#00b066', bold = true })
hi('Debug', { fg = '#c48702', bold = true })
hi('Define', { fg = '#c48702', bold = true })
hi('Delimiter', { fg = '#cf9f7f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#00b066' })
hi('Error', { fg = '#f06a3f', bold = true })
hi('ErrorMsg', { fg = '#f06a3f', bold = true })
hi('Exception', { fg = '#c48702', bold = true })
hi('Float', { fg = '#64aa0f' })
hi('FloatBorder', { fg = '#58514f' })
hi('FoldColumn', { fg = '#cfbcba' })
hi('Folded', { fg = '#887c8a' })
hi('Function', { fg = '#3dbbb0' })
hi('FunctionCall', { fg = '#3dbbb0' })
hi('Identifier', { fg = '#6fafff' })
hi('Ignore', { fg = '#887c8a' })
hi('Include', { fg = '#c48702', bold = true })
hi('Keyword', { fg = '#c48702', bold = true })
hi('Label', { fg = '#c48702', bold = true })
hi('LineNr', { fg = '#887c8a' })
hi('Macro', { fg = '#d570af' })
hi('MoreMsg', { fg = '#00b066', bold = true })
hi('NonText', { fg = '#887c8a' })
hi('Normal', { fg = '#cfbcba', bg = '#0f0e06' })
hi('NormalFloat', { fg = '#cfbcba', bg = '#56524f' })
hi('Number', { fg = '#cfbcba' })
hi('Operator', { fg = '#cfbcba' })
hi('Parameter', { fg = '#c48702' })
hi('PmenuSbar', { fg = '#58514f', bg = '#0f0e06' })
hi('PmenuThumb', { fg = '#cfbcba', bg = '#265f4a' })
hi('PreCondit', { fg = '#c48702', bold = true })
hi('PreProc', { fg = '#d570af' })
hi('Property', { fg = '#3dbbb0' })
hi('Repeat', { fg = '#c48702', bold = true })
hi('SignColumn', { fg = '#cfbcba' })
hi('Special', { fg = '#ff7a7f', bold = true })
hi('SpecialChar', { fg = '#f06a3f' })
hi('SpecialComment', { fg = '#5f9f6f', italic = true })
hi('SpecialKey', { fg = '#f06a3f', bold = true })
hi('Statement', { fg = '#c48702', bold = true })
hi('StatusLine', { fg = '#feeeca', bg = '#692a12', underline = true })
hi('StatusLineNC', { fg = '#887c8a', bg = '#36322f', underline = true })
hi('StorageClass', { fg = '#c48702', bold = true })
hi('String', { fg = '#f06a3f' })
hi('Structure', { fg = '#c48702', bold = true })
hi('TabLine', { bg = '#36322f' })
hi('TabLineFill', { bg = '#36322f' })
hi('TabLineSel', { bg = '#0f0e06', bold = true })
hi('Tag', { fg = '#c590af', italic = true })
hi('Title', { fg = '#3dbbb0' })
hi('Todo', { fg = '#c48702', bold = true })
hi('Type', { fg = '#2fa526', bold = true })
hi('Typedef', { fg = '#c48702', bold = true })
hi('Underlined', { fg = '#c48702', underline = true })
hi('VertSplit', { fg = '#58514f' })
hi('Visual', { bg = '#3f1324' })
hi('VisualNOS', { fg = '#cfbcba', bg = '#55345a' })
hi('WarningMsg', { fg = '#c48702', bold = true })
hi('WinSeparator', { fg = '#58514f' })

-- Terminal palette from the official theme.
local term = {
   '#0f0e06', '#ef656a', '#2fa526', '#c48702', '#379cf6', '#d570af', '#4fb0cf', '#887c8a',
   '#56524f', '#f06a3f', '#00b066', '#d0730f', '#6a88ff', '#af8aff', '#3dbbb0', '#cfbcba',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
