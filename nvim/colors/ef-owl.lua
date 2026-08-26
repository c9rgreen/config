-- ef-owl -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#292c2f', -- bg
      base01 = '#40474b', -- bg_dim
      base02 = '#404f66', -- selection
      base03 = '#aab2df', -- comments
      base04 = '#857f8f', -- fg_dim
      base05 = '#d0d0d0', -- fg
      base06 = '#d0d0d0', -- fg
      base07 = '#d0d0d0', -- fg
      base08 = '#df885f', -- error / red
      base09 = '#d0d0d0', -- numbers / constants
      base0A = '#cfa0e8', -- types
      base0B = '#7ac0b9', -- strings
      base0C = '#80a4e0', -- special
      base0D = '#60bd90', -- functions
      base0E = '#99bfd0', -- keywords
      base0F = '#aab2df', -- delimiters
   },
})
vim.g.colors_name = 'ef-owl'

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
hi('Boolean', { fg = '#cf9f90' })
hi('Bracket', { fg = '#857f8f' })
hi('Character', { fg = '#7ac0b9' })
hi('ColorColumn', { bg = '#60676b' })
hi('Comment', { fg = '#aab2df', italic = true })
hi('Conditional', { fg = '#99bfd0', bold = true })
hi('Constant', { fg = '#cf9f90' })
hi('Cursor', { bg = '#afe6ef' })
hi('CursorLine', { bg = '#344255' })
hi('CursorLineNr', { fg = '#7ac0b9', bold = true })
hi('Debug', { fg = '#d1a45f', bold = true })
hi('Define', { fg = '#99bfd0', bold = true })
hi('Delimiter', { fg = '#aab2df' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#7ac0b9' })
hi('Error', { fg = '#df885f', bold = true })
hi('ErrorMsg', { fg = '#df885f', bold = true })
hi('Exception', { fg = '#99bfd0', bold = true })
hi('Float', { fg = '#cf9f90' })
hi('FloatBorder', { fg = '#4f5f66' })
hi('FoldColumn', { fg = '#d0d0d0' })
hi('Folded', { fg = '#857f8f' })
hi('Function', { fg = '#60bd90' })
hi('FunctionCall', { fg = '#60bd90' })
hi('Identifier', { fg = '#a0a0ef' })
hi('Ignore', { fg = '#857f8f' })
hi('Include', { fg = '#99bfd0', bold = true })
hi('Keyword', { fg = '#99bfd0', bold = true })
hi('Label', { fg = '#99bfd0', bold = true })
hi('LineNr', { fg = '#857f8f' })
hi('Macro', { fg = '#98c06f' })
hi('MoreMsg', { fg = '#70bb70', bold = true })
hi('NonText', { fg = '#857f8f' })
hi('Normal', { fg = '#d0d0d0', bg = '#292c2f' })
hi('NormalFloat', { fg = '#d0d0d0', bg = '#60676b' })
hi('Number', { fg = '#d0d0d0' })
hi('Operator', { fg = '#d0d0d0' })
hi('Parameter', { fg = '#c09f6f' })
hi('PmenuSbar', { fg = '#4f5f66', bg = '#292c2f' })
hi('PmenuThumb', { fg = '#d0d0d0', bg = '#8f7a7f' })
hi('PreCondit', { fg = '#99bfd0', bold = true })
hi('PreProc', { fg = '#98c06f' })
hi('Property', { fg = '#d67869' })
hi('Repeat', { fg = '#99bfd0', bold = true })
hi('SignColumn', { fg = '#d0d0d0' })
hi('Special', { fg = '#80a4e0', bold = true })
hi('SpecialChar', { fg = '#df885f' })
hi('SpecialComment', { fg = '#9fb3a7', italic = true })
hi('SpecialKey', { fg = '#60bd90', bold = true })
hi('Statement', { fg = '#99bfd0', bold = true })
hi('StatusLine', { fg = '#dadfe5', bg = '#5b637e', underline = true })
hi('StatusLineNC', { fg = '#857f8f', bg = '#40474b', underline = true })
hi('StorageClass', { fg = '#99bfd0', bold = true })
hi('String', { fg = '#7ac0b9' })
hi('Structure', { fg = '#99bfd0', bold = true })
hi('TabLine', { bg = '#40474b' })
hi('TabLineFill', { bg = '#40474b' })
hi('TabLineSel', { bg = '#292c2f', bold = true })
hi('Tag', { fg = '#e5bbd7', italic = true })
hi('Title', { fg = '#60bd90' })
hi('Todo', { fg = '#d1a45f', bold = true })
hi('Type', { fg = '#cfa0e8', bold = true })
hi('Typedef', { fg = '#99bfd0', bold = true })
hi('Underlined', { fg = '#99bfd0', underline = true })
hi('VertSplit', { fg = '#4f5f66' })
hi('Visual', { bg = '#404f66' })
hi('VisualNOS', { fg = '#d0d0d0', bg = '#415960' })
hi('WarningMsg', { fg = '#d1a45f', bold = true })
hi('WinSeparator', { fg = '#4f5f66' })

-- Terminal palette from the official theme.
local term = {
   '#292c2f', '#d67869', '#70bb70', '#c09f6f', '#80a4e0', '#e5a0ea', '#8fb8ea', '#857f8f',
   '#60676b', '#df885f', '#60bd90', '#d1a45f', '#a0a0ef', '#cfa0e8', '#7ac0b9', '#d0d0d0',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
