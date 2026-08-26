-- ef-deuteranopia-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#f5f5ff', -- bg
      base01 = '#d3d3e0', -- bg_dim
      base02 = '#dadadf', -- selection
      base03 = '#77604a', -- comments
      base04 = '#70627f', -- fg_dim
      base05 = '#1a1a2f', -- fg
      base06 = '#1a1a2f', -- fg
      base07 = '#1a1a2f', -- fg
      base08 = '#965000', -- error / red
      base09 = '#1a1a2f', -- numbers / constants
      base0A = '#805d00', -- types
      base0B = '#965000', -- strings
      base0C = '#1f6fbf', -- special
      base0D = '#065fff', -- functions
      base0E = '#4250ef', -- keywords
      base0F = '#77604a', -- delimiters
   },
})
vim.g.colors_name = 'ef-deuteranopia-light'

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
hi('Boolean', { fg = '#765040' })
hi('Bracket', { fg = '#70627f' })
hi('Character', { fg = '#965000' })
hi('ColorColumn', { bg = '#b3b3c0' })
hi('Comment', { fg = '#77604a', italic = true })
hi('Conditional', { fg = '#4250ef', bold = true })
hi('Constant', { fg = '#765040' })
hi('Cursor', { bg = '#0000bb' })
hi('CursorLine', { bg = '#f3e0d5' })
hi('CursorLineNr', { fg = '#065fff', bold = true })
hi('Debug', { fg = '#765040', bold = true })
hi('Define', { fg = '#4250ef', bold = true })
hi('Delimiter', { fg = '#77604a' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#065fff' })
hi('Error', { fg = '#965000', bold = true })
hi('ErrorMsg', { fg = '#965000', bold = true })
hi('Exception', { fg = '#4250ef', bold = true })
hi('Float', { fg = '#765040' })
hi('FloatBorder', { fg = '#bcbcd0' })
hi('FoldColumn', { fg = '#1a1a2f' })
hi('Folded', { fg = '#70627f' })
hi('Function', { fg = '#065fff' })
hi('FunctionCall', { fg = '#065fff' })
hi('Identifier', { fg = '#1477b2' })
hi('Ignore', { fg = '#70627f' })
hi('Include', { fg = '#4250ef', bold = true })
hi('Keyword', { fg = '#4250ef', bold = true })
hi('Label', { fg = '#4250ef', bold = true })
hi('LineNr', { fg = '#70627f' })
hi('Macro', { fg = '#6052cf' })
hi('MoreMsg', { fg = '#065fff', bold = true })
hi('NonText', { fg = '#70627f' })
hi('Normal', { fg = '#1a1a2f', bg = '#f5f5ff' })
hi('NormalFloat', { fg = '#1a1a2f', bg = '#b3b3c0' })
hi('Number', { fg = '#1a1a2f' })
hi('Operator', { fg = '#1a1a2f' })
hi('Parameter', { fg = '#805d00' })
hi('PmenuSbar', { fg = '#bcbcd0', bg = '#f5f5ff' })
hi('PmenuThumb', { fg = '#1a1a2f', bg = '#eebb20' })
hi('PreCondit', { fg = '#4250ef', bold = true })
hi('PreProc', { fg = '#6052cf' })
hi('Property', { fg = '#1f6fbf' })
hi('Repeat', { fg = '#4250ef', bold = true })
hi('SignColumn', { fg = '#1a1a2f' })
hi('Special', { fg = '#1f6fbf', bold = true })
hi('SpecialChar', { fg = '#965000' })
hi('SpecialComment', { fg = '#506fa0', italic = true })
hi('SpecialKey', { fg = '#965000', bold = true })
hi('Statement', { fg = '#4250ef', bold = true })
hi('StatusLine', { fg = '#0a0a1f', bg = '#99c7ff', underline = true })
hi('StatusLineNC', { fg = '#70627f', bg = '#d3d3e0', underline = true })
hi('StorageClass', { fg = '#4250ef', bold = true })
hi('String', { fg = '#965000' })
hi('Structure', { fg = '#4250ef', bold = true })
hi('TabLine', { bg = '#d3d3e0' })
hi('TabLineFill', { bg = '#d3d3e0' })
hi('TabLineSel', { bg = '#f5f5ff', bold = true })
hi('Tag', { fg = '#9f5080', italic = true })
hi('Title', { fg = '#065fff' })
hi('Todo', { fg = '#765040', bold = true })
hi('Type', { fg = '#805d00', bold = true })
hi('Typedef', { fg = '#4250ef', bold = true })
hi('Underlined', { fg = '#375cd8', underline = true })
hi('VertSplit', { fg = '#bcbcd0' })
hi('Visual', { bg = '#dadadf' })
hi('VisualNOS', { fg = '#1a1a2f', bg = '#afafef' })
hi('WarningMsg', { fg = '#765040', bold = true })
hi('WinSeparator', { fg = '#bcbcd0' })

-- Terminal palette from the official theme.
local term = {
   '#1a1a2f', '#d3303a', '#217a3c', '#805d00', '#375cd8', '#ba35af', '#1f6fbf', '#b3b3c0',
   '#70627f', '#e00033', '#008058', '#965000', '#4250ef', '#6052cf', '#1477b2', '#f5f5ff',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
