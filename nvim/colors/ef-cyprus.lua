-- ef-cyprus -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fcf7ef', -- bg
      base01 = '#e5e3d8', -- bg_dim
      base02 = '#e0e7e5', -- selection
      base03 = '#8f6f4a', -- comments
      base04 = '#59786f', -- fg_dim
      base05 = '#242521', -- fg
      base06 = '#242521', -- fg
      base07 = '#242521', -- fg
      base08 = '#dd0020', -- error / red
      base09 = '#242521', -- numbers / constants
      base0A = '#444fcf', -- types
      base0B = '#ca3400', -- strings
      base0C = '#557400', -- special
      base0D = '#a7601f', -- functions
      base0E = '#006f00', -- keywords
      base0F = '#8f6f4a', -- delimiters
   },
})
vim.g.colors_name = 'ef-cyprus'

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
hi('Boolean', { fg = '#00824f' })
hi('Bracket', { fg = '#59786f' })
hi('Character', { fg = '#ca3400' })
hi('ColorColumn', { bg = '#c5c3b8' })
hi('Comment', { fg = '#8f6f4a', italic = true })
hi('Conditional', { fg = '#006f00', bold = true })
hi('Constant', { fg = '#00824f' })
hi('Cursor', { bg = '#007f00' })
hi('CursorLine', { bg = '#f0e0d4' })
hi('CursorLineNr', { fg = '#006f00', bold = true })
hi('Debug', { fg = '#a7601f', bold = true })
hi('Define', { fg = '#006f00', bold = true })
hi('Delimiter', { fg = '#8f6f4a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#006f00' })
hi('Error', { fg = '#dd0020', bold = true })
hi('ErrorMsg', { fg = '#dd0020', bold = true })
hi('Exception', { fg = '#006f00', bold = true })
hi('Float', { fg = '#00824f' })
hi('FloatBorder', { fg = '#c4c0b6' })
hi('FoldColumn', { fg = '#242521' })
hi('Folded', { fg = '#59786f' })
hi('Function', { fg = '#a7601f' })
hi('FunctionCall', { fg = '#a7601f' })
hi('Identifier', { fg = '#007a9f' })
hi('Ignore', { fg = '#59786f' })
hi('Include', { fg = '#006f00', bold = true })
hi('Keyword', { fg = '#006f00', bold = true })
hi('Label', { fg = '#006f00', bold = true })
hi('LineNr', { fg = '#59786f' })
hi('Macro', { fg = '#9f0d0f' })
hi('MoreMsg', { fg = '#006f00', bold = true })
hi('NonText', { fg = '#59786f' })
hi('Normal', { fg = '#242521', bg = '#fcf7ef' })
hi('NormalFloat', { fg = '#242521', bg = '#c5c3b8' })
hi('Number', { fg = '#242521' })
hi('Operator', { fg = '#242521' })
hi('Parameter', { fg = '#a7601f' })
hi('PmenuSbar', { fg = '#c4c0b6', bg = '#fcf7ef' })
hi('PmenuThumb', { fg = '#242521', bg = '#efc26f' })
hi('PreCondit', { fg = '#006f00', bold = true })
hi('PreProc', { fg = '#9f0d0f' })
hi('Property', { fg = '#007a9f' })
hi('Repeat', { fg = '#006f00', bold = true })
hi('SignColumn', { fg = '#242521' })
hi('Special', { fg = '#557400', bold = true })
hi('SpecialChar', { fg = '#dd0020' })
hi('SpecialComment', { fg = '#4f677f', italic = true })
hi('SpecialKey', { fg = '#9f0d0f', bold = true })
hi('Statement', { fg = '#006f00', bold = true })
hi('StatusLine', { fg = '#142010', bg = '#c0df6f', underline = true })
hi('StatusLineNC', { fg = '#59786f', bg = '#e5e3d8', underline = true })
hi('StorageClass', { fg = '#006f00', bold = true })
hi('String', { fg = '#ca3400' })
hi('Structure', { fg = '#006f00', bold = true })
hi('TabLine', { bg = '#e5e3d8' })
hi('TabLineFill', { bg = '#e5e3d8' })
hi('TabLineSel', { bg = '#fcf7ef', bold = true })
hi('Tag', { fg = '#804f60', italic = true })
hi('Title', { fg = '#a7601f' })
hi('Todo', { fg = '#a7601f', bold = true })
hi('Type', { fg = '#444fcf', bold = true })
hi('Typedef', { fg = '#006f00', bold = true })
hi('Underlined', { fg = '#a7601f', underline = true })
hi('VertSplit', { fg = '#c4c0b6' })
hi('Visual', { bg = '#e0e7e5' })
hi('VisualNOS', { fg = '#242521', bg = '#afc0f0' })
hi('WarningMsg', { fg = '#a7601f', bold = true })
hi('WinSeparator', { fg = '#c4c0b6' })

-- Terminal palette from the official theme.
local term = {
   '#242521', '#9f0d0f', '#006f00', '#a7601f', '#375cc6', '#9a456f', '#1f70af', '#c5c3b8',
   '#59786f', '#dd0020', '#00824f', '#bf4400', '#444fcf', '#8448aa', '#007a9f', '#fcf7ef',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
