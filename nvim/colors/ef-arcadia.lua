-- ef-arcadia -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#d6e4d3', -- bg
      base01 = '#c5c9c8', -- bg_dim
      base02 = '#b3c5c0', -- selection
      base03 = '#72366f', -- comments
      base04 = '#646170', -- fg_dim
      base05 = '#40314e', -- fg
      base06 = '#40314e', -- fg
      base07 = '#40314e', -- fg
      base08 = '#800e38', -- error / red
      base09 = '#40314e', -- numbers / constants
      base0A = '#005070', -- types
      base0B = '#2a5090', -- strings
      base0C = '#3f6d00', -- special
      base0D = '#922e7f', -- functions
      base0E = '#125a7f', -- keywords
      base0F = '#72366f', -- delimiters
   },
})
vim.g.colors_name = 'ef-arcadia'

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
hi('Boolean', { fg = '#503094' })
hi('Bracket', { fg = '#646170' })
hi('Character', { fg = '#2a5090' })
hi('ColorColumn', { bg = '#b0b7aa' })
hi('Comment', { fg = '#72366f', italic = true })
hi('Conditional', { fg = '#125a7f', bold = true })
hi('Constant', { fg = '#503094' })
hi('Cursor', { bg = '#495080' })
hi('CursorLine', { bg = '#d0d0c0' })
hi('CursorLineNr', { fg = '#125a7f', bold = true })
hi('Debug', { fg = '#775228', bold = true })
hi('Define', { fg = '#125a7f', bold = true })
hi('Delimiter', { fg = '#72366f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#125a7f' })
hi('Error', { fg = '#800e38', bold = true })
hi('ErrorMsg', { fg = '#800e38', bold = true })
hi('Exception', { fg = '#125a7f', bold = true })
hi('Float', { fg = '#503094' })
hi('FloatBorder', { fg = '#959a9f' })
hi('FoldColumn', { fg = '#40314e' })
hi('Folded', { fg = '#646170' })
hi('Function', { fg = '#922e7f' })
hi('FunctionCall', { fg = '#922e7f' })
hi('Identifier', { fg = '#006e50' })
hi('Ignore', { fg = '#646170' })
hi('Include', { fg = '#125a7f', bold = true })
hi('Keyword', { fg = '#125a7f', bold = true })
hi('Label', { fg = '#125a7f', bold = true })
hi('LineNr', { fg = '#646170' })
hi('Macro', { fg = '#3a40a0' })
hi('MoreMsg', { fg = '#006e50', bold = true })
hi('NonText', { fg = '#646170' })
hi('Normal', { fg = '#40314e', bg = '#d6e4d3' })
hi('NormalFloat', { fg = '#40314e', bg = '#b0b7aa' })
hi('Number', { fg = '#40314e' })
hi('Operator', { fg = '#40314e' })
hi('Parameter', { fg = '#6b4500' })
hi('PmenuSbar', { fg = '#959a9f', bg = '#d6e4d3' })
hi('PmenuThumb', { fg = '#40314e', bg = '#afbad0' })
hi('PreCondit', { fg = '#125a7f', bold = true })
hi('PreProc', { fg = '#3a40a0' })
hi('Property', { fg = '#113384' })
hi('Repeat', { fg = '#125a7f', bold = true })
hi('SignColumn', { fg = '#40314e' })
hi('Special', { fg = '#3f6d00', bold = true })
hi('SpecialChar', { fg = '#800e38' })
hi('SpecialComment', { fg = '#304650', italic = true })
hi('SpecialKey', { fg = '#125a7f', bold = true })
hi('Statement', { fg = '#125a7f', bold = true })
hi('StatusLine', { fg = '#155239', bg = '#75b194', underline = true })
hi('StatusLineNC', { fg = '#646170', bg = '#c5c9c8', underline = true })
hi('StorageClass', { fg = '#125a7f', bold = true })
hi('String', { fg = '#2a5090' })
hi('Structure', { fg = '#125a7f', bold = true })
hi('TabLine', { bg = '#c5c9c8' })
hi('TabLineFill', { bg = '#c5c9c8' })
hi('TabLineSel', { bg = '#d6e4d3', bold = true })
hi('Tag', { fg = '#72366f', italic = true })
hi('Title', { fg = '#922e7f' })
hi('Todo', { fg = '#775228', bold = true })
hi('Type', { fg = '#005070', bold = true })
hi('Typedef', { fg = '#125a7f', bold = true })
hi('Underlined', { fg = '#503094', underline = true })
hi('VertSplit', { fg = '#959a9f' })
hi('Visual', { bg = '#b3c5c0' })
hi('VisualNOS', { fg = '#40314e', bg = '#a5d2af' })
hi('WarningMsg', { fg = '#775228', bold = true })
hi('WinSeparator', { fg = '#959a9f' })

-- Terminal palette from the official theme.
local term = {
   '#40314e', '#882000', '#206020', '#6b4500', '#113384', '#922e7f', '#125a7f', '#b0b7aa',
   '#646170', '#9a1500', '#006e50', '#743f00', '#3a40a0', '#503094', '#005070', '#d6e4d3',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
