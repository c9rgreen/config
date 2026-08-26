-- ef-deuteranopia-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#000a1f', -- bg
      base01 = '#243145', -- bg_dim
      base02 = '#223848', -- selection
      base03 = '#af9a6a', -- comments
      base04 = '#7f8797', -- fg_dim
      base05 = '#ddddee', -- fg
      base06 = '#ddddee', -- fg
      base07 = '#ddddee', -- fg
      base08 = '#cfaf00', -- error / red
      base09 = '#ddddee', -- numbers / constants
      base0A = '#9f95ff', -- types
      base0B = '#3f90f0', -- strings
      base0C = '#6a9fff', -- special
      base0D = '#bfaf7a', -- functions
      base0E = '#cfaf00', -- keywords
      base0F = '#af9a6a', -- delimiters
   },
})
vim.g.colors_name = 'ef-deuteranopia-dark'

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
hi('Boolean', { fg = '#009fff' })
hi('Bracket', { fg = '#7f8797' })
hi('Character', { fg = '#3f90f0' })
hi('ColorColumn', { bg = '#445165' })
hi('Comment', { fg = '#af9a6a', italic = true })
hi('Conditional', { fg = '#cfaf00', bold = true })
hi('Constant', { fg = '#009fff' })
hi('Cursor', { bg = '#ffff00' })
hi('CursorLine', { bg = '#2e2e1b' })
hi('CursorLineNr', { fg = '#009fff', bold = true })
hi('Debug', { fg = '#bfaf7a', bold = true })
hi('Define', { fg = '#cfaf00', bold = true })
hi('Delimiter', { fg = '#af9a6a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#009fff' })
hi('Error', { fg = '#cfaf00', bold = true })
hi('ErrorMsg', { fg = '#cfaf00', bold = true })
hi('Exception', { fg = '#cfaf00', bold = true })
hi('Float', { fg = '#009fff' })
hi('FloatBorder', { fg = '#555a64' })
hi('FoldColumn', { fg = '#ddddee' })
hi('Folded', { fg = '#7f8797' })
hi('Function', { fg = '#bfaf7a' })
hi('FunctionCall', { fg = '#bfaf7a' })
hi('Identifier', { fg = '#0db0ff' })
hi('Ignore', { fg = '#7f8797' })
hi('Include', { fg = '#cfaf00', bold = true })
hi('Keyword', { fg = '#cfaf00', bold = true })
hi('Label', { fg = '#cfaf00', bold = true })
hi('LineNr', { fg = '#7f8797' })
hi('Macro', { fg = '#aa9f32' })
hi('MoreMsg', { fg = '#009fff', bold = true })
hi('NonText', { fg = '#7f8797' })
hi('Normal', { fg = '#ddddee', bg = '#000a1f' })
hi('NormalFloat', { fg = '#ddddee', bg = '#445165' })
hi('Number', { fg = '#ddddee' })
hi('Operator', { fg = '#ddddee' })
hi('Parameter', { fg = '#aa9f32' })
hi('PmenuSbar', { fg = '#555a64', bg = '#000a1f' })
hi('PmenuThumb', { fg = '#ddddee', bg = '#4f4f00' })
hi('PreCondit', { fg = '#cfaf00', bold = true })
hi('PreProc', { fg = '#aa9f32' })
hi('Property', { fg = '#7fafff' })
hi('Repeat', { fg = '#cfaf00', bold = true })
hi('SignColumn', { fg = '#ddddee' })
hi('Special', { fg = '#6a9fff', bold = true })
hi('SpecialChar', { fg = '#cfaf00' })
hi('SpecialComment', { fg = '#8aa0df', italic = true })
hi('SpecialKey', { fg = '#cfaf00', bold = true })
hi('Statement', { fg = '#cfaf00', bold = true })
hi('StatusLine', { fg = '#ffffff', bg = '#003f8f', underline = true })
hi('StatusLineNC', { fg = '#7f8797', bg = '#243145', underline = true })
hi('StorageClass', { fg = '#cfaf00', bold = true })
hi('String', { fg = '#3f90f0' })
hi('Structure', { fg = '#cfaf00', bold = true })
hi('TabLine', { bg = '#243145' })
hi('TabLineFill', { bg = '#243145' })
hi('TabLineSel', { bg = '#000a1f', bold = true })
hi('Tag', { fg = '#c59fcf', italic = true })
hi('Title', { fg = '#bfaf7a' })
hi('Todo', { fg = '#bfaf7a', bold = true })
hi('Type', { fg = '#9f95ff', bold = true })
hi('Typedef', { fg = '#cfaf00', bold = true })
hi('Underlined', { fg = '#3f90f0', underline = true })
hi('VertSplit', { fg = '#555a64' })
hi('Visual', { bg = '#223848' })
hi('VisualNOS', { fg = '#ddddee', bg = '#00405f' })
hi('WarningMsg', { fg = '#bfaf7a', bold = true })
hi('WinSeparator', { fg = '#555a64' })

-- Terminal palette from the official theme.
local term = {
   '#000a1f', '#cf8560', '#3faa26', '#aa9f32', '#3f90f0', '#b379bf', '#5faaef', '#7f8797',
   '#445165', '#e47360', '#3fa672', '#cfaf00', '#6a9fff', '#9f95ff', '#0db0ff', '#ddddee',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
