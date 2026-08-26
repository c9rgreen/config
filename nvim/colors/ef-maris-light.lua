-- ef-maris-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#edf4f8', -- bg
      base01 = '#cfd8e3', -- bg_dim
      base02 = '#c8dcff', -- selection
      base03 = '#8b4052', -- comments
      base04 = '#676470', -- fg_dim
      base05 = '#151a27', -- fg
      base06 = '#151a27', -- fg
      base07 = '#151a27', -- fg
      base08 = '#d00000', -- error / red
      base09 = '#151a27', -- numbers / constants
      base0A = '#007010', -- types
      base0B = '#006f70', -- strings
      base0C = '#6a4a9f', -- special
      base0D = '#3a6f00', -- functions
      base0E = '#444fcf', -- keywords
      base0F = '#8b4052', -- delimiters
   },
})
vim.g.colors_name = 'ef-maris-light'

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
hi('Boolean', { fg = '#003faf' })
hi('Bracket', { fg = '#676470' })
hi('Character', { fg = '#006f70' })
hi('ColorColumn', { bg = '#afb8c3' })
hi('Comment', { fg = '#8b4052', italic = true })
hi('Conditional', { fg = '#444fcf', bold = true })
hi('Constant', { fg = '#003faf' })
hi('Cursor', { bg = '#036f99' })
hi('CursorLine', { bg = '#dae5f0' })
hi('CursorLineNr', { fg = '#003faf', bold = true })
hi('Debug', { fg = '#8b4400', bold = true })
hi('Define', { fg = '#444fcf', bold = true })
hi('Delimiter', { fg = '#8b4052' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#003faf' })
hi('Error', { fg = '#d00000', bold = true })
hi('ErrorMsg', { fg = '#d00000', bold = true })
hi('Exception', { fg = '#444fcf', bold = true })
hi('Float', { fg = '#003faf' })
hi('FloatBorder', { fg = '#a2a6af' })
hi('FoldColumn', { fg = '#151a27' })
hi('Folded', { fg = '#676470' })
hi('Function', { fg = '#3a6f00' })
hi('FunctionCall', { fg = '#3a6f00' })
hi('Identifier', { fg = '#1f66af' })
hi('Ignore', { fg = '#676470' })
hi('Include', { fg = '#444fcf', bold = true })
hi('Keyword', { fg = '#444fcf', bold = true })
hi('Label', { fg = '#444fcf', bold = true })
hi('LineNr', { fg = '#676470' })
hi('Macro', { fg = '#5f2fba' })
hi('MoreMsg', { fg = '#007047', bold = true })
hi('NonText', { fg = '#676470' })
hi('Normal', { fg = '#151a27', bg = '#edf4f8' })
hi('NormalFloat', { fg = '#151a27', bg = '#afb8c3' })
hi('Number', { fg = '#151a27' })
hi('Operator', { fg = '#151a27' })
hi('Parameter', { fg = '#805a1f' })
hi('PmenuSbar', { fg = '#a2a6af', bg = '#edf4f8' })
hi('PmenuThumb', { fg = '#151a27', bg = '#d2b4cf' })
hi('PreCondit', { fg = '#444fcf', bold = true })
hi('PreProc', { fg = '#5f2fba' })
hi('Property', { fg = '#1f66af' })
hi('Repeat', { fg = '#444fcf', bold = true })
hi('SignColumn', { fg = '#151a27' })
hi('Special', { fg = '#6a4a9f', bold = true })
hi('SpecialChar', { fg = '#d00000' })
hi('SpecialComment', { fg = '#3f627f', italic = true })
hi('SpecialKey', { fg = '#003faf', bold = true })
hi('Statement', { fg = '#444fcf', bold = true })
hi('StatusLine', { fg = '#142810', bg = '#a0c2ef', underline = true })
hi('StatusLineNC', { fg = '#676470', bg = '#cfd8e3', underline = true })
hi('StorageClass', { fg = '#444fcf', bold = true })
hi('String', { fg = '#006f70' })
hi('Structure', { fg = '#444fcf', bold = true })
hi('TabLine', { bg = '#cfd8e3' })
hi('TabLineFill', { bg = '#cfd8e3' })
hi('TabLineSel', { bg = '#edf4f8', bold = true })
hi('Tag', { fg = '#6a4a9f', italic = true })
hi('Title', { fg = '#3a6f00' })
hi('Todo', { fg = '#8b4400', bold = true })
hi('Type', { fg = '#007010', bold = true })
hi('Typedef', { fg = '#444fcf', bold = true })
hi('Underlined', { fg = '#375cc6', underline = true })
hi('VertSplit', { fg = '#a2a6af' })
hi('Visual', { bg = '#c8dcff' })
hi('VisualNOS', { fg = '#151a27', bg = '#b7bbea' })
hi('WarningMsg', { fg = '#8b4400', bold = true })
hi('WinSeparator', { fg = '#a2a6af' })

-- Terminal palette from the official theme.
local term = {
   '#151a27', '#c3303a', '#007010', '#805a1f', '#375cc6', '#80308f', '#1f66af', '#afb8c3',
   '#676470', '#d00000', '#007047', '#8b4400', '#444fcf', '#5f2fba', '#006f70', '#edf4f8',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
