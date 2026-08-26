-- ef-elea-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#edf5e2', -- bg
      base01 = '#d0d7ca', -- bg_dim
      base02 = '#d9d2ef', -- selection
      base03 = '#7f4f4a', -- comments
      base04 = '#676470', -- fg_dim
      base05 = '#221321', -- fg
      base06 = '#221321', -- fg
      base07 = '#221321', -- fg
      base08 = '#d00000', -- error / red
      base09 = '#221321', -- numbers / constants
      base0A = '#162f8f', -- types
      base0B = '#007047', -- strings
      base0C = '#6a4a9f', -- special
      base0D = '#355500', -- functions
      base0E = '#894852', -- keywords
      base0F = '#7f4f4a', -- delimiters
   },
})
vim.g.colors_name = 'ef-elea-light'

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
hi('Boolean', { fg = '#5032aa' })
hi('Bracket', { fg = '#676470' })
hi('Character', { fg = '#007047' })
hi('ColorColumn', { bg = '#b0b7aa' })
hi('Comment', { fg = '#7f4f4a', italic = true })
hi('Conditional', { fg = '#894852', bold = true })
hi('Constant', { fg = '#5032aa' })
hi('Cursor', { bg = '#770080' })
hi('CursorLine', { bg = '#d0e7c4' })
hi('CursorLineNr', { fg = '#007047', bold = true })
hi('Debug', { fg = '#b04300', bold = true })
hi('Define', { fg = '#894852', bold = true })
hi('Delimiter', { fg = '#7f4f4a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#007047' })
hi('Error', { fg = '#d00000', bold = true })
hi('ErrorMsg', { fg = '#d00000', bold = true })
hi('Exception', { fg = '#894852', bold = true })
hi('Float', { fg = '#5032aa' })
hi('FloatBorder', { fg = '#a5aaaf' })
hi('FoldColumn', { fg = '#221321' })
hi('Folded', { fg = '#676470' })
hi('Function', { fg = '#355500' })
hi('FunctionCall', { fg = '#355500' })
hi('Identifier', { fg = '#80308f' })
hi('Ignore', { fg = '#676470' })
hi('Include', { fg = '#894852', bold = true })
hi('Keyword', { fg = '#894852', bold = true })
hi('Label', { fg = '#894852', bold = true })
hi('LineNr', { fg = '#676470' })
hi('Macro', { fg = '#9f356a' })
hi('MoreMsg', { fg = '#007047', bold = true })
hi('NonText', { fg = '#676470' })
hi('Normal', { fg = '#221321', bg = '#edf5e2' })
hi('NormalFloat', { fg = '#221321', bg = '#b0b7aa' })
hi('Number', { fg = '#221321' })
hi('Operator', { fg = '#221321' })
hi('Parameter', { fg = '#9a501f' })
hi('PmenuSbar', { fg = '#a5aaaf', bg = '#edf5e2' })
hi('PmenuThumb', { fg = '#221321', bg = '#dfbac0' })
hi('PreCondit', { fg = '#894852', bold = true })
hi('PreProc', { fg = '#9f356a' })
hi('Property', { fg = '#5032aa' })
hi('Repeat', { fg = '#894852', bold = true })
hi('SignColumn', { fg = '#221321' })
hi('Special', { fg = '#6a4a9f', bold = true })
hi('SpecialChar', { fg = '#d00000' })
hi('SpecialComment', { fg = '#4f677f', italic = true })
hi('SpecialKey', { fg = '#80308f', bold = true })
hi('Statement', { fg = '#894852', bold = true })
hi('StatusLine', { fg = '#142810', bg = '#a5c67f', underline = true })
hi('StatusLineNC', { fg = '#676470', bg = '#d0d7ca', underline = true })
hi('StorageClass', { fg = '#894852', bold = true })
hi('String', { fg = '#007047' })
hi('Structure', { fg = '#894852', bold = true })
hi('TabLine', { bg = '#d0d7ca' })
hi('TabLineFill', { bg = '#d0d7ca' })
hi('TabLineSel', { bg = '#edf5e2', bold = true })
hi('Tag', { fg = '#6a4a9f', italic = true })
hi('Title', { fg = '#355500' })
hi('Todo', { fg = '#b04300', bold = true })
hi('Type', { fg = '#162f8f', bold = true })
hi('Typedef', { fg = '#894852', bold = true })
hi('Underlined', { fg = '#00601f', underline = true })
hi('VertSplit', { fg = '#a5aaaf' })
hi('Visual', { bg = '#d9d2ef' })
hi('VisualNOS', { fg = '#221321', bg = '#b5dfbf' })
hi('WarningMsg', { fg = '#b04300', bold = true })
hi('WinSeparator', { fg = '#a5aaaf' })

-- Terminal palette from the official theme.
local term = {
   '#221321', '#c3303a', '#00601f', '#9a501f', '#375cc6', '#80308f', '#1f70af', '#b0b7aa',
   '#676470', '#d00000', '#007047', '#b04300', '#444fcf', '#5032aa', '#00677f', '#edf5e2',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
