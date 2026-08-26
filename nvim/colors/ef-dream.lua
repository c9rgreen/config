-- ef-dream -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#232025', -- bg
      base01 = '#3b393e', -- bg_dim
      base02 = '#544a50', -- selection
      base03 = '#a0a0cf', -- comments
      base04 = '#8f8886', -- fg_dim
      base05 = '#efd5c5', -- fg
      base06 = '#efd5c5', -- fg
      base07 = '#efd5c5', -- fg
      base08 = '#f498c0', -- error / red
      base09 = '#efd5c5', -- numbers / constants
      base0A = '#a9c99f', -- types
      base0B = '#f3a0a0', -- strings
      base0C = '#e3b0c0', -- special
      base0D = '#8fcfd0', -- functions
      base0E = '#deb07a', -- keywords
      base0F = '#a0a0cf', -- delimiters
   },
})
vim.g.colors_name = 'ef-dream'

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
hi('Boolean', { fg = '#80aadf' })
hi('Bracket', { fg = '#8f8886' })
hi('Character', { fg = '#f3a0a0' })
hi('ColorColumn', { bg = '#5b595e' })
hi('Comment', { fg = '#a0a0cf', italic = true })
hi('Conditional', { fg = '#deb07a', bold = true })
hi('Constant', { fg = '#80aadf' })
hi('Cursor', { bg = '#f3c09a' })
hi('CursorLine', { bg = '#412f4f' })
hi('CursorLineNr', { fg = '#deb07a', bold = true })
hi('Debug', { fg = '#d09950', bold = true })
hi('Define', { fg = '#deb07a', bold = true })
hi('Delimiter', { fg = '#a0a0cf' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#deb07a' })
hi('Error', { fg = '#f498c0', bold = true })
hi('ErrorMsg', { fg = '#f498c0', bold = true })
hi('Exception', { fg = '#deb07a', bold = true })
hi('Float', { fg = '#80aadf' })
hi('FloatBorder', { fg = '#635850' })
hi('FoldColumn', { fg = '#efd5c5' })
hi('Folded', { fg = '#8f8886' })
hi('Function', { fg = '#8fcfd0' })
hi('FunctionCall', { fg = '#8fcfd0' })
hi('Identifier', { fg = '#ffaacf' })
hi('Ignore', { fg = '#8f8886' })
hi('Include', { fg = '#deb07a', bold = true })
hi('Keyword', { fg = '#deb07a', bold = true })
hi('Label', { fg = '#deb07a', bold = true })
hi('LineNr', { fg = '#8f8886' })
hi('Macro', { fg = '#65c5a8' })
hi('MoreMsg', { fg = '#6fb3c0', bold = true })
hi('NonText', { fg = '#8f8886' })
hi('Normal', { fg = '#efd5c5', bg = '#232025' })
hi('NormalFloat', { fg = '#efd5c5', bg = '#5b595e' })
hi('Number', { fg = '#efd5c5' })
hi('Operator', { fg = '#efd5c5' })
hi('Parameter', { fg = '#c0b24f' })
hi('PmenuSbar', { fg = '#635850', bg = '#232025' })
hi('PmenuThumb', { fg = '#efd5c5', bg = '#795056' })
hi('PreCondit', { fg = '#deb07a', bold = true })
hi('PreProc', { fg = '#65c5a8' })
hi('Property', { fg = '#f498c0' })
hi('Repeat', { fg = '#deb07a', bold = true })
hi('SignColumn', { fg = '#efd5c5' })
hi('Special', { fg = '#e3b0c0', bold = true })
hi('SpecialChar', { fg = '#f498c0' })
hi('SpecialComment', { fg = '#caa89f', italic = true })
hi('SpecialKey', { fg = '#6fb3c0', bold = true })
hi('Statement', { fg = '#deb07a', bold = true })
hi('StatusLine', { fg = '#fedeff', bg = '#675072', underline = true })
hi('StatusLineNC', { fg = '#8f8886', bg = '#3b393e', underline = true })
hi('StorageClass', { fg = '#deb07a', bold = true })
hi('String', { fg = '#f3a0a0' })
hi('Structure', { fg = '#deb07a', bold = true })
hi('TabLine', { bg = '#3b393e' })
hi('TabLineFill', { bg = '#3b393e' })
hi('TabLineSel', { bg = '#232025', bold = true })
hi('Tag', { fg = '#e3b0c0', italic = true })
hi('Title', { fg = '#8fcfd0' })
hi('Todo', { fg = '#d09950', bold = true })
hi('Type', { fg = '#a9c99f', bold = true })
hi('Typedef', { fg = '#deb07a', bold = true })
hi('Underlined', { fg = '#deb07a', underline = true })
hi('VertSplit', { fg = '#635850' })
hi('Visual', { bg = '#544a50' })
hi('VisualNOS', { fg = '#efd5c5', bg = '#665f7a' })
hi('WarningMsg', { fg = '#d09950', bold = true })
hi('WinSeparator', { fg = '#635850' })

-- Terminal palette from the official theme.
local term = {
   '#232025', '#ff6f6f', '#51b04f', '#c0b24f', '#57b0ff', '#ffaacf', '#6fb3c0', '#8f8886',
   '#5b595e', '#ff7a5f', '#3fc489', '#d09950', '#80aadf', '#d0b0ff', '#65c5a8', '#efd5c5',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
