-- ef-maris-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#131c2b', -- bg
      base01 = '#2a3644', -- bg_dim
      base02 = '#183c65', -- selection
      base03 = '#eaa4a4', -- comments
      base04 = '#969faf', -- fg_dim
      base05 = '#eaedef', -- fg
      base06 = '#eaedef', -- fg
      base07 = '#eaedef', -- fg
      base08 = '#ff7a5f', -- error / red
      base09 = '#eaedef', -- numbers / constants
      base0A = '#41bf4f', -- types
      base0B = '#65d5a8', -- strings
      base0C = '#d4aaf0', -- special
      base0D = '#7fce5f', -- functions
      base0E = '#70a0ff', -- keywords
      base0F = '#eaa4a4', -- delimiters
   },
})
vim.g.colors_name = 'ef-maris-dark'

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
hi('Boolean', { fg = '#12b4ff' })
hi('Bracket', { fg = '#969faf' })
hi('Character', { fg = '#65d5a8' })
hi('ColorColumn', { bg = '#4a5664' })
hi('Comment', { fg = '#eaa4a4', italic = true })
hi('Conditional', { fg = '#70a0ff', bold = true })
hi('Constant', { fg = '#12b4ff' })
hi('Cursor', { bg = '#8fdfff' })
hi('CursorLine', { bg = '#243242' })
hi('CursorLineNr', { fg = '#12b4ff', bold = true })
hi('Debug', { fg = '#f0c060', bold = true })
hi('Define', { fg = '#70a0ff', bold = true })
hi('Delimiter', { fg = '#eaa4a4' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#12b4ff' })
hi('Error', { fg = '#ff7a5f', bold = true })
hi('ErrorMsg', { fg = '#ff7a5f', bold = true })
hi('Exception', { fg = '#70a0ff', bold = true })
hi('Float', { fg = '#12b4ff' })
hi('FloatBorder', { fg = '#595a63' })
hi('FoldColumn', { fg = '#eaedef' })
hi('Folded', { fg = '#969faf' })
hi('Function', { fg = '#7fce5f' })
hi('FunctionCall', { fg = '#7fce5f' })
hi('Identifier', { fg = '#2fd0db' })
hi('Ignore', { fg = '#969faf' })
hi('Include', { fg = '#70a0ff', bold = true })
hi('Keyword', { fg = '#70a0ff', bold = true })
hi('Label', { fg = '#70a0ff', bold = true })
hi('LineNr', { fg = '#969faf' })
hi('Macro', { fg = '#cf90ff' })
hi('MoreMsg', { fg = '#30c489', bold = true })
hi('NonText', { fg = '#969faf' })
hi('Normal', { fg = '#eaedef', bg = '#131c2b' })
hi('NormalFloat', { fg = '#eaedef', bg = '#4a5664' })
hi('Number', { fg = '#eaedef' })
hi('Operator', { fg = '#eaedef' })
hi('Parameter', { fg = '#d0d24f' })
hi('PmenuSbar', { fg = '#595a63', bg = '#131c2b' })
hi('PmenuThumb', { fg = '#eaedef', bg = '#684d54' })
hi('PreCondit', { fg = '#70a0ff', bold = true })
hi('PreProc', { fg = '#cf90ff' })
hi('Property', { fg = '#2fd0db' })
hi('Repeat', { fg = '#70a0ff', bold = true })
hi('SignColumn', { fg = '#eaedef' })
hi('Special', { fg = '#d4aaf0', bold = true })
hi('SpecialChar', { fg = '#ff7a5f' })
hi('SpecialComment', { fg = '#99bfcf', italic = true })
hi('SpecialKey', { fg = '#12b4ff', bold = true })
hi('Statement', { fg = '#70a0ff', bold = true })
hi('StatusLine', { fg = '#ecf0ff', bg = '#2f527b', underline = true })
hi('StatusLineNC', { fg = '#969faf', bg = '#2a3644', underline = true })
hi('StorageClass', { fg = '#70a0ff', bold = true })
hi('String', { fg = '#65d5a8' })
hi('Structure', { fg = '#70a0ff', bold = true })
hi('TabLine', { bg = '#2a3644' })
hi('TabLineFill', { bg = '#2a3644' })
hi('TabLineSel', { bg = '#131c2b', bold = true })
hi('Tag', { fg = '#d4aaf0', italic = true })
hi('Title', { fg = '#7fce5f' })
hi('Todo', { fg = '#f0c060', bold = true })
hi('Type', { fg = '#41bf4f', bold = true })
hi('Typedef', { fg = '#70a0ff', bold = true })
hi('Underlined', { fg = '#57b0ff', underline = true })
hi('VertSplit', { fg = '#595a63' })
hi('Visual', { bg = '#183c65' })
hi('VisualNOS', { fg = '#eaedef', bg = '#49516a' })
hi('WarningMsg', { fg = '#f0c060', bold = true })
hi('WinSeparator', { fg = '#595a63' })

-- Terminal palette from the official theme.
local term = {
   '#131c2b', '#ff6f6f', '#41bf4f', '#d0d24f', '#57b0ff', '#f59acf', '#2fd0db', '#969faf',
   '#4a5664', '#ff7a5f', '#30c489', '#f0c060', '#70a0ff', '#cf90ff', '#65d5a8', '#eaedef',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
