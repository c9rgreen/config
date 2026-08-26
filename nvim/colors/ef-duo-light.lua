-- ef-duo-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fff8f0', -- bg
      base01 = '#e7e0da', -- bg_dim
      base02 = '#caeafa', -- selection
      base03 = '#a2403f', -- comments
      base04 = '#63728f', -- fg_dim
      base05 = '#222222', -- fg
      base06 = '#222222', -- fg
      base07 = '#222222', -- fg
      base08 = '#cc3333', -- error / red
      base09 = '#222222', -- numbers / constants
      base0A = '#065fff', -- types
      base0B = '#9f4a00', -- strings
      base0C = '#1f77bb', -- special
      base0D = '#1f6fbf', -- functions
      base0E = '#4250ef', -- keywords
      base0F = '#a2403f', -- delimiters
   },
})
vim.g.colors_name = 'ef-duo-light'

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
hi('Boolean', { fg = '#375cd8' })
hi('Bracket', { fg = '#63728f' })
hi('Character', { fg = '#9f4a00' })
hi('ColorColumn', { bg = '#c7c0ba' })
hi('Comment', { fg = '#a2403f', italic = true })
hi('Conditional', { fg = '#4250ef', bold = true })
hi('Constant', { fg = '#375cd8' })
hi('Cursor', { bg = '#1144ff' })
hi('CursorLine', { bg = '#f9e8c0' })
hi('CursorLineNr', { fg = '#4250ef', bold = true })
hi('Debug', { fg = '#8a5d00', bold = true })
hi('Define', { fg = '#4250ef', bold = true })
hi('Delimiter', { fg = '#a2403f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#4250ef' })
hi('Error', { fg = '#cc3333', bold = true })
hi('ErrorMsg', { fg = '#cc3333', bold = true })
hi('Exception', { fg = '#4250ef', bold = true })
hi('Float', { fg = '#375cd8' })
hi('FloatBorder', { fg = '#baafba' })
hi('FoldColumn', { fg = '#222222' })
hi('Folded', { fg = '#63728f' })
hi('Function', { fg = '#1f6fbf' })
hi('FunctionCall', { fg = '#1f6fbf' })
hi('Identifier', { fg = '#6052cf' })
hi('Ignore', { fg = '#63728f' })
hi('Include', { fg = '#4250ef', bold = true })
hi('Keyword', { fg = '#4250ef', bold = true })
hi('Label', { fg = '#4250ef', bold = true })
hi('LineNr', { fg = '#63728f' })
hi('Macro', { fg = '#3f70a0' })
hi('MoreMsg', { fg = '#217a3c', bold = true })
hi('NonText', { fg = '#63728f' })
hi('Normal', { fg = '#222222', bg = '#fff8f0' })
hi('NormalFloat', { fg = '#222222', bg = '#c7c0ba' })
hi('Number', { fg = '#222222' })
hi('Operator', { fg = '#222222' })
hi('Parameter', { fg = '#8a5d00' })
hi('PmenuSbar', { fg = '#baafba', bg = '#fff8f0' })
hi('PmenuThumb', { fg = '#222222', bg = '#b4cfff' })
hi('PreCondit', { fg = '#4250ef', bold = true })
hi('PreProc', { fg = '#3f70a0' })
hi('Property', { fg = '#008058' })
hi('Repeat', { fg = '#4250ef', bold = true })
hi('SignColumn', { fg = '#222222' })
hi('Special', { fg = '#1f77bb', bold = true })
hi('SpecialChar', { fg = '#cc3333' })
hi('SpecialComment', { fg = '#406f90', italic = true })
hi('SpecialKey', { fg = '#065fff', bold = true })
hi('Statement', { fg = '#4250ef', bold = true })
hi('StatusLine', { fg = '#111133', bg = '#f8cf8f', underline = true })
hi('StatusLineNC', { fg = '#63728f', bg = '#e7e0da', underline = true })
hi('StorageClass', { fg = '#4250ef', bold = true })
hi('String', { fg = '#9f4a00' })
hi('Structure', { fg = '#4250ef', bold = true })
hi('TabLine', { bg = '#e7e0da' })
hi('TabLineFill', { bg = '#e7e0da' })
hi('TabLineSel', { bg = '#fff8f0', bold = true })
hi('Tag', { fg = '#af569f', italic = true })
hi('Title', { fg = '#1f6fbf' })
hi('Todo', { fg = '#8a5d00', bold = true })
hi('Type', { fg = '#065fff', bold = true })
hi('Typedef', { fg = '#4250ef', bold = true })
hi('Underlined', { fg = '#1f6fbf', underline = true })
hi('VertSplit', { fg = '#baafba' })
hi('Visual', { bg = '#caeafa' })
hi('VisualNOS', { fg = '#222222', bg = '#aaeccf' })
hi('WarningMsg', { fg = '#8a5d00', bold = true })
hi('WinSeparator', { fg = '#baafba' })

-- Terminal palette from the official theme.
local term = {
   '#222222', '#cc3333', '#217a3c', '#8a5d00', '#375cd8', '#ba35af', '#1f6fbf', '#c7c0ba',
   '#63728f', '#dd1100', '#008058', '#9f4a00', '#4250ef', '#6052cf', '#1f77bb', '#fff8f0',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
