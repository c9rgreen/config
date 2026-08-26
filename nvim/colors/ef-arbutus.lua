-- ef-arbutus -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#ffead8', -- bg
      base01 = '#e7d2cb', -- bg_dim
      base02 = '#dbe0c0', -- selection
      base03 = '#6e678f', -- comments
      base04 = '#6e678f', -- fg_dim
      base05 = '#393330', -- fg
      base06 = '#393330', -- fg
      base07 = '#393330', -- fg
      base08 = '#b20f00', -- error / red
      base09 = '#393330', -- numbers / constants
      base0A = '#b0000f', -- types
      base0B = '#557000', -- strings
      base0C = '#00704f', -- special
      base0D = '#007000', -- functions
      base0E = '#8f2f30', -- keywords
      base0F = '#6e678f', -- delimiters
   },
})
vim.g.colors_name = 'ef-arbutus'

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
hi('Boolean', { fg = '#a23ea4' })
hi('Bracket', { fg = '#6e678f' })
hi('Character', { fg = '#557000' })
hi('ColorColumn', { bg = '#c7b2ab' })
hi('Comment', { fg = '#6e678f', italic = true })
hi('Conditional', { fg = '#8f2f30', bold = true })
hi('Constant', { fg = '#a23ea4' })
hi('Cursor', { bg = '#208f10' })
hi('CursorLine', { bg = '#fad8bf' })
hi('CursorLineNr', { fg = '#007000', bold = true })
hi('Debug', { fg = '#906200', bold = true })
hi('Define', { fg = '#8f2f30', bold = true })
hi('Delimiter', { fg = '#6e678f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#007000' })
hi('Error', { fg = '#b20f00', bold = true })
hi('ErrorMsg', { fg = '#b20f00', bold = true })
hi('Exception', { fg = '#8f2f30', bold = true })
hi('Float', { fg = '#a23ea4' })
hi('FloatBorder', { fg = '#c0b4a6' })
hi('FoldColumn', { fg = '#393330' })
hi('Folded', { fg = '#6e678f' })
hi('Function', { fg = '#007000' })
hi('FunctionCall', { fg = '#007000' })
hi('Identifier', { fg = '#aa184f' })
hi('Ignore', { fg = '#6e678f' })
hi('Include', { fg = '#8f2f30', bold = true })
hi('Keyword', { fg = '#8f2f30', bold = true })
hi('Label', { fg = '#8f2f30', bold = true })
hi('LineNr', { fg = '#6e678f' })
hi('Macro', { fg = '#0f7688' })
hi('MoreMsg', { fg = '#007000', bold = true })
hi('NonText', { fg = '#6e678f' })
hi('Normal', { fg = '#393330', bg = '#ffead8' })
hi('NormalFloat', { fg = '#393330', bg = '#c7b2ab' })
hi('Number', { fg = '#393330' })
hi('Operator', { fg = '#393330' })
hi('Parameter', { fg = '#906200' })
hi('PmenuSbar', { fg = '#c0b4a6', bg = '#ffead8' })
hi('PmenuThumb', { fg = '#393330', bg = '#afdeaf' })
hi('PreCondit', { fg = '#8f2f30', bold = true })
hi('PreProc', { fg = '#0f7688' })
hi('Property', { fg = '#3f69af' })
hi('Repeat', { fg = '#8f2f30', bold = true })
hi('SignColumn', { fg = '#393330' })
hi('Special', { fg = '#00704f', bold = true })
hi('SpecialChar', { fg = '#b20f00' })
hi('SpecialComment', { fg = '#8d6068', italic = true })
hi('SpecialKey', { fg = '#b0000f', bold = true })
hi('Statement', { fg = '#8f2f30', bold = true })
hi('StatusLine', { fg = '#40231f', bg = '#e9a0a0', underline = true })
hi('StatusLineNC', { fg = '#6e678f', bg = '#e7d2cb', underline = true })
hi('StorageClass', { fg = '#8f2f30', bold = true })
hi('String', { fg = '#557000' })
hi('Structure', { fg = '#8f2f30', bold = true })
hi('TabLine', { bg = '#e7d2cb' })
hi('TabLineFill', { bg = '#e7d2cb' })
hi('TabLineSel', { bg = '#ffead8', bold = true })
hi('Tag', { fg = '#845592', italic = true })
hi('Title', { fg = '#007000' })
hi('Todo', { fg = '#906200', bold = true })
hi('Type', { fg = '#b0000f', bold = true })
hi('Typedef', { fg = '#8f2f30', bold = true })
hi('Underlined', { fg = '#00704f', underline = true })
hi('VertSplit', { fg = '#c0b4a6' })
hi('Visual', { bg = '#dbe0c0' })
hi('VisualNOS', { fg = '#393330', bg = '#f5bfc5' })
hi('WarningMsg', { fg = '#906200', bold = true })
hi('WinSeparator', { fg = '#c0b4a6' })

-- Terminal palette from the official theme.
local term = {
   '#393330', '#b0000f', '#007000', '#906200', '#375cc6', '#a23ea4', '#3f69af', '#c7b2ab',
   '#6e678f', '#b20f00', '#00704f', '#b44405', '#5f55df', '#6448ca', '#0f7688', '#ffead8',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
