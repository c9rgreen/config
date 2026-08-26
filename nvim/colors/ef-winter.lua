-- ef-winter -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#0f0b15', -- bg
      base01 = '#2a2f42', -- bg_dim
      base02 = '#342464', -- selection
      base03 = '#c0a38a', -- comments
      base04 = '#807c9f', -- fg_dim
      base05 = '#b8c6d5', -- fg
      base06 = '#b8c6d5', -- fg
      base07 = '#b8c6d5', -- fg
      base08 = '#ef6560', -- error / red
      base09 = '#b8c6d5', -- numbers / constants
      base0A = '#4fbaef', -- types
      base0B = '#df9080', -- strings
      base0C = '#e580e0', -- special
      base0D = '#35afbf', -- functions
      base0E = '#af85ea', -- keywords
      base0F = '#c0a38a', -- delimiters
   },
})
vim.g.colors_name = 'ef-winter'

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
hi('Boolean', { fg = '#d369af' })
hi('Bracket', { fg = '#807c9f' })
hi('Character', { fg = '#df9080' })
hi('ColorColumn', { bg = '#4a4f62' })
hi('Comment', { fg = '#c0a38a', italic = true })
hi('Conditional', { fg = '#af85ea', bold = true })
hi('Constant', { fg = '#d369af' })
hi('Cursor', { bg = '#ff6ff0' })
hi('CursorLine', { bg = '#003045' })
hi('CursorLineNr', { fg = '#af85ea', bold = true })
hi('Debug', { fg = '#b58a52', bold = true })
hi('Define', { fg = '#af85ea', bold = true })
hi('Delimiter', { fg = '#c0a38a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#af85ea' })
hi('Error', { fg = '#ef6560', bold = true })
hi('ErrorMsg', { fg = '#ef6560', bold = true })
hi('Exception', { fg = '#af85ea', bold = true })
hi('Float', { fg = '#d369af' })
hi('FloatBorder', { fg = '#4a4955' })
hi('FoldColumn', { fg = '#b8c6d5' })
hi('Folded', { fg = '#807c9f' })
hi('Function', { fg = '#35afbf' })
hi('FunctionCall', { fg = '#35afbf' })
hi('Identifier', { fg = '#6a9fff' })
hi('Ignore', { fg = '#807c9f' })
hi('Include', { fg = '#af85ea', bold = true })
hi('Keyword', { fg = '#af85ea', bold = true })
hi('Label', { fg = '#af85ea', bold = true })
hi('LineNr', { fg = '#807c9f' })
hi('Macro', { fg = '#ff6a7a' })
hi('MoreMsg', { fg = '#29a444', bold = true })
hi('NonText', { fg = '#807c9f' })
hi('Normal', { fg = '#b8c6d5', bg = '#0f0b15' })
hi('NormalFloat', { fg = '#b8c6d5', bg = '#4a4f62' })
hi('Number', { fg = '#b8c6d5' })
hi('Operator', { fg = '#b8c6d5' })
hi('Parameter', { fg = '#b58a52' })
hi('PmenuSbar', { fg = '#4a4955', bg = '#0f0b15' })
hi('PmenuThumb', { fg = '#b8c6d5', bg = '#00474f' })
hi('PreCondit', { fg = '#af85ea', bold = true })
hi('PreProc', { fg = '#ff6a7a' })
hi('Property', { fg = '#00a392' })
hi('Repeat', { fg = '#af85ea', bold = true })
hi('SignColumn', { fg = '#b8c6d5' })
hi('Special', { fg = '#e580e0', bold = true })
hi('SpecialChar', { fg = '#ef6560' })
hi('SpecialComment', { fg = '#8aa0df', italic = true })
hi('SpecialKey', { fg = '#35afbf', bold = true })
hi('Statement', { fg = '#af85ea', bold = true })
hi('StatusLine', { fg = '#dedeff', bg = '#5f1f5f', underline = true })
hi('StatusLineNC', { fg = '#807c9f', bg = '#2a2f42', underline = true })
hi('StorageClass', { fg = '#af85ea', bold = true })
hi('String', { fg = '#df9080' })
hi('Structure', { fg = '#af85ea', bold = true })
hi('TabLine', { bg = '#2a2f42' })
hi('TabLineFill', { bg = '#2a2f42' })
hi('TabLineSel', { bg = '#0f0b15', bold = true })
hi('Tag', { fg = '#c57faf', italic = true })
hi('Title', { fg = '#35afbf' })
hi('Todo', { fg = '#b58a52', bold = true })
hi('Type', { fg = '#4fbaef', bold = true })
hi('Typedef', { fg = '#af85ea', bold = true })
hi('Underlined', { fg = '#d369af', underline = true })
hi('VertSplit', { fg = '#4a4955' })
hi('Visual', { bg = '#342464' })
hi('VisualNOS', { fg = '#b8c6d5', bg = '#44196f' })
hi('WarningMsg', { fg = '#b58a52', bold = true })
hi('WinSeparator', { fg = '#4a4955' })

-- Terminal palette from the official theme.
local term = {
   '#0f0b15', '#f47359', '#29a444', '#b58a52', '#3f95f6', '#d369af', '#4fbaef', '#807c9f',
   '#4a4f62', '#ef6560', '#00a392', '#d1803f', '#6a9fff', '#af85ea', '#35afbf', '#b8c6d5',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
