-- ef-melissa-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fff6d8', -- bg
      base01 = '#e7d7c6', -- bg_dim
      base02 = '#f0d4d8', -- selection
      base03 = '#7f6f1a', -- comments
      base04 = '#68708a', -- fg_dim
      base05 = '#484431', -- fg
      base06 = '#484431', -- fg
      base07 = '#484431', -- fg
      base08 = '#c74400', -- error / red
      base09 = '#484431', -- numbers / constants
      base0A = '#008250', -- types
      base0B = '#c74400', -- strings
      base0C = '#946830', -- special
      base0D = '#5a7400', -- functions
      base0E = '#a26310', -- keywords
      base0F = '#7f6f1a', -- delimiters
   },
})
vim.g.colors_name = 'ef-melissa-light'

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
hi('Boolean', { fg = '#3f60af' })
hi('Bracket', { fg = '#68708a' })
hi('Character', { fg = '#c74400' })
hi('ColorColumn', { bg = '#c7b7a6' })
hi('Comment', { fg = '#7f6f1a', italic = true })
hi('Conditional', { fg = '#a26310', bold = true })
hi('Constant', { fg = '#3f60af' })
hi('Cursor', { bg = '#a07f00' })
hi('CursorLine', { bg = '#fae7b0' })
hi('CursorLineNr', { fg = '#ba5205', bold = true })
hi('Debug', { fg = '#ba5205', bold = true })
hi('Define', { fg = '#a26310', bold = true })
hi('Delimiter', { fg = '#7f6f1a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#ba5205' })
hi('Error', { fg = '#c74400', bold = true })
hi('ErrorMsg', { fg = '#c74400', bold = true })
hi('Exception', { fg = '#a26310', bold = true })
hi('Float', { fg = '#3f60af' })
hi('FloatBorder', { fg = '#c5baa6' })
hi('FoldColumn', { fg = '#484431' })
hi('Folded', { fg = '#68708a' })
hi('Function', { fg = '#5a7400' })
hi('FunctionCall', { fg = '#5a7400' })
hi('Identifier', { fg = '#0f708a' })
hi('Ignore', { fg = '#68708a' })
hi('Include', { fg = '#a26310', bold = true })
hi('Keyword', { fg = '#a26310', bold = true })
hi('Label', { fg = '#a26310', bold = true })
hi('LineNr', { fg = '#68708a' })
hi('Macro', { fg = '#ba5205' })
hi('MoreMsg', { fg = '#007a0a', bold = true })
hi('NonText', { fg = '#68708a' })
hi('Normal', { fg = '#484431', bg = '#fff6d8' })
hi('NormalFloat', { fg = '#484431', bg = '#c7b7a6' })
hi('Number', { fg = '#484431' })
hi('Operator', { fg = '#484431' })
hi('Parameter', { fg = '#a26310' })
hi('PmenuSbar', { fg = '#c5baa6', bg = '#fff6d8' })
hi('PmenuThumb', { fg = '#484431', bg = '#deb4f0' })
hi('PreCondit', { fg = '#a26310', bold = true })
hi('PreProc', { fg = '#ba5205' })
hi('Property', { fg = '#ba2d2f' })
hi('Repeat', { fg = '#a26310', bold = true })
hi('SignColumn', { fg = '#484431' })
hi('Special', { fg = '#946830', bold = true })
hi('SpecialChar', { fg = '#c74400' })
hi('SpecialComment', { fg = '#b05350', italic = true })
hi('SpecialKey', { fg = '#ba5205', bold = true })
hi('Statement', { fg = '#a26310', bold = true })
hi('StatusLine', { fg = '#403328', bg = '#f3cf72', underline = true })
hi('StatusLineNC', { fg = '#68708a', bg = '#e7d7c6', underline = true })
hi('StorageClass', { fg = '#a26310', bold = true })
hi('String', { fg = '#c74400' })
hi('Structure', { fg = '#a26310', bold = true })
hi('TabLine', { bg = '#e7d7c6' })
hi('TabLineFill', { bg = '#e7d7c6' })
hi('TabLineSel', { bg = '#fff6d8', bold = true })
hi('Tag', { fg = '#905ea0', italic = true })
hi('Title', { fg = '#5a7400' })
hi('Todo', { fg = '#ba5205', bold = true })
hi('Type', { fg = '#008250', bold = true })
hi('Typedef', { fg = '#a26310', bold = true })
hi('Underlined', { fg = '#a26310', underline = true })
hi('VertSplit', { fg = '#c5baa6' })
hi('Visual', { bg = '#f0d4d8' })
hi('VisualNOS', { fg = '#484431', bg = '#c4d47a' })
hi('WarningMsg', { fg = '#ba5205', bold = true })
hi('WinSeparator', { fg = '#c5baa6' })

-- Terminal palette from the official theme.
local term = {
   '#484431', '#ba2d2f', '#007a0a', '#a26310', '#375cc6', '#aa3e74', '#3f60af', '#c7b7a6',
   '#68708a', '#c74400', '#008250', '#ba5205', '#5f5fdf', '#6448ca', '#0f708a', '#fff6d8',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
