-- ef-kassio -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fff7f7', -- bg
      base01 = '#e0dbdb', -- bg_dim
      base02 = '#dfe4f4', -- selection
      base03 = '#506fa0', -- comments
      base04 = '#776f79', -- fg_dim
      base05 = '#201f36', -- fg
      base06 = '#201f36', -- fg
      base07 = '#201f36', -- fg
      base08 = '#e00033', -- error / red
      base09 = '#201f36', -- numbers / constants
      base0A = '#b00234', -- types
      base0B = '#a04646', -- strings
      base0C = '#a01f64', -- special
      base0D = '#9f248a', -- functions
      base0E = '#3c3bbe', -- keywords
      base0F = '#506fa0', -- delimiters
   },
})
vim.g.colors_name = 'ef-kassio'

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
hi('Boolean', { fg = '#7022bf' })
hi('Bracket', { fg = '#776f79' })
hi('Character', { fg = '#a04646' })
hi('ColorColumn', { bg = '#c0bbbb' })
hi('Comment', { fg = '#506fa0', italic = true })
hi('Conditional', { fg = '#3c3bbe', bold = true })
hi('Constant', { fg = '#7022bf' })
hi('Cursor', { bg = '#d06f30' })
hi('CursorLine', { bg = '#f2e5d9' })
hi('CursorLineNr', { fg = '#3c3bbe', bold = true })
hi('Debug', { fg = '#b6530f', bold = true })
hi('Define', { fg = '#3c3bbe', bold = true })
hi('Delimiter', { fg = '#506fa0' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#3c3bbe' })
hi('Error', { fg = '#e00033', bold = true })
hi('ErrorMsg', { fg = '#e00033', bold = true })
hi('Exception', { fg = '#3c3bbe', bold = true })
hi('Float', { fg = '#7022bf' })
hi('FloatBorder', { fg = '#bab7bc' })
hi('FoldColumn', { fg = '#201f36' })
hi('Folded', { fg = '#776f79' })
hi('Function', { fg = '#9f248a' })
hi('FunctionCall', { fg = '#9f248a' })
hi('Identifier', { fg = '#4250ef' })
hi('Ignore', { fg = '#776f79' })
hi('Include', { fg = '#3c3bbe', bold = true })
hi('Keyword', { fg = '#3c3bbe', bold = true })
hi('Label', { fg = '#3c3bbe', bold = true })
hi('LineNr', { fg = '#776f79' })
hi('Macro', { fg = '#3f6faf' })
hi('MoreMsg', { fg = '#217a3c', bold = true })
hi('NonText', { fg = '#776f79' })
hi('Normal', { fg = '#201f36', bg = '#fff7f7' })
hi('NormalFloat', { fg = '#201f36', bg = '#c0bbbb' })
hi('Number', { fg = '#201f36' })
hi('Operator', { fg = '#201f36' })
hi('Parameter', { fg = '#9a6012' })
hi('PmenuSbar', { fg = '#bab7bc', bg = '#fff7f7' })
hi('PmenuThumb', { fg = '#201f36', bg = '#c0d0ff' })
hi('PreCondit', { fg = '#3c3bbe', bold = true })
hi('PreProc', { fg = '#3f6faf' })
hi('Property', { fg = '#1077ab' })
hi('Repeat', { fg = '#3c3bbe', bold = true })
hi('SignColumn', { fg = '#201f36' })
hi('Special', { fg = '#a01f64', bold = true })
hi('SpecialChar', { fg = '#e00033' })
hi('SpecialComment', { fg = '#954f90', italic = true })
hi('SpecialKey', { fg = '#b00234', bold = true })
hi('Statement', { fg = '#3c3bbe', bold = true })
hi('StatusLine', { fg = '#151515', bg = '#e0bfba', underline = true })
hi('StatusLineNC', { fg = '#776f79', bg = '#e0dbdb', underline = true })
hi('StorageClass', { fg = '#3c3bbe', bold = true })
hi('String', { fg = '#a04646' })
hi('Structure', { fg = '#3c3bbe', bold = true })
hi('TabLine', { bg = '#e0dbdb' })
hi('TabLineFill', { bg = '#e0dbdb' })
hi('TabLineSel', { bg = '#fff7f7', bold = true })
hi('Tag', { fg = '#954f90', italic = true })
hi('Title', { fg = '#9f248a' })
hi('Todo', { fg = '#b6530f', bold = true })
hi('Type', { fg = '#b00234', bold = true })
hi('Typedef', { fg = '#3c3bbe', bold = true })
hi('Underlined', { fg = '#3c3bbe', underline = true })
hi('VertSplit', { fg = '#bab7bc' })
hi('Visual', { bg = '#dfe4f4' })
hi('VisualNOS', { fg = '#201f36', bg = '#efd5ff' })
hi('WarningMsg', { fg = '#b6530f', bold = true })
hi('WinSeparator', { fg = '#bab7bc' })

-- Terminal palette from the official theme.
local term = {
   '#201f36', '#b00234', '#217a3c', '#9a6012', '#3c3bbe', '#a01f64', '#2f5f9f', '#c0bbbb',
   '#776f79', '#e00033', '#008358', '#b6530f', '#4250ef', '#7022bf', '#1077ab', '#fff7f7',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
