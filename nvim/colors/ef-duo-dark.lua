-- ef-duo-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#070019', -- bg
      base01 = '#2a2739', -- bg_dim
      base02 = '#042a50', -- selection
      base03 = '#d08f72', -- comments
      base04 = '#857f8f', -- fg_dim
      base05 = '#d0d0d0', -- fg
      base06 = '#d0d0d0', -- fg
      base07 = '#d0d0d0', -- fg
      base08 = '#ef656a', -- error / red
      base09 = '#d0d0d0', -- numbers / constants
      base0A = '#029fff', -- types
      base0B = '#df805f', -- strings
      base0C = '#5faaef', -- special
      base0D = '#0dafdf', -- functions
      base0E = '#6f80ff', -- keywords
      base0F = '#d08f72', -- delimiters
   },
})
vim.g.colors_name = 'ef-duo-dark'

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
hi('Boolean', { fg = '#379cf6' })
hi('Bracket', { fg = '#857f8f' })
hi('Character', { fg = '#df805f' })
hi('ColorColumn', { bg = '#4a4759' })
hi('Comment', { fg = '#d08f72', italic = true })
hi('Conditional', { fg = '#6f80ff', bold = true })
hi('Constant', { fg = '#379cf6' })
hi('Cursor', { bg = '#ef6f11' })
hi('CursorLine', { bg = '#301a4f' })
hi('CursorLineNr', { fg = '#6f80ff', bold = true })
hi('Debug', { fg = '#c48702', bold = true })
hi('Define', { fg = '#6f80ff', bold = true })
hi('Delimiter', { fg = '#d08f72' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#6f80ff' })
hi('Error', { fg = '#ef656a', bold = true })
hi('ErrorMsg', { fg = '#ef656a', bold = true })
hi('Exception', { fg = '#6f80ff', bold = true })
hi('Float', { fg = '#379cf6' })
hi('FloatBorder', { fg = '#545f6f' })
hi('FoldColumn', { fg = '#d0d0d0' })
hi('Folded', { fg = '#857f8f' })
hi('Function', { fg = '#0dafdf' })
hi('FunctionCall', { fg = '#0dafdf' })
hi('Identifier', { fg = '#af85ff' })
hi('Ignore', { fg = '#857f8f' })
hi('Include', { fg = '#6f80ff', bold = true })
hi('Keyword', { fg = '#6f80ff', bold = true })
hi('Label', { fg = '#6f80ff', bold = true })
hi('LineNr', { fg = '#857f8f' })
hi('Macro', { fg = '#7fafff' })
hi('MoreMsg', { fg = '#1fa526', bold = true })
hi('NonText', { fg = '#857f8f' })
hi('Normal', { fg = '#d0d0d0', bg = '#070019' })
hi('NormalFloat', { fg = '#d0d0d0', bg = '#4a4759' })
hi('Number', { fg = '#d0d0d0' })
hi('Operator', { fg = '#d0d0d0' })
hi('Parameter', { fg = '#c48702' })
hi('PmenuSbar', { fg = '#545f6f', bg = '#070019' })
hi('PmenuThumb', { fg = '#d0d0d0', bg = '#664f4a' })
hi('PreCondit', { fg = '#6f80ff', bold = true })
hi('PreProc', { fg = '#7fafff' })
hi('Property', { fg = '#00b982' })
hi('Repeat', { fg = '#6f80ff', bold = true })
hi('SignColumn', { fg = '#d0d0d0' })
hi('Special', { fg = '#5faaef', bold = true })
hi('SpecialChar', { fg = '#ef656a' })
hi('SpecialComment', { fg = '#8a9fdf', italic = true })
hi('SpecialKey', { fg = '#029fff', bold = true })
hi('Statement', { fg = '#6f80ff', bold = true })
hi('StatusLine', { fg = '#dedeff', bg = '#352487', underline = true })
hi('StatusLineNC', { fg = '#857f8f', bg = '#2a2739', underline = true })
hi('StorageClass', { fg = '#6f80ff', bold = true })
hi('String', { fg = '#df805f' })
hi('Structure', { fg = '#6f80ff', bold = true })
hi('TabLine', { bg = '#2a2739' })
hi('TabLineFill', { bg = '#2a2739' })
hi('TabLineSel', { bg = '#070019', bold = true })
hi('Tag', { fg = '#c57faf', italic = true })
hi('Title', { fg = '#0dafdf' })
hi('Todo', { fg = '#c48702', bold = true })
hi('Type', { fg = '#029fff', bold = true })
hi('Typedef', { fg = '#6f80ff', bold = true })
hi('Underlined', { fg = '#7fafff', underline = true })
hi('VertSplit', { fg = '#545f6f' })
hi('Visual', { bg = '#042a50' })
hi('VisualNOS', { fg = '#d0d0d0', bg = '#264f4a' })
hi('WarningMsg', { fg = '#c48702', bold = true })
hi('WinSeparator', { fg = '#545f6f' })

-- Terminal palette from the official theme.
local term = {
   '#070019', '#ef656a', '#1fa526', '#c48702', '#379cf6', '#d369af', '#5faaef', '#857f8f',
   '#4a4759', '#f47360', '#00b982', '#d0730f', '#6f80ff', '#af85ff', '#0dafdf', '#d0d0d0',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
