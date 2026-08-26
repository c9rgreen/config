-- ef-bio -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#111111', -- bg
      base01 = '#303230', -- bg_dim
      base02 = '#3a3027', -- selection
      base03 = '#b7a07f', -- comments
      base04 = '#808f80', -- fg_dim
      base05 = '#cfdfd5', -- fg
      base06 = '#cfdfd5', -- fg
      base07 = '#cfdfd5', -- fg
      base08 = '#ef6560', -- error / red
      base09 = '#cfdfd5', -- numbers / constants
      base0A = '#7fcfdf', -- types
      base0B = '#af9fff', -- strings
      base0C = '#3fb83f', -- special
      base0D = '#7fc500', -- functions
      base0E = '#00c089', -- keywords
      base0F = '#b7a07f', -- delimiters
   },
})
vim.g.colors_name = 'ef-bio'

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
hi('Boolean', { fg = '#37aff6' })
hi('Bracket', { fg = '#808f80' })
hi('Character', { fg = '#af9fff' })
hi('ColorColumn', { bg = '#505250' })
hi('Comment', { fg = '#b7a07f', italic = true })
hi('Conditional', { fg = '#00c089', bold = true })
hi('Constant', { fg = '#37aff6' })
hi('Cursor', { bg = '#35f038' })
hi('CursorLine', { bg = '#00331f' })
hi('CursorLineNr', { fg = '#00c089', bold = true })
hi('Debug', { fg = '#cfc04f', bold = true })
hi('Define', { fg = '#00c089', bold = true })
hi('Delimiter', { fg = '#b7a07f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#00c089' })
hi('Error', { fg = '#ef6560', bold = true })
hi('ErrorMsg', { fg = '#ef6560', bold = true })
hi('Exception', { fg = '#00c089', bold = true })
hi('Float', { fg = '#37aff6' })
hi('FloatBorder', { fg = '#525959' })
hi('FoldColumn', { fg = '#cfdfd5' })
hi('Folded', { fg = '#808f80' })
hi('Function', { fg = '#7fc500' })
hi('FunctionCall', { fg = '#7fc500' })
hi('Identifier', { fg = '#78afff' })
hi('Ignore', { fg = '#808f80' })
hi('Include', { fg = '#00c089', bold = true })
hi('Keyword', { fg = '#00c089', bold = true })
hi('Label', { fg = '#00c089', bold = true })
hi('LineNr', { fg = '#808f80' })
hi('Macro', { fg = '#5dc0aa' })
hi('MoreMsg', { fg = '#3fb83f', bold = true })
hi('NonText', { fg = '#808f80' })
hi('Normal', { fg = '#cfdfd5', bg = '#111111' })
hi('NormalFloat', { fg = '#cfdfd5', bg = '#505250' })
hi('Number', { fg = '#cfdfd5' })
hi('Operator', { fg = '#cfdfd5' })
hi('Parameter', { fg = '#d4aa02' })
hi('PmenuSbar', { fg = '#525959', bg = '#111111' })
hi('PmenuThumb', { fg = '#cfdfd5', bg = '#4f3f9a' })
hi('PreCondit', { fg = '#00c089', bold = true })
hi('PreProc', { fg = '#5dc0aa' })
hi('Property', { fg = '#e490df' })
hi('Repeat', { fg = '#00c089', bold = true })
hi('SignColumn', { fg = '#cfdfd5' })
hi('Special', { fg = '#3fb83f', bold = true })
hi('SpecialChar', { fg = '#ef6560' })
hi('SpecialComment', { fg = '#7fc07f', italic = true })
hi('SpecialKey', { fg = '#3fb83f', bold = true })
hi('Statement', { fg = '#00c089', bold = true })
hi('StatusLine', { fg = '#d0ffe0', bg = '#00552f', underline = true })
hi('StatusLineNC', { fg = '#808f80', bg = '#303230', underline = true })
hi('StorageClass', { fg = '#00c089', bold = true })
hi('String', { fg = '#af9fff' })
hi('Structure', { fg = '#00c089', bold = true })
hi('TabLine', { bg = '#303230' })
hi('TabLineFill', { bg = '#303230' })
hi('TabLineSel', { bg = '#111111', bold = true })
hi('Tag', { fg = '#caa5bf', italic = true })
hi('Title', { fg = '#7fc500' })
hi('Todo', { fg = '#cfc04f', bold = true })
hi('Type', { fg = '#7fcfdf', bold = true })
hi('Typedef', { fg = '#00c089', bold = true })
hi('Underlined', { fg = '#00c089', underline = true })
hi('VertSplit', { fg = '#525959' })
hi('Visual', { bg = '#3a3027' })
hi('VisualNOS', { fg = '#cfdfd5', bg = '#003e5f' })
hi('WarningMsg', { fg = '#cfc04f', bold = true })
hi('WinSeparator', { fg = '#525959' })

-- Terminal palette from the official theme.
local term = {
   '#111111', '#ef6560', '#3fb83f', '#d4aa02', '#37aff6', '#d38faf', '#6fc5ef', '#808f80',
   '#505250', '#f47360', '#00c089', '#e09a0f', '#78afff', '#af9fff', '#5dc0aa', '#cfdfd5',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
