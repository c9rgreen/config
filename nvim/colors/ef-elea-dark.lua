-- ef-elea-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#222524', -- bg
      base01 = '#3e4140', -- bg_dim
      base02 = '#543040', -- selection
      base03 = '#cac89f', -- comments
      base04 = '#969faf', -- fg_dim
      base05 = '#eaf2ef', -- fg
      base06 = '#eaf2ef', -- fg
      base07 = '#eaf2ef', -- fg
      base08 = '#ff7a5f', -- error / red
      base09 = '#eaf2ef', -- numbers / constants
      base0A = '#6fcfd2', -- types
      base0B = '#50cf89', -- strings
      base0C = '#d0b9f0', -- special
      base0D = '#7fca5a', -- functions
      base0E = '#eba8a8', -- keywords
      base0F = '#cac89f', -- delimiters
   },
})
vim.g.colors_name = 'ef-elea-dark'

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
hi('Boolean', { fg = '#cfaaff' })
hi('Bracket', { fg = '#969faf' })
hi('Character', { fg = '#50cf89' })
hi('ColorColumn', { bg = '#5e6160' })
hi('Comment', { fg = '#cac89f', italic = true })
hi('Conditional', { fg = '#eba8a8', bold = true })
hi('Constant', { fg = '#cfaaff' })
hi('Cursor', { bg = '#ef7fa8' })
hi('CursorLine', { bg = '#2f413f' })
hi('CursorLineNr', { fg = '#50cf89', bold = true })
hi('Debug', { fg = '#e0b02f', bold = true })
hi('Define', { fg = '#eba8a8', bold = true })
hi('Delimiter', { fg = '#cac89f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#50cf89' })
hi('Error', { fg = '#ff7a5f', bold = true })
hi('ErrorMsg', { fg = '#ff7a5f', bold = true })
hi('Exception', { fg = '#eba8a8', bold = true })
hi('Float', { fg = '#cfaaff' })
hi('FloatBorder', { fg = '#5d5f63' })
hi('FoldColumn', { fg = '#eaf2ef' })
hi('Folded', { fg = '#969faf' })
hi('Function', { fg = '#7fca5a' })
hi('FunctionCall', { fg = '#7fca5a' })
hi('Identifier', { fg = '#f59acf' })
hi('Ignore', { fg = '#969faf' })
hi('Include', { fg = '#eba8a8', bold = true })
hi('Keyword', { fg = '#eba8a8', bold = true })
hi('Label', { fg = '#eba8a8', bold = true })
hi('LineNr', { fg = '#969faf' })
hi('Macro', { fg = '#fa90ea' })
hi('MoreMsg', { fg = '#50cf89', bold = true })
hi('NonText', { fg = '#969faf' })
hi('Normal', { fg = '#eaf2ef', bg = '#222524' })
hi('NormalFloat', { fg = '#eaf2ef', bg = '#5e6160' })
hi('Number', { fg = '#eaf2ef' })
hi('Operator', { fg = '#eaf2ef' })
hi('Parameter', { fg = '#cac85f' })
hi('PmenuSbar', { fg = '#5d5f63', bg = '#222524' })
hi('PmenuThumb', { fg = '#eaf2ef', bg = '#894f7a' })
hi('PreCondit', { fg = '#eba8a8', bold = true })
hi('PreProc', { fg = '#fa90ea' })
hi('Property', { fg = '#cfaaff' })
hi('Repeat', { fg = '#eba8a8', bold = true })
hi('SignColumn', { fg = '#eaf2ef' })
hi('Special', { fg = '#d0b9f0', bold = true })
hi('SpecialChar', { fg = '#ff7a5f' })
hi('SpecialComment', { fg = '#99bfcf', italic = true })
hi('SpecialKey', { fg = '#f59acf', bold = true })
hi('Statement', { fg = '#eba8a8', bold = true })
hi('StatusLine', { fg = '#ecf0ff', bg = '#35605d', underline = true })
hi('StatusLineNC', { fg = '#969faf', bg = '#3e4140', underline = true })
hi('StorageClass', { fg = '#eba8a8', bold = true })
hi('String', { fg = '#50cf89' })
hi('Structure', { fg = '#eba8a8', bold = true })
hi('TabLine', { bg = '#3e4140' })
hi('TabLineFill', { bg = '#3e4140' })
hi('TabLineSel', { bg = '#222524', bold = true })
hi('Tag', { fg = '#d0b9f0', italic = true })
hi('Title', { fg = '#7fca5a' })
hi('Todo', { fg = '#e0b02f', bold = true })
hi('Type', { fg = '#6fcfd2', bold = true })
hi('Typedef', { fg = '#eba8a8', bold = true })
hi('Underlined', { fg = '#7fca5a', underline = true })
hi('VertSplit', { fg = '#5d5f63' })
hi('Visual', { bg = '#543040' })
hi('VisualNOS', { fg = '#eaf2ef', bg = '#425d4a' })
hi('WarningMsg', { fg = '#e0b02f', bold = true })
hi('WinSeparator', { fg = '#5d5f63' })

-- Terminal palette from the official theme.
local term = {
   '#222524', '#ff656a', '#7fc87f', '#cac85f', '#57aff6', '#f59acf', '#6fcfd2', '#969faf',
   '#5e6160', '#ff7a5f', '#50cf89', '#e0b02f', '#78afff', '#cfaaff', '#60d5c2', '#eaf2ef',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
