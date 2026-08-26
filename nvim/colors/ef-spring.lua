-- ef-spring -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#f6fff9', -- bg
      base01 = '#e0e6e3', -- bg_dim
      base02 = '#d0e6ff', -- selection
      base03 = '#876450', -- comments
      base04 = '#777294', -- fg_dim
      base05 = '#34494a', -- fg
      base06 = '#34494a', -- fg
      base07 = '#34494a', -- fg
      base08 = '#d03003', -- error / red
      base09 = '#34494a', -- numbers / constants
      base0A = '#9435b4', -- types
      base0B = '#b6540f', -- strings
      base0C = '#1a870f', -- special
      base0D = '#4a7d00', -- functions
      base0E = '#007f68', -- keywords
      base0F = '#876450', -- delimiters
   },
})
vim.g.colors_name = 'ef-spring'

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
hi('Boolean', { fg = '#d03003' })
hi('Bracket', { fg = '#777294' })
hi('Character', { fg = '#b6540f' })
hi('ColorColumn', { bg = '#c0c6c3' })
hi('Comment', { fg = '#876450', italic = true })
hi('Conditional', { fg = '#007f68', bold = true })
hi('Constant', { fg = '#d03003' })
hi('Cursor', { bg = '#bf005f' })
hi('CursorLine', { bg = '#f9e0e5' })
hi('CursorLineNr', { fg = '#1a870f', bold = true })
hi('Debug', { fg = '#a45f22', bold = true })
hi('Define', { fg = '#007f68', bold = true })
hi('Delimiter', { fg = '#876450' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#1a870f' })
hi('Error', { fg = '#d03003', bold = true })
hi('ErrorMsg', { fg = '#d03003', bold = true })
hi('Exception', { fg = '#007f68', bold = true })
hi('Float', { fg = '#d03003' })
hi('FloatBorder', { fg = '#b4c4c0' })
hi('FoldColumn', { fg = '#34494a' })
hi('Folded', { fg = '#777294' })
hi('Function', { fg = '#4a7d00' })
hi('FunctionCall', { fg = '#4a7d00' })
hi('Identifier', { fg = '#1f6fbf' })
hi('Ignore', { fg = '#777294' })
hi('Include', { fg = '#007f68', bold = true })
hi('Keyword', { fg = '#007f68', bold = true })
hi('Label', { fg = '#007f68', bold = true })
hi('LineNr', { fg = '#777294' })
hi('Macro', { fg = '#cb26a0' })
hi('MoreMsg', { fg = '#1a870f', bold = true })
hi('NonText', { fg = '#777294' })
hi('Normal', { fg = '#34494a', bg = '#f6fff9' })
hi('NormalFloat', { fg = '#34494a', bg = '#c0c6c3' })
hi('Number', { fg = '#34494a' })
hi('Operator', { fg = '#34494a' })
hi('Parameter', { fg = '#a45f22' })
hi('PmenuSbar', { fg = '#b4c4c0', bg = '#f6fff9' })
hi('PmenuThumb', { fg = '#34494a', bg = '#ffc09f' })
hi('PreCondit', { fg = '#007f68', bold = true })
hi('PreProc', { fg = '#cb26a0' })
hi('Property', { fg = '#375cc6' })
hi('Repeat', { fg = '#007f68', bold = true })
hi('SignColumn', { fg = '#34494a' })
hi('Special', { fg = '#1a870f', bold = true })
hi('SpecialChar', { fg = '#d03003' })
hi('SpecialComment', { fg = '#a04360', italic = true })
hi('SpecialKey', { fg = '#cb26a0', bold = true })
hi('Statement', { fg = '#007f68', bold = true })
hi('StatusLine', { fg = '#243228', bg = '#90e8b0', underline = true })
hi('StatusLineNC', { fg = '#777294', bg = '#e0e6e3', underline = true })
hi('StorageClass', { fg = '#007f68', bold = true })
hi('String', { fg = '#b6540f' })
hi('Structure', { fg = '#007f68', bold = true })
hi('TabLine', { bg = '#e0e6e3' })
hi('TabLineFill', { bg = '#e0e6e3' })
hi('TabLineSel', { bg = '#f6fff9', bold = true })
hi('Tag', { fg = '#a04360', italic = true })
hi('Title', { fg = '#4a7d00' })
hi('Todo', { fg = '#a45f22', bold = true })
hi('Type', { fg = '#9435b4', bold = true })
hi('Typedef', { fg = '#007f68', bold = true })
hi('Underlined', { fg = '#0f7b8f', underline = true })
hi('VertSplit', { fg = '#b4c4c0' })
hi('Visual', { bg = '#d0e6ff' })
hi('VisualNOS', { fg = '#34494a', bg = '#f0bfff' })
hi('WarningMsg', { fg = '#a45f22', bold = true })
hi('WinSeparator', { fg = '#b4c4c0' })

-- Terminal palette from the official theme.
local term = {
   '#34494a', '#c42d2f', '#1a870f', '#a45f22', '#375cc6', '#d5206f', '#1f6fbf', '#c0c6c3',
   '#777294', '#d03003', '#007f68', '#b6540f', '#5f5fdf', '#9435b4', '#0f7b8f', '#f6fff9',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
