-- ef-day -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fff5ea', -- bg
      base01 = '#e9e0d8', -- bg_dim
      base02 = '#f0d2df', -- selection
      base03 = '#527545', -- comments
      base04 = '#63728f', -- fg_dim
      base05 = '#584141', -- fg
      base06 = '#584141', -- fg
      base07 = '#584141', -- fg
      base08 = '#ce3f00', -- error / red
      base09 = '#584141', -- numbers / constants
      base0A = '#0f7f5f', -- types
      base0B = '#5f7200', -- strings
      base0C = '#cf2f4f', -- special
      base0D = '#ca3e54', -- functions
      base0E = '#a45a22', -- keywords
      base0F = '#527545', -- delimiters
   },
})
vim.g.colors_name = 'ef-day'

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
hi('Boolean', { fg = '#ce3f00' })
hi('Bracket', { fg = '#63728f' })
hi('Character', { fg = '#5f7200' })
hi('ColorColumn', { bg = '#c9c0b8' })
hi('Comment', { fg = '#527545', italic = true })
hi('Conditional', { fg = '#a45a22', bold = true })
hi('Constant', { fg = '#ce3f00' })
hi('Cursor', { bg = '#cf1f00' })
hi('CursorLine', { bg = '#f9e2b2' })
hi('CursorLineNr', { fg = '#ba2d2f', bold = true })
hi('Debug', { fg = '#a45a22', bold = true })
hi('Define', { fg = '#a45a22', bold = true })
hi('Delimiter', { fg = '#527545' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#ba2d2f' })
hi('Error', { fg = '#ce3f00', bold = true })
hi('ErrorMsg', { fg = '#ce3f00', bold = true })
hi('Exception', { fg = '#a45a22', bold = true })
hi('Float', { fg = '#ce3f00' })
hi('FloatBorder', { fg = '#c8bdb6' })
hi('FoldColumn', { fg = '#584141' })
hi('Folded', { fg = '#63728f' })
hi('Function', { fg = '#ca3e54' })
hi('FunctionCall', { fg = '#ca3e54' })
hi('Identifier', { fg = '#8448aa' })
hi('Ignore', { fg = '#63728f' })
hi('Include', { fg = '#a45a22', bold = true })
hi('Keyword', { fg = '#a45a22', bold = true })
hi('Label', { fg = '#a45a22', bold = true })
hi('LineNr', { fg = '#63728f' })
hi('Macro', { fg = '#3f6faf' })
hi('MoreMsg', { fg = '#007a0a', bold = true })
hi('NonText', { fg = '#63728f' })
hi('Normal', { fg = '#584141', bg = '#fff5ea' })
hi('NormalFloat', { fg = '#584141', bg = '#c9c0b8' })
hi('Number', { fg = '#584141' })
hi('Operator', { fg = '#584141' })
hi('Parameter', { fg = '#a45a22' })
hi('PmenuSbar', { fg = '#c8bdb6', bg = '#fff5ea' })
hi('PmenuThumb', { fg = '#584141', bg = '#b0e0df' })
hi('PreCondit', { fg = '#a45a22', bold = true })
hi('PreProc', { fg = '#3f6faf' })
hi('Property', { fg = '#a45a22' })
hi('Repeat', { fg = '#a45a22', bold = true })
hi('SignColumn', { fg = '#584141' })
hi('Special', { fg = '#cf2f4f', bold = true })
hi('SpecialChar', { fg = '#ce3f00' })
hi('SpecialComment', { fg = '#9a625a', italic = true })
hi('SpecialKey', { fg = '#ce3f00', bold = true })
hi('Statement', { fg = '#a45a22', bold = true })
hi('StatusLine', { fg = '#542f38', bg = '#ffaf72', underline = true })
hi('StatusLineNC', { fg = '#63728f', bg = '#e9e0d8', underline = true })
hi('StorageClass', { fg = '#a45a22', bold = true })
hi('String', { fg = '#5f7200' })
hi('Structure', { fg = '#a45a22', bold = true })
hi('TabLine', { bg = '#e9e0d8' })
hi('TabLineFill', { bg = '#e9e0d8' })
hi('TabLineSel', { bg = '#fff5ea', bold = true })
hi('Tag', { fg = '#a04450', italic = true })
hi('Title', { fg = '#ca3e54' })
hi('Todo', { fg = '#a45a22', bold = true })
hi('Type', { fg = '#0f7f5f', bold = true })
hi('Typedef', { fg = '#a45a22', bold = true })
hi('Underlined', { fg = '#3f6faf', underline = true })
hi('VertSplit', { fg = '#c8bdb6' })
hi('Visual', { bg = '#f0d2df' })
hi('VisualNOS', { fg = '#584141', bg = '#febccf' })
hi('WarningMsg', { fg = '#a45a22', bold = true })
hi('WinSeparator', { fg = '#c8bdb6' })

-- Terminal palette from the official theme.
local term = {
   '#584141', '#ba2d2f', '#007a0a', '#a45a22', '#375cc6', '#ca3e54', '#3f60af', '#c9c0b8',
   '#63728f', '#ce3f00', '#0f7f5f', '#b75515', '#5f5fdf', '#8448aa', '#0f7b8f', '#fff5ea',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
