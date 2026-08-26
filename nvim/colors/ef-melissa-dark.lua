-- ef-melissa-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#352718', -- bg
      base01 = '#59463f', -- bg_dim
      base02 = '#443a4f', -- selection
      base03 = '#eab780', -- comments
      base04 = '#90918a', -- fg_dim
      base05 = '#e8e4b1', -- fg
      base06 = '#e8e4b1', -- fg
      base07 = '#e8e4b1', -- fg
      base08 = '#ff7f4f', -- error / red
      base09 = '#e8e4b1', -- numbers / constants
      base0A = '#65d590', -- types
      base0B = '#ffa21f', -- strings
      base0C = '#e7a06f', -- special
      base0D = '#6fd560', -- functions
      base0E = '#e4b53f', -- keywords
      base0F = '#eab780', -- delimiters
   },
})
vim.g.colors_name = 'ef-melissa-dark'

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
hi('Boolean', { fg = '#98bfff' })
hi('Bracket', { fg = '#90918a' })
hi('Character', { fg = '#ffa21f' })
hi('ColorColumn', { bg = '#79665f' })
hi('Comment', { fg = '#eab780', italic = true })
hi('Conditional', { fg = '#e4b53f', bold = true })
hi('Constant', { fg = '#98bfff' })
hi('Cursor', { bg = '#f9cf7a' })
hi('CursorLine', { bg = '#4f311f' })
hi('CursorLineNr', { fg = '#ffa21f', bold = true })
hi('Debug', { fg = '#ffa21f', bold = true })
hi('Define', { fg = '#e4b53f', bold = true })
hi('Delimiter', { fg = '#eab780' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#ffa21f' })
hi('Error', { fg = '#ff7f4f', bold = true })
hi('ErrorMsg', { fg = '#ff7f4f', bold = true })
hi('Exception', { fg = '#e4b53f', bold = true })
hi('Float', { fg = '#98bfff' })
hi('FloatBorder', { fg = '#6f5f58' })
hi('FoldColumn', { fg = '#e8e4b1' })
hi('Folded', { fg = '#90918a' })
hi('Function', { fg = '#6fd560' })
hi('FunctionCall', { fg = '#6fd560' })
hi('Identifier', { fg = '#6fcad0' })
hi('Ignore', { fg = '#90918a' })
hi('Include', { fg = '#e4b53f', bold = true })
hi('Keyword', { fg = '#e4b53f', bold = true })
hi('Label', { fg = '#e4b53f', bold = true })
hi('LineNr', { fg = '#90918a' })
hi('Macro', { fg = '#ff7f4f' })
hi('MoreMsg', { fg = '#6fd560', bold = true })
hi('NonText', { fg = '#90918a' })
hi('Normal', { fg = '#e8e4b1', bg = '#352718' })
hi('NormalFloat', { fg = '#e8e4b1', bg = '#79665f' })
hi('Number', { fg = '#e8e4b1' })
hi('Operator', { fg = '#e8e4b1' })
hi('Parameter', { fg = '#e4b53f' })
hi('PmenuSbar', { fg = '#6f5f58', bg = '#352718' })
hi('PmenuThumb', { fg = '#e8e4b1', bg = '#60518f' })
hi('PreCondit', { fg = '#e4b53f', bold = true })
hi('PreProc', { fg = '#ff7f4f' })
hi('Property', { fg = '#ff7f7f' })
hi('Repeat', { fg = '#e4b53f', bold = true })
hi('SignColumn', { fg = '#e8e4b1' })
hi('Special', { fg = '#e7a06f', bold = true })
hi('SpecialChar', { fg = '#ff7f4f' })
hi('SpecialComment', { fg = '#e89a88', italic = true })
hi('SpecialKey', { fg = '#ffa21f', bold = true })
hi('Statement', { fg = '#e4b53f', bold = true })
hi('StatusLine', { fg = '#f8efd8', bg = '#704f00', underline = true })
hi('StatusLineNC', { fg = '#90918a', bg = '#59463f', underline = true })
hi('StorageClass', { fg = '#e4b53f', bold = true })
hi('String', { fg = '#ffa21f' })
hi('Structure', { fg = '#e4b53f', bold = true })
hi('TabLine', { bg = '#59463f' })
hi('TabLineFill', { bg = '#59463f' })
hi('TabLineSel', { bg = '#352718', bold = true })
hi('Tag', { fg = '#dfcfe0', italic = true })
hi('Title', { fg = '#6fd560' })
hi('Todo', { fg = '#ffa21f', bold = true })
hi('Type', { fg = '#65d590', bold = true })
hi('Typedef', { fg = '#e4b53f', bold = true })
hi('Underlined', { fg = '#e4b53f', underline = true })
hi('VertSplit', { fg = '#6f5f58' })
hi('Visual', { bg = '#443a4f' })
hi('VisualNOS', { fg = '#e8e4b1', bg = '#5a661f' })
hi('WarningMsg', { fg = '#ffa21f', bold = true })
hi('WinSeparator', { fg = '#6f5f58' })

-- Terminal palette from the official theme.
local term = {
   '#352718', '#ff7f7f', '#6fd560', '#e4b53f', '#57aff6', '#f0aac5', '#6fcad0', '#90918a',
   '#79665f', '#ff7f4f', '#65d590', '#ffa21f', '#98bfff', '#c6a2fe', '#70e0cf', '#e8e4b1',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
