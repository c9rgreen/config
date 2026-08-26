-- ef-trio-dark -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#160f0f', -- bg
      base01 = '#362f35', -- bg_dim
      base02 = '#16304f', -- selection
      base03 = '#c7a07f', -- comments
      base04 = '#908890', -- fg_dim
      base05 = '#d8cfd5', -- fg
      base06 = '#d8cfd5', -- fg
      base07 = '#d8cfd5', -- fg
      base08 = '#ff7560', -- error / red
      base09 = '#d8cfd5', -- numbers / constants
      base0A = '#8fcfdf', -- types
      base0B = '#60bf88', -- strings
      base0C = '#a698ef', -- special
      base0D = '#8895ff', -- functions
      base0E = '#d37faf', -- keywords
      base0F = '#c7a07f', -- delimiters
   },
})
vim.g.colors_name = 'ef-trio-dark'

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
hi('Boolean', { fg = '#e772df' })
hi('Bracket', { fg = '#908890' })
hi('Character', { fg = '#60bf88' })
hi('ColorColumn', { bg = '#564f55' })
hi('Comment', { fg = '#c7a07f', italic = true })
hi('Conditional', { fg = '#d37faf', bold = true })
hi('Constant', { fg = '#e772df' })
hi('Cursor', { bg = '#ff99ff' })
hi('CursorLine', { bg = '#34223f' })
hi('CursorLineNr', { fg = '#e772df', bold = true })
hi('Debug', { fg = '#d4a052', bold = true })
hi('Define', { fg = '#d37faf', bold = true })
hi('Delimiter', { fg = '#c7a07f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#e772df' })
hi('Error', { fg = '#ff7560', bold = true })
hi('ErrorMsg', { fg = '#ff7560', bold = true })
hi('Exception', { fg = '#d37faf', bold = true })
hi('Float', { fg = '#e772df' })
hi('FloatBorder', { fg = '#605760' })
hi('FoldColumn', { fg = '#d8cfd5' })
hi('Folded', { fg = '#908890' })
hi('Function', { fg = '#8895ff' })
hi('FunctionCall', { fg = '#8895ff' })
hi('Identifier', { fg = '#9ac2ff' })
hi('Ignore', { fg = '#908890' })
hi('Include', { fg = '#d37faf', bold = true })
hi('Keyword', { fg = '#d37faf', bold = true })
hi('Label', { fg = '#d37faf', bold = true })
hi('LineNr', { fg = '#908890' })
hi('Macro', { fg = '#ff85aa' })
hi('MoreMsg', { fg = '#60b444', bold = true })
hi('NonText', { fg = '#908890' })
hi('Normal', { fg = '#d8cfd5', bg = '#160f0f' })
hi('NormalFloat', { fg = '#d8cfd5', bg = '#564f55' })
hi('Number', { fg = '#d8cfd5' })
hi('Operator', { fg = '#d8cfd5' })
hi('Parameter', { fg = '#d4a052' })
hi('PmenuSbar', { fg = '#605760', bg = '#160f0f' })
hi('PmenuThumb', { fg = '#d8cfd5', bg = '#004f3f' })
hi('PreCondit', { fg = '#d37faf', bold = true })
hi('PreProc', { fg = '#ff85aa' })
hi('Property', { fg = '#8895ff' })
hi('Repeat', { fg = '#d37faf', bold = true })
hi('SignColumn', { fg = '#d8cfd5' })
hi('Special', { fg = '#a698ef', bold = true })
hi('SpecialChar', { fg = '#ff7560' })
hi('SpecialComment', { fg = '#c9addf', italic = true })
hi('SpecialKey', { fg = '#e772df', bold = true })
hi('Statement', { fg = '#d37faf', bold = true })
hi('StatusLine', { fg = '#ffdfdf', bg = '#6a294f', underline = true })
hi('StatusLineNC', { fg = '#908890', bg = '#362f35', underline = true })
hi('StorageClass', { fg = '#d37faf', bold = true })
hi('String', { fg = '#60bf88' })
hi('Structure', { fg = '#d37faf', bold = true })
hi('TabLine', { bg = '#362f35' })
hi('TabLineFill', { bg = '#362f35' })
hi('TabLineSel', { bg = '#160f0f', bold = true })
hi('Tag', { fg = '#c9addf', italic = true })
hi('Title', { fg = '#8895ff' })
hi('Todo', { fg = '#d4a052', bold = true })
hi('Type', { fg = '#8fcfdf', bold = true })
hi('Typedef', { fg = '#d37faf', bold = true })
hi('Underlined', { fg = '#8fbaff', underline = true })
hi('VertSplit', { fg = '#605760' })
hi('Visual', { bg = '#16304f' })
hi('VisualNOS', { fg = '#d8cfd5', bg = '#452f5f' })
hi('WarningMsg', { fg = '#d4a052', bold = true })
hi('WinSeparator', { fg = '#605760' })

-- Terminal palette from the official theme.
local term = {
   '#160f0f', '#f48359', '#60b444', '#d4a052', '#7fa5f6', '#d37faf', '#8fbaff', '#908890',
   '#564f55', '#ff7560', '#60bf88', '#ef926f', '#8895ff', '#a698ef', '#8fcfdf', '#d8cfd5',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
