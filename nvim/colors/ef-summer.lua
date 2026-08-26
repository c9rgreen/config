-- ef-summer -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fff2f3', -- bg
      base01 = '#efd3e4', -- bg_dim
      base02 = '#eecfff', -- selection
      base03 = '#9a5f6a', -- comments
      base04 = '#786e74', -- fg_dim
      base05 = '#4f4073', -- fg
      base06 = '#4f4073', -- fg
      base07 = '#4f4073', -- fg
      base08 = '#e00033', -- error / red
      base09 = '#4f4073', -- numbers / constants
      base0A = '#3f6faf', -- types
      base0B = '#b6532f', -- strings
      base0C = '#ba35af', -- special
      base0D = '#cb1aaa', -- functions
      base0E = '#8e44f3', -- keywords
      base0F = '#9a5f6a', -- delimiters
   },
})
vim.g.colors_name = 'ef-summer'

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
hi('Boolean', { fg = '#d50f7f' })
hi('Bracket', { fg = '#786e74' })
hi('Character', { fg = '#b6532f' })
hi('ColorColumn', { bg = '#cfb3c4' })
hi('Comment', { fg = '#9a5f6a', italic = true })
hi('Conditional', { fg = '#8e44f3', bold = true })
hi('Constant', { fg = '#d50f7f' })
hi('Cursor', { bg = '#cf0090' })
hi('CursorLine', { bg = '#ffd6e5' })
hi('CursorLineNr', { fg = '#8e44f3', bold = true })
hi('Debug', { fg = '#a45f22', bold = true })
hi('Define', { fg = '#8e44f3', bold = true })
hi('Delimiter', { fg = '#9a5f6a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#8e44f3' })
hi('Error', { fg = '#e00033', bold = true })
hi('ErrorMsg', { fg = '#e00033', bold = true })
hi('Exception', { fg = '#8e44f3', bold = true })
hi('Float', { fg = '#d50f7f' })
hi('FloatBorder', { fg = '#c6bbc6' })
hi('FoldColumn', { fg = '#4f4073' })
hi('Folded', { fg = '#786e74' })
hi('Function', { fg = '#cb1aaa' })
hi('FunctionCall', { fg = '#cb1aaa' })
hi('Identifier', { fg = '#5250ef' })
hi('Ignore', { fg = '#786e74' })
hi('Include', { fg = '#8e44f3', bold = true })
hi('Keyword', { fg = '#8e44f3', bold = true })
hi('Label', { fg = '#8e44f3', bold = true })
hi('LineNr', { fg = '#786e74' })
hi('Macro', { fg = '#007f68' })
hi('MoreMsg', { fg = '#007f68', bold = true })
hi('NonText', { fg = '#786e74' })
hi('Normal', { fg = '#4f4073', bg = '#fff2f3' })
hi('NormalFloat', { fg = '#4f4073', bg = '#cfb3c4' })
hi('Number', { fg = '#4f4073' })
hi('Operator', { fg = '#4f4073' })
hi('Parameter', { fg = '#a45f22' })
hi('PmenuSbar', { fg = '#c6bbc6', bg = '#fff2f3' })
hi('PmenuThumb', { fg = '#4f4073', bg = '#b4cfff' })
hi('PreCondit', { fg = '#8e44f3', bold = true })
hi('PreProc', { fg = '#007f68' })
hi('Property', { fg = '#0f7b8f' })
hi('Repeat', { fg = '#8e44f3', bold = true })
hi('SignColumn', { fg = '#4f4073' })
hi('Special', { fg = '#ba35af', bold = true })
hi('SpecialChar', { fg = '#e00033' })
hi('SpecialComment', { fg = '#5f60bf', italic = true })
hi('SpecialKey', { fg = '#d50f7f', bold = true })
hi('Statement', { fg = '#8e44f3', bold = true })
hi('StatusLine', { fg = '#341f58', bg = '#ffa4dc', underline = true })
hi('StatusLineNC', { fg = '#786e74', bg = '#efd3e4', underline = true })
hi('StorageClass', { fg = '#8e44f3', bold = true })
hi('String', { fg = '#b6532f' })
hi('Structure', { fg = '#8e44f3', bold = true })
hi('TabLine', { bg = '#efd3e4' })
hi('TabLineFill', { bg = '#efd3e4' })
hi('TabLineSel', { bg = '#fff2f3', bold = true })
hi('Tag', { fg = '#a45392', italic = true })
hi('Title', { fg = '#cb1aaa' })
hi('Todo', { fg = '#a45f22', bold = true })
hi('Type', { fg = '#3f6faf', bold = true })
hi('Typedef', { fg = '#8e44f3', bold = true })
hi('Underlined', { fg = '#375ce6', underline = true })
hi('VertSplit', { fg = '#c6bbc6' })
hi('Visual', { bg = '#eecfff' })
hi('VisualNOS', { fg = '#4f4073', bg = '#aaeccf' })
hi('WarningMsg', { fg = '#a45f22', bold = true })
hi('WinSeparator', { fg = '#c6bbc6' })

-- Terminal palette from the official theme.
local term = {
   '#4f4073', '#d3303a', '#217a3c', '#a45f22', '#375ce6', '#ba35af', '#1f6fbf', '#cfb3c4',
   '#786e74', '#e00033', '#007f68', '#b6532f', '#5250ef', '#8e44f3', '#0f7b8f', '#fff2f3',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
