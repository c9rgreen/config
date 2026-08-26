-- standard-wombat -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#242424', -- bg
      base01 = '#303030', -- bg_dim
      base02 = '#4f4f4f', -- selection
      base03 = '#99968b', -- comments
      base04 = '#99968b', -- fg_dim
      base05 = '#f6f3e8', -- fg
      base06 = '#f6f3e8', -- fg
      base07 = '#f6f3e8', -- fg
      base08 = '#e5786d', -- error / red
      base09 = '#f6f3e8', -- numbers / constants
      base0A = '#92a65e', -- types
      base0B = '#95e454', -- strings
      base0C = '#e5786d', -- special
      base0D = '#cae682', -- functions
      base0E = '#8ac6f2', -- keywords
      base0F = '#99968b', -- delimiters
   },
})
vim.g.colors_name = 'standard-wombat'

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
hi('Boolean', { fg = '#e5786d' })
hi('Bracket', { fg = '#99968b' })
hi('Character', { fg = '#95e454' })
hi('ColorColumn', { bg = '#272727' })
hi('Comment', { fg = '#99968b', italic = true })
hi('Conditional', { fg = '#8ac6f2', bold = true })
hi('Constant', { fg = '#e5786d' })
hi('Cursor', { bg = '#656565' })
hi('CursorLine', { bg = '#404040', underline = true })
hi('CursorLineNr', { fg = '#f6f3e8', bg = '#404040', bold = true })
hi('Debug', { fg = '#ff9900', bold = true })
hi('Define', { fg = '#8ac6f2', bold = true })
hi('Delimiter', { fg = '#99968b' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#ceccf2' })
hi('Error', { fg = '#e5786d', bold = true })
hi('ErrorMsg', { fg = '#e5786d', bold = true })
hi('Exception', { fg = '#8ac6f2', bold = true })
hi('Float', { fg = '#e5786d' })
hi('FloatBorder', { fg = '#303030' })
hi('FoldColumn', { fg = '#f6f3e8', bg = '#303030' })
hi('Folded', { fg = '#99968b' })
hi('Function', { fg = '#cae682' })
hi('FunctionCall', { fg = '#cae682' })
hi('Identifier', { fg = '#cae682' })
hi('Ignore', { fg = '#99968b' })
hi('Include', { fg = '#8ac6f2', bold = true })
hi('Keyword', { fg = '#8ac6f2', bold = true })
hi('Label', { fg = '#8ac6f2', bold = true })
hi('LineNr', { fg = '#99968b' })
hi('Macro', { fg = '#e5786d' })
hi('MoreMsg', { fg = '#95e454', bold = true })
hi('NonText', { fg = '#99968b' })
hi('Normal', { fg = '#f6f3e8', bg = '#242424' })
hi('NormalFloat', { fg = '#f6f3e8', bg = '#272727' })
hi('Number', { fg = '#f6f3e8' })
hi('Operator', { fg = '#f6f3e8' })
hi('Parameter', { fg = '#ddaa6f' })
hi('PmenuSbar', { fg = '#303030', bg = '#242424' })
hi('PmenuThumb', { fg = '#ffffff', bg = '#454545', underline = true })
hi('PreCondit', { fg = '#8ac6f2', bold = true })
hi('PreProc', { fg = '#e5786d' })
hi('Property', { fg = '#d1bfdf' })
hi('Repeat', { fg = '#8ac6f2', bold = true })
hi('SignColumn', { fg = '#f6f3e8', bg = '#303030' })
hi('Special', { fg = '#e5786d', bold = true })
hi('SpecialChar', { fg = '#e5786d' })
hi('SpecialComment', { fg = '#95e454', italic = true })
hi('SpecialKey', { fg = '#ddaa6f', bold = true })
hi('Statement', { fg = '#8ac6f2', bold = true })
hi('StatusLine', { fg = '#f6f3e8', bg = '#444444' })
hi('StatusLineNC', { fg = '#857b6f', bg = '#272727' })
hi('StorageClass', { fg = '#8ac6f2', bold = true })
hi('String', { fg = '#95e454' })
hi('Structure', { fg = '#8ac6f2', bold = true })
hi('TabLine', { bg = '#303030' })
hi('TabLineFill', { bg = '#303030' })
hi('TabLineSel', { bg = '#242424', bold = true })
hi('Tag', { fg = '#e5786d', italic = true })
hi('Title', { fg = '#cae682' })
hi('Todo', { fg = '#ff9900', bold = true })
hi('Type', { fg = '#92a65e', bold = true })
hi('Typedef', { fg = '#8ac6f2', bold = true })
hi('Underlined', { fg = '#8ac6f2', underline = true })
hi('VertSplit', { fg = '#303030' })
hi('Visual', { bg = '#4f4f4f' })
hi('VisualNOS', { fg = '#f6f3e8', bg = '#333366' })
hi('WarningMsg', { fg = '#ff9900', bold = true })
hi('WinSeparator', { fg = '#303030' })

-- Terminal palette from the official theme.
local term = {
   '#242424', '#e5786d', '#95e454', '#ddaa6f', '#8ac6f2', '#a6a1de', '#70cecc', '#99968b',
   '#272727', '#ff9900', '#abdd94', '#ecbd9b', '#cddaee', '#ceccf2', '#95d0e0', '#f6f3e8',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
