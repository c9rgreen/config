-- ef-atlantis -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#1a143e', -- bg
      base01 = '#272a3e', -- bg_dim
      base02 = '#32446b', -- selection
      base03 = '#7a7fff', -- comments
      base04 = '#7f8385', -- fg_dim
      base05 = '#bfcccf', -- fg
      base06 = '#bfcccf', -- fg
      base07 = '#bfcccf', -- fg
      base08 = '#ef798f', -- error / red
      base09 = '#bfcccf', -- numbers / constants
      base0A = '#6a88ff', -- types
      base0B = '#6fafff', -- strings
      base0C = '#00a962', -- special
      base0D = '#af9ef2', -- functions
      base0E = '#5db2b7', -- keywords
      base0F = '#7a7fff', -- delimiters
   },
})
vim.g.colors_name = 'ef-atlantis'

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
hi('Boolean', { fg = '#379cf6' })
hi('Bracket', { fg = '#7f8385' })
hi('Character', { fg = '#6fafff' })
hi('ColorColumn', { bg = '#3a4661' })
hi('Comment', { fg = '#7a7fff', italic = true })
hi('Conditional', { fg = '#5db2b7', bold = true })
hi('Constant', { fg = '#379cf6' })
hi('Cursor', { bg = '#baa1ab' })
hi('CursorLine', { bg = '#2b265b' })
hi('CursorLineNr', { fg = '#6a88ff', bold = true })
hi('Debug', { fg = '#b5967b', bold = true })
hi('Define', { fg = '#5db2b7', bold = true })
hi('Delimiter', { fg = '#7a7fff' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#6a88ff' })
hi('Error', { fg = '#ef798f', bold = true })
hi('ErrorMsg', { fg = '#ef798f', bold = true })
hi('Exception', { fg = '#5db2b7', bold = true })
hi('Float', { fg = '#379cf6' })
hi('FloatBorder', { fg = '#454e59' })
hi('FoldColumn', { fg = '#bfcccf' })
hi('Folded', { fg = '#7f8385' })
hi('Function', { fg = '#af9ef2' })
hi('FunctionCall', { fg = '#af9ef2' })
hi('Identifier', { fg = '#77b22f' })
hi('Ignore', { fg = '#7f8385' })
hi('Include', { fg = '#5db2b7', bold = true })
hi('Keyword', { fg = '#5db2b7', bold = true })
hi('Label', { fg = '#5db2b7', bold = true })
hi('LineNr', { fg = '#7f8385' })
hi('Macro', { fg = '#b5967b' })
hi('MoreMsg', { fg = '#00a962', bold = true })
hi('NonText', { fg = '#7f8385' })
hi('Normal', { fg = '#bfcccf', bg = '#1a143e' })
hi('NormalFloat', { fg = '#bfcccf', bg = '#3a4661' })
hi('Number', { fg = '#bfcccf' })
hi('Operator', { fg = '#bfcccf' })
hi('Parameter', { fg = '#c48502' })
hi('PmenuSbar', { fg = '#454e59', bg = '#1a143e' })
hi('PmenuThumb', { fg = '#bfcccf', bg = '#5f4f7a' })
hi('PreCondit', { fg = '#5db2b7', bold = true })
hi('PreProc', { fg = '#b5967b' })
hi('Property', { fg = '#5db2b7' })
hi('Repeat', { fg = '#5db2b7', bold = true })
hi('SignColumn', { fg = '#bfcccf' })
hi('Special', { fg = '#00a962', bold = true })
hi('SpecialChar', { fg = '#ef798f' })
hi('SpecialComment', { fg = '#90becf', italic = true })
hi('SpecialKey', { fg = '#5db2b7', bold = true })
hi('Statement', { fg = '#5db2b7', bold = true })
hi('StatusLine', { fg = '#aaccff', bg = '#124a67', underline = true })
hi('StatusLineNC', { fg = '#7f8385', bg = '#272a3e', underline = true })
hi('StorageClass', { fg = '#5db2b7', bold = true })
hi('String', { fg = '#6fafff' })
hi('Structure', { fg = '#5db2b7', bold = true })
hi('TabLine', { bg = '#272a3e' })
hi('TabLineFill', { bg = '#272a3e' })
hi('TabLineSel', { bg = '#1a143e', bold = true })
hi('Tag', { fg = '#c5a4cf', italic = true })
hi('Title', { fg = '#af9ef2' })
hi('Todo', { fg = '#b5967b', bold = true })
hi('Type', { fg = '#6a88ff', bold = true })
hi('Typedef', { fg = '#5db2b7', bold = true })
hi('Underlined', { fg = '#6fafff', underline = true })
hi('VertSplit', { fg = '#454e59' })
hi('Visual', { bg = '#32446b' })
hi('VisualNOS', { fg = '#bfcccf', bg = '#2d3e4a' })
hi('WarningMsg', { fg = '#b5967b', bold = true })
hi('WinSeparator', { fg = '#454e59' })

-- Terminal palette from the official theme.
local term = {
   '#1a143e', '#ef656a', '#1fa526', '#c48502', '#379cf6', '#d590af', '#4fb0cf', '#7f8385',
   '#3a4661', '#f47360', '#00a962', '#e6832f', '#6a88ff', '#af9ef2', '#5db2b7', '#bfcccf',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
