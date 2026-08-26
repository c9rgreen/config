-- ef-eagle -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#f1ecd0', -- bg
      base01 = '#cec8ae', -- bg_dim
      base02 = '#ddc5af', -- selection
      base03 = '#6a5937', -- comments
      base04 = '#685f53', -- fg_dim
      base05 = '#231a1f', -- fg
      base06 = '#231a1f', -- fg
      base07 = '#231a1f', -- fg
      base08 = '#9a0000', -- error / red
      base09 = '#231a1f', -- numbers / constants
      base0A = '#226022', -- types
      base0B = '#3a7800', -- strings
      base0C = '#775228', -- special
      base0D = '#882000', -- functions
      base0E = '#702f1f', -- keywords
      base0F = '#6a5937', -- delimiters
   },
})
vim.g.colors_name = 'ef-eagle'

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
hi('Boolean', { fg = '#006e50' })
hi('Bracket', { fg = '#685f53' })
hi('Character', { fg = '#3a7800' })
hi('ColorColumn', { bg = '#aea88e' })
hi('Comment', { fg = '#6a5937', italic = true })
hi('Conditional', { fg = '#702f1f', bold = true })
hi('Constant', { fg = '#006e50' })
hi('Cursor', { bg = '#774400' })
hi('CursorLine', { bg = '#ecdfba' })
hi('CursorLineNr', { fg = '#882000', bold = true })
hi('Debug', { fg = '#843300', bold = true })
hi('Define', { fg = '#702f1f', bold = true })
hi('Delimiter', { fg = '#6a5937' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#882000' })
hi('Error', { fg = '#9a0000', bold = true })
hi('ErrorMsg', { fg = '#9a0000', bold = true })
hi('Exception', { fg = '#702f1f', bold = true })
hi('Float', { fg = '#006e50' })
hi('FloatBorder', { fg = '#7f785f' })
hi('FoldColumn', { fg = '#231a1f' })
hi('Folded', { fg = '#685f53' })
hi('Function', { fg = '#882000' })
hi('FunctionCall', { fg = '#882000' })
hi('Identifier', { fg = '#125a7f' })
hi('Ignore', { fg = '#685f53' })
hi('Include', { fg = '#702f1f', bold = true })
hi('Keyword', { fg = '#702f1f', bold = true })
hi('Label', { fg = '#702f1f', bold = true })
hi('LineNr', { fg = '#685f53' })
hi('Macro', { fg = '#9a0000' })
hi('MoreMsg', { fg = '#226022', bold = true })
hi('NonText', { fg = '#685f53' })
hi('Normal', { fg = '#231a1f', bg = '#f1ecd0' })
hi('NormalFloat', { fg = '#231a1f', bg = '#aea88e' })
hi('Number', { fg = '#231a1f' })
hi('Operator', { fg = '#231a1f' })
hi('Parameter', { fg = '#6b4500' })
hi('PmenuSbar', { fg = '#7f785f', bg = '#f1ecd0' })
hi('PmenuThumb', { fg = '#231a1f', bg = '#c0cbd7' })
hi('PreCondit', { fg = '#702f1f', bold = true })
hi('PreProc', { fg = '#9a0000' })
hi('Property', { fg = '#113384' })
hi('Repeat', { fg = '#702f1f', bold = true })
hi('SignColumn', { fg = '#231a1f' })
hi('Special', { fg = '#775228', bold = true })
hi('SpecialChar', { fg = '#9a0000' })
hi('SpecialComment', { fg = '#42573f', italic = true })
hi('SpecialKey', { fg = '#9a0000', bold = true })
hi('Statement', { fg = '#702f1f', bold = true })
hi('StatusLine', { fg = '#2f1005', bg = '#cfab80', underline = true })
hi('StatusLineNC', { fg = '#685f53', bg = '#cec8ae', underline = true })
hi('StorageClass', { fg = '#702f1f', bold = true })
hi('String', { fg = '#3a7800' })
hi('Structure', { fg = '#702f1f', bold = true })
hi('TabLine', { bg = '#cec8ae' })
hi('TabLineFill', { bg = '#cec8ae' })
hi('TabLineSel', { bg = '#f1ecd0', bold = true })
hi('Tag', { fg = '#603a6f', italic = true })
hi('Title', { fg = '#882000' })
hi('Todo', { fg = '#843300', bold = true })
hi('Type', { fg = '#226022', bold = true })
hi('Typedef', { fg = '#702f1f', bold = true })
hi('Underlined', { fg = '#775228', underline = true })
hi('VertSplit', { fg = '#7f785f' })
hi('Visual', { bg = '#ddc5af' })
hi('VisualNOS', { fg = '#231a1f', bg = '#c5d8a2' })
hi('WarningMsg', { fg = '#843300', bold = true })
hi('WinSeparator', { fg = '#7f785f' })

-- Terminal palette from the official theme.
local term = {
   '#231a1f', '#882000', '#226022', '#6b4500', '#113384', '#822478', '#125a7f', '#aea88e',
   '#685f53', '#9a0000', '#006e50', '#843300', '#3a3da0', '#50119f', '#00676f', '#f1ecd0',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
