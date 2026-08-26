-- ef-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#000000', -- bg
      base01 = '#2b2b2b', -- bg_dim
      base02 = '#2a234a', -- selection
      base03 = '#cf9f8f', -- comments
      base04 = '#857f8f', -- fg_dim
      base05 = '#d0d0d0', -- fg
      base06 = '#d0d0d0', -- fg
      base07 = '#d0d0d0', -- fg
      base08 = '#f47360', -- error / red
      base09 = '#d0d0d0', -- numbers / constants
      base0A = '#00a692', -- types
      base0B = '#6a9fff', -- strings
      base0C = '#d369af', -- special
      base0D = '#e580ea', -- functions
      base0E = '#af85ff', -- keywords
      base0F = '#cf9f8f', -- delimiters
   },
})
vim.g.colors_name = 'ef-dark'

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
hi('Boolean', { fg = '#029fff' })
hi('Bracket', { fg = '#857f8f' })
hi('Character', { fg = '#6a9fff' })
hi('ColorColumn', { bg = '#4b4b4b' })
hi('Comment', { fg = '#cf9f8f', italic = true })
hi('Conditional', { fg = '#af85ff', bold = true })
hi('Constant', { fg = '#029fff' })
hi('Cursor', { bg = '#ff76ff' })
hi('CursorLine', { bg = '#002435' })
hi('CursorLineNr', { fg = '#3f95f6', bold = true })
hi('Debug', { fg = '#bf9032', bold = true })
hi('Define', { fg = '#af85ff', bold = true })
hi('Delimiter', { fg = '#cf9f8f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#3f95f6' })
hi('Error', { fg = '#f47360', bold = true })
hi('ErrorMsg', { fg = '#f47360', bold = true })
hi('Exception', { fg = '#af85ff', bold = true })
hi('Float', { fg = '#029fff' })
hi('FloatBorder', { fg = '#4f4f5f' })
hi('FoldColumn', { fg = '#d0d0d0' })
hi('Folded', { fg = '#857f8f' })
hi('Function', { fg = '#e580ea' })
hi('FunctionCall', { fg = '#e580ea' })
hi('Identifier', { fg = '#1dbfcf' })
hi('Ignore', { fg = '#857f8f' })
hi('Include', { fg = '#af85ff', bold = true })
hi('Keyword', { fg = '#af85ff', bold = true })
hi('Label', { fg = '#af85ff', bold = true })
hi('LineNr', { fg = '#857f8f' })
hi('Macro', { fg = '#ef6560' })
hi('MoreMsg', { fg = '#0faa26', bold = true })
hi('NonText', { fg = '#857f8f' })
hi('Normal', { fg = '#d0d0d0', bg = '#000000' })
hi('NormalFloat', { fg = '#d0d0d0', bg = '#4b4b4b' })
hi('Number', { fg = '#d0d0d0' })
hi('Operator', { fg = '#d0d0d0' })
hi('Parameter', { fg = '#bf9032' })
hi('PmenuSbar', { fg = '#4f4f5f', bg = '#000000' })
hi('PmenuThumb', { fg = '#d0d0d0', bg = '#004a5f' })
hi('PreCondit', { fg = '#af85ff', bold = true })
hi('PreProc', { fg = '#ef6560' })
hi('Property', { fg = '#00a692' })
hi('Repeat', { fg = '#af85ff', bold = true })
hi('SignColumn', { fg = '#d0d0d0' })
hi('Special', { fg = '#d369af', bold = true })
hi('SpecialChar', { fg = '#f47360' })
hi('SpecialComment', { fg = '#8aa0df', italic = true })
hi('SpecialKey', { fg = '#029fff', bold = true })
hi('Statement', { fg = '#af85ff', bold = true })
hi('StatusLine', { fg = '#e0e0ff', bg = '#2a2a75', underline = true })
hi('StatusLineNC', { fg = '#857f8f', bg = '#2b2b2b', underline = true })
hi('StorageClass', { fg = '#af85ff', bold = true })
hi('String', { fg = '#6a9fff' })
hi('Structure', { fg = '#af85ff', bold = true })
hi('TabLine', { bg = '#2b2b2b' })
hi('TabLineFill', { bg = '#2b2b2b' })
hi('TabLineSel', { bg = '#000000', bold = true })
hi('Tag', { fg = '#c58faf', italic = true })
hi('Title', { fg = '#e580ea' })
hi('Todo', { fg = '#bf9032', bold = true })
hi('Type', { fg = '#00a692', bold = true })
hi('Typedef', { fg = '#af85ff', bold = true })
hi('Underlined', { fg = '#4fbaef', underline = true })
hi('VertSplit', { fg = '#4f4f5f' })
hi('Visual', { bg = '#2a234a' })
hi('VisualNOS', { fg = '#d0d0d0', bg = '#551f5a' })
hi('WarningMsg', { fg = '#bf9032', bold = true })
hi('WinSeparator', { fg = '#4f4f5f' })

-- Terminal palette from the official theme.
local term = {
   '#000000', '#ef6560', '#0faa26', '#bf9032', '#3f95f6', '#d369af', '#4fbaef', '#857f8f',
   '#4b4b4b', '#f47360', '#00a692', '#d1843f', '#6a9fff', '#af85ff', '#1dbfcf', '#d0d0d0',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
