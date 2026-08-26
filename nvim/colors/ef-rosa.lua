-- ef-rosa -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#322023', -- bg
      base01 = '#4a3842', -- bg_dim
      base02 = '#45524a', -- selection
      base03 = '#9aba8b', -- comments
      base04 = '#9d9d9d', -- fg_dim
      base05 = '#e4d3e1', -- fg
      base06 = '#e4d3e1', -- fg
      base07 = '#e4d3e1', -- fg
      base08 = '#ff7f5f', -- error / red
      base09 = '#e4d3e1', -- numbers / constants
      base0A = '#7fc5df', -- types
      base0B = '#8ad05a', -- strings
      base0C = '#cfb1ff', -- special
      base0D = '#f28fdf', -- functions
      base0E = '#ffb2d6', -- keywords
      base0F = '#9aba8b', -- delimiters
   },
})
vim.g.colors_name = 'ef-rosa'

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
hi('Boolean', { fg = '#49d081' })
hi('Bracket', { fg = '#9d9d9d' })
hi('Character', { fg = '#8ad05a' })
hi('ColorColumn', { bg = '#6a5862' })
hi('Comment', { fg = '#9aba8b', italic = true })
hi('Conditional', { fg = '#ffb2d6', bold = true })
hi('Constant', { fg = '#49d081' })
hi('Cursor', { bg = '#ef607a' })
hi('CursorLine', { bg = '#42352f' })
hi('CursorLineNr', { fg = '#8ad05a', bold = true })
hi('Debug', { fg = '#f2a85f', bold = true })
hi('Define', { fg = '#ffb2d6', bold = true })
hi('Delimiter', { fg = '#9aba8b' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#8ad05a' })
hi('Error', { fg = '#ff7f5f', bold = true })
hi('ErrorMsg', { fg = '#ff7f5f', bold = true })
hi('Exception', { fg = '#ffb2d6', bold = true })
hi('Float', { fg = '#49d081' })
hi('FloatBorder', { fg = '#6f5f58' })
hi('FoldColumn', { fg = '#e4d3e1' })
hi('Folded', { fg = '#9d9d9d' })
hi('Function', { fg = '#f28fdf' })
hi('FunctionCall', { fg = '#f28fdf' })
hi('Identifier', { fg = '#80dfbf' })
hi('Ignore', { fg = '#9d9d9d' })
hi('Include', { fg = '#ffb2d6', bold = true })
hi('Keyword', { fg = '#ffb2d6', bold = true })
hi('Label', { fg = '#ffb2d6', bold = true })
hi('LineNr', { fg = '#9d9d9d' })
hi('Macro', { fg = '#f0888f' })
hi('MoreMsg', { fg = '#5fbb5f', bold = true })
hi('NonText', { fg = '#9d9d9d' })
hi('Normal', { fg = '#e4d3e1', bg = '#322023' })
hi('NormalFloat', { fg = '#e4d3e1', bg = '#6a5862' })
hi('Number', { fg = '#e4d3e1' })
hi('Operator', { fg = '#e4d3e1' })
hi('Parameter', { fg = '#e4c53f' })
hi('PmenuSbar', { fg = '#6f5f58', bg = '#322023' })
hi('PmenuThumb', { fg = '#e4d3e1', bg = '#3f6a50' })
hi('PreCondit', { fg = '#ffb2d6', bold = true })
hi('PreProc', { fg = '#f0888f' })
hi('Property', { fg = '#f2a85f' })
hi('Repeat', { fg = '#ffb2d6', bold = true })
hi('SignColumn', { fg = '#e4d3e1' })
hi('Special', { fg = '#cfb1ff', bold = true })
hi('SpecialChar', { fg = '#ff7f5f' })
hi('SpecialComment', { fg = '#d8c09f', italic = true })
hi('SpecialKey', { fg = '#f28fdf', bold = true })
hi('Statement', { fg = '#ffb2d6', bold = true })
hi('StatusLine', { fg = '#e8e5e7', bg = '#814558', underline = true })
hi('StatusLineNC', { fg = '#9d9d9d', bg = '#4a3842', underline = true })
hi('StorageClass', { fg = '#ffb2d6', bold = true })
hi('String', { fg = '#8ad05a' })
hi('Structure', { fg = '#ffb2d6', bold = true })
hi('TabLine', { bg = '#4a3842' })
hi('TabLineFill', { bg = '#4a3842' })
hi('TabLineSel', { bg = '#322023', bold = true })
hi('Tag', { fg = '#c59fdf', italic = true })
hi('Title', { fg = '#f28fdf' })
hi('Todo', { fg = '#f2a85f', bold = true })
hi('Type', { fg = '#7fc5df', bold = true })
hi('Typedef', { fg = '#ffb2d6', bold = true })
hi('Underlined', { fg = '#49d081', underline = true })
hi('VertSplit', { fg = '#6f5f58' })
hi('Visual', { bg = '#45524a' })
hi('VisualNOS', { fg = '#e4d3e1', bg = '#6a4f5f' })
hi('WarningMsg', { fg = '#f2a85f', bold = true })
hi('WinSeparator', { fg = '#6f5f58' })

-- Terminal palette from the official theme.
local term = {
   '#322023', '#ff707f', '#5fbb5f', '#e4c53f', '#57aff6', '#ffb2d6', '#5fc0dc', '#9d9d9d',
   '#6a5862', '#ff7f5f', '#49d081', '#f2a85f', '#78b2ff', '#cfb1ff', '#80dfbf', '#e4d3e1',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
