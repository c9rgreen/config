-- ef-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#ffffff', -- bg
      base01 = '#dbdbdb', -- bg_dim
      base02 = '#bfefff', -- selection
      base03 = '#a65f6a', -- comments
      base04 = '#68759f', -- fg_dim
      base05 = '#202020', -- fg
      base06 = '#202020', -- fg
      base07 = '#202020', -- fg
      base08 = '#e00033', -- error / red
      base09 = '#202020', -- numbers / constants
      base0A = '#008858', -- types
      base0B = '#4250ef', -- strings
      base0C = '#ba35af', -- special
      base0D = '#cf25aa', -- functions
      base0E = '#6052cf', -- keywords
      base0F = '#a65f6a', -- delimiters
   },
})
vim.g.colors_name = 'ef-light'

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
hi('Boolean', { fg = '#065fff' })
hi('Bracket', { fg = '#68759f' })
hi('Character', { fg = '#4250ef' })
hi('ColorColumn', { bg = '#b3b3b3' })
hi('Comment', { fg = '#a65f6a', italic = true })
hi('Conditional', { fg = '#6052cf', bold = true })
hi('Constant', { fg = '#065fff' })
hi('Cursor', { bg = '#0033cc' })
hi('CursorLine', { bg = '#e4efd8' })
hi('CursorLineNr', { fg = '#4250ef', bold = true })
hi('Debug', { fg = '#b6532f', bold = true })
hi('Define', { fg = '#6052cf', bold = true })
hi('Delimiter', { fg = '#a65f6a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#4250ef' })
hi('Error', { fg = '#e00033', bold = true })
hi('ErrorMsg', { fg = '#e00033', bold = true })
hi('Exception', { fg = '#6052cf', bold = true })
hi('Float', { fg = '#065fff' })
hi('FloatBorder', { fg = '#bfc4da' })
hi('FoldColumn', { fg = '#202020' })
hi('Folded', { fg = '#68759f' })
hi('Function', { fg = '#cf25aa' })
hi('FunctionCall', { fg = '#cf25aa' })
hi('Identifier', { fg = '#1f77bb' })
hi('Ignore', { fg = '#68759f' })
hi('Include', { fg = '#6052cf', bold = true })
hi('Keyword', { fg = '#6052cf', bold = true })
hi('Label', { fg = '#6052cf', bold = true })
hi('LineNr', { fg = '#68759f' })
hi('Macro', { fg = '#d3303a' })
hi('MoreMsg', { fg = '#217a3c', bold = true })
hi('NonText', { fg = '#68759f' })
hi('Normal', { fg = '#202020', bg = '#ffffff' })
hi('NormalFloat', { fg = '#202020', bg = '#b3b3b3' })
hi('Number', { fg = '#202020' })
hi('Operator', { fg = '#202020' })
hi('Parameter', { fg = '#a45f22' })
hi('PmenuSbar', { fg = '#bfc4da', bg = '#ffffff' })
hi('PmenuThumb', { fg = '#202020', bg = '#aaeccf' })
hi('PreCondit', { fg = '#6052cf', bold = true })
hi('PreProc', { fg = '#d3303a' })
hi('Property', { fg = '#008858' })
hi('Repeat', { fg = '#6052cf', bold = true })
hi('SignColumn', { fg = '#202020' })
hi('Special', { fg = '#ba35af', bold = true })
hi('SpecialChar', { fg = '#e00033' })
hi('SpecialComment', { fg = '#506fa0', italic = true })
hi('SpecialKey', { fg = '#065fff', bold = true })
hi('Statement', { fg = '#6052cf', bold = true })
hi('StatusLine', { fg = '#151515', bg = '#b7c7ff', underline = true })
hi('StatusLineNC', { fg = '#68759f', bg = '#dbdbdb', underline = true })
hi('StorageClass', { fg = '#6052cf', bold = true })
hi('String', { fg = '#4250ef' })
hi('Structure', { fg = '#6052cf', bold = true })
hi('TabLine', { bg = '#dbdbdb' })
hi('TabLineFill', { bg = '#dbdbdb' })
hi('TabLineSel', { bg = '#ffffff', bold = true })
hi('Tag', { fg = '#af5a80', italic = true })
hi('Title', { fg = '#cf25aa' })
hi('Todo', { fg = '#b6532f', bold = true })
hi('Type', { fg = '#008858', bold = true })
hi('Typedef', { fg = '#6052cf', bold = true })
hi('Underlined', { fg = '#4250ef', underline = true })
hi('VertSplit', { fg = '#bfc4da' })
hi('Visual', { bg = '#bfefff' })
hi('VisualNOS', { fg = '#202020', bg = '#ccbfff' })
hi('WarningMsg', { fg = '#b6532f', bold = true })
hi('WinSeparator', { fg = '#bfc4da' })

-- Terminal palette from the official theme.
local term = {
   '#202020', '#d3303a', '#217a3c', '#a45f22', '#3740cf', '#ba35af', '#1f6fbf', '#b3b3b3',
   '#68759f', '#e00033', '#008858', '#b6532f', '#4250ef', '#6052cf', '#1f77bb', '#ffffff',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
