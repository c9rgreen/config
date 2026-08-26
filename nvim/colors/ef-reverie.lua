-- ef-reverie -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#f3eddf', -- bg
      base01 = '#d9cac8', -- bg_dim
      base02 = '#e0d0ba', -- selection
      base03 = '#475d80', -- comments
      base04 = '#6f6877', -- fg_dim
      base05 = '#4f204f', -- fg
      base06 = '#4f204f', -- fg
      base07 = '#4f204f', -- fg
      base08 = '#a73080', -- error / red
      base09 = '#4f204f', -- numbers / constants
      base0A = '#426340', -- types
      base0B = '#a04650', -- strings
      base0C = '#97508f', -- special
      base0D = '#4f60a0', -- functions
      base0E = '#906045', -- keywords
      base0F = '#475d80', -- delimiters
   },
})
vim.g.colors_name = 'ef-reverie'

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
hi('Boolean', { fg = '#5059c0' })
hi('Bracket', { fg = '#6f6877' })
hi('Character', { fg = '#a04650' })
hi('ColorColumn', { bg = '#b9aaa8' })
hi('Comment', { fg = '#475d80', italic = true })
hi('Conditional', { fg = '#906045', bold = true })
hi('Constant', { fg = '#5059c0' })
hi('Cursor', { bg = '#9d5744' })
hi('CursorLine', { bg = '#e7d9e0' })
hi('CursorLineNr', { fg = '#87591f', bold = true })
hi('Debug', { fg = '#a05900', bold = true })
hi('Define', { fg = '#906045', bold = true })
hi('Delimiter', { fg = '#475d80' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#87591f' })
hi('Error', { fg = '#a73080', bold = true })
hi('ErrorMsg', { fg = '#a73080', bold = true })
hi('Exception', { fg = '#906045', bold = true })
hi('Float', { fg = '#5059c0' })
hi('FloatBorder', { fg = '#c5afb6' })
hi('FoldColumn', { fg = '#4f204f' })
hi('Folded', { fg = '#6f6877' })
hi('Function', { fg = '#4f60a0' })
hi('FunctionCall', { fg = '#4f60a0' })
hi('Identifier', { fg = '#9f4e74' })
hi('Ignore', { fg = '#6f6877' })
hi('Include', { fg = '#906045', bold = true })
hi('Keyword', { fg = '#906045', bold = true })
hi('Label', { fg = '#906045', bold = true })
hi('LineNr', { fg = '#6f6877' })
hi('Macro', { fg = '#0b6e8a' })
hi('MoreMsg', { fg = '#3060af', bold = true })
hi('NonText', { fg = '#6f6877' })
hi('Normal', { fg = '#4f204f', bg = '#f3eddf' })
hi('NormalFloat', { fg = '#4f204f', bg = '#b9aaa8' })
hi('Number', { fg = '#4f204f' })
hi('Operator', { fg = '#4f204f' })
hi('Parameter', { fg = '#87591f' })
hi('PmenuSbar', { fg = '#c5afb6', bg = '#f3eddf' })
hi('PmenuThumb', { fg = '#4f204f', bg = '#ddc97f' })
hi('PreCondit', { fg = '#906045', bold = true })
hi('PreProc', { fg = '#0b6e8a' })
hi('Property', { fg = '#a73080' })
hi('Repeat', { fg = '#906045', bold = true })
hi('SignColumn', { fg = '#4f204f' })
hi('Special', { fg = '#97508f', bold = true })
hi('SpecialChar', { fg = '#a73080' })
hi('SpecialComment', { fg = '#7a5c50', italic = true })
hi('SpecialKey', { fg = '#3060af', bold = true })
hi('Statement', { fg = '#906045', bold = true })
hi('StatusLine', { fg = '#523044', bg = '#d1b0df', underline = true })
hi('StatusLineNC', { fg = '#6f6877', bg = '#d9cac8', underline = true })
hi('StorageClass', { fg = '#906045', bold = true })
hi('String', { fg = '#a04650' })
hi('Structure', { fg = '#906045', bold = true })
hi('TabLine', { bg = '#d9cac8' })
hi('TabLineFill', { bg = '#d9cac8' })
hi('TabLineSel', { bg = '#f3eddf', bold = true })
hi('Tag', { fg = '#97508f', italic = true })
hi('Title', { fg = '#4f60a0' })
hi('Todo', { fg = '#a05900', bold = true })
hi('Type', { fg = '#426340', bold = true })
hi('Typedef', { fg = '#906045', bold = true })
hi('Underlined', { fg = '#906045', underline = true })
hi('VertSplit', { fg = '#c5afb6' })
hi('Visual', { bg = '#e0d0ba' })
hi('VisualNOS', { fg = '#4f204f', bg = '#d0c4e4' })
hi('WarningMsg', { fg = '#a05900', bold = true })
hi('WinSeparator', { fg = '#c5afb6' })

-- Terminal palette from the official theme.
local term = {
   '#4f204f', '#ba2d2f', '#007a0a', '#87591f', '#375cc6', '#9f4e74', '#3060af', '#b9aaa8',
   '#6f6877', '#b21f00', '#008250', '#a05900', '#5059c0', '#7755b4', '#0b6e8a', '#f3eddf',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
