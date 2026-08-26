-- ef-tritanopia-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fff9f9', -- bg
      base01 = '#ddd9d9', -- bg_dim
      base02 = '#dadadf', -- selection
      base03 = '#92454f', -- comments
      base04 = '#756275', -- fg_dim
      base05 = '#1a1a1a', -- fg
      base06 = '#1a1a1a', -- fg
      base07 = '#1a1a1a', -- fg
      base08 = '#dd0000', -- error / red
      base09 = '#1a1a1a', -- numbers / constants
      base0A = '#2f5faf', -- types
      base0B = '#2070af', -- strings
      base0C = '#aa357f', -- special
      base0D = '#af40af', -- functions
      base0E = '#aa0010', -- keywords
      base0F = '#92454f', -- delimiters
   },
})
vim.g.colors_name = 'ef-tritanopia-light'

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
hi('Boolean', { fg = '#c50f4f' })
hi('Bracket', { fg = '#756275' })
hi('Character', { fg = '#2070af' })
hi('ColorColumn', { bg = '#bdb9b9' })
hi('Comment', { fg = '#92454f', italic = true })
hi('Conditional', { fg = '#aa0010', bold = true })
hi('Constant', { fg = '#c50f4f' })
hi('Cursor', { bg = '#bb0000' })
hi('CursorLine', { bg = '#ffdadf' })
hi('CursorLineNr', { fg = '#2070af', bold = true })
hi('Debug', { fg = '#aa357f', bold = true })
hi('Define', { fg = '#aa0010', bold = true })
hi('Delimiter', { fg = '#92454f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#2070af' })
hi('Error', { fg = '#dd0000', bold = true })
hi('ErrorMsg', { fg = '#dd0000', bold = true })
hi('Exception', { fg = '#aa0010', bold = true })
hi('Float', { fg = '#c50f4f' })
hi('FloatBorder', { fg = '#adadad' })
hi('FoldColumn', { fg = '#1a1a1a' })
hi('Folded', { fg = '#756275' })
hi('Function', { fg = '#af40af' })
hi('FunctionCall', { fg = '#af40af' })
hi('Identifier', { fg = '#007faa' })
hi('Ignore', { fg = '#756275' })
hi('Include', { fg = '#aa0010', bold = true })
hi('Keyword', { fg = '#aa0010', bold = true })
hi('Label', { fg = '#aa0010', bold = true })
hi('LineNr', { fg = '#756275' })
hi('Macro', { fg = '#af40af' })
hi('MoreMsg', { fg = '#2070af', bold = true })
hi('NonText', { fg = '#756275' })
hi('Normal', { fg = '#1a1a1a', bg = '#fff9f9' })
hi('NormalFloat', { fg = '#1a1a1a', bg = '#bdb9b9' })
hi('Number', { fg = '#1a1a1a' })
hi('Operator', { fg = '#1a1a1a' })
hi('Parameter', { fg = '#805d00' })
hi('PmenuSbar', { fg = '#adadad', bg = '#fff9f9' })
hi('PmenuThumb', { fg = '#1a1a1a', bg = '#8fcfff' })
hi('PreCondit', { fg = '#aa0010', bold = true })
hi('PreProc', { fg = '#af40af' })
hi('Property', { fg = '#2f5faf' })
hi('Repeat', { fg = '#aa0010', bold = true })
hi('SignColumn', { fg = '#1a1a1a' })
hi('Special', { fg = '#aa357f', bold = true })
hi('SpecialChar', { fg = '#dd0000' })
hi('SpecialComment', { fg = '#5f6a90', italic = true })
hi('SpecialKey', { fg = '#c50f4f', bold = true })
hi('Statement', { fg = '#aa0010', bold = true })
hi('StatusLine', { fg = '#1a0a0f', bg = '#ff99aa', underline = true })
hi('StatusLineNC', { fg = '#756275', bg = '#ddd9d9', underline = true })
hi('StorageClass', { fg = '#aa0010', bold = true })
hi('String', { fg = '#2070af' })
hi('Structure', { fg = '#aa0010', bold = true })
hi('TabLine', { bg = '#ddd9d9' })
hi('TabLineFill', { bg = '#ddd9d9' })
hi('TabLineSel', { bg = '#fff9f9', bold = true })
hi('Tag', { fg = '#7f4580', italic = true })
hi('Title', { fg = '#af40af' })
hi('Todo', { fg = '#aa357f', bold = true })
hi('Type', { fg = '#2f5faf', bold = true })
hi('Typedef', { fg = '#aa0010', bold = true })
hi('Underlined', { fg = '#2070af', underline = true })
hi('VertSplit', { fg = '#adadad' })
hi('Visual', { bg = '#dadadf' })
hi('VisualNOS', { fg = '#1a1a1a', bg = '#eda9dc' })
hi('WarningMsg', { fg = '#aa357f', bold = true })
hi('WinSeparator', { fg = '#adadad' })

-- Terminal palette from the official theme.
local term = {
   '#1a1a1a', '#aa0010', '#217a3c', '#805d00', '#375cd8', '#aa357f', '#2070af', '#bdb9b9',
   '#756275', '#dd0000', '#008058', '#965000', '#4250ef', '#af40af', '#007faa', '#fff9f9',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
