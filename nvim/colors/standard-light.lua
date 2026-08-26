-- standard-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#ffffff', -- bg
      base01 = '#dcdcdc', -- bg_dim
      base02 = '#eedc82', -- selection
      base03 = '#b22222', -- comments
      base04 = '#7f7f7f', -- fg_dim
      base05 = '#000000', -- fg
      base06 = '#000000', -- fg
      base07 = '#000000', -- fg
      base08 = '#e00033', -- error / red
      base09 = '#000000', -- numbers / constants
      base0A = '#228b22', -- types
      base0B = '#8b2252', -- strings
      base0C = '#483d8b', -- special
      base0D = '#0000ff', -- functions
      base0E = '#800080', -- keywords
      base0F = '#b22222', -- delimiters
   },
})
vim.g.colors_name = 'standard-light'

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
hi('Boolean', { fg = '#008b8b' })
hi('Bracket', { fg = '#7f7f7f' })
hi('Character', { fg = '#8b2252' })
hi('ColorColumn', { bg = '#bfbfbf' })
hi('Comment', { fg = '#b22222', italic = true })
hi('Conditional', { fg = '#800080', bold = true })
hi('Constant', { fg = '#008b8b' })
hi('Cursor', { bg = '#000000' })
hi('CursorLine', { bg = '#b4eeb4' })
hi('CursorLineNr', { fg = '#000000', bold = true })
hi('Debug', { fg = '#b6532f', bold = true })
hi('Define', { fg = '#800080', bold = true })
hi('Delimiter', { fg = '#b22222' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#001faf' })
hi('Error', { fg = '#e00033', bold = true })
hi('ErrorMsg', { fg = '#e00033', bold = true })
hi('Exception', { fg = '#800080', bold = true })
hi('Float', { fg = '#008b8b' })
hi('FloatBorder', { fg = '#bababa' })
hi('FoldColumn', { fg = '#000000', bg = '#ebebeb' })
hi('Folded', { fg = '#7f7f7f' })
hi('Function', { fg = '#0000ff' })
hi('FunctionCall', { fg = '#0000ff' })
hi('Identifier', { fg = '#a0522d' })
hi('Ignore', { fg = '#7f7f7f' })
hi('Include', { fg = '#800080', bold = true })
hi('Keyword', { fg = '#800080', bold = true })
hi('Label', { fg = '#800080', bold = true })
hi('LineNr', { fg = '#7f7f7f' })
hi('Macro', { fg = '#483d8b' })
hi('MoreMsg', { fg = '#228b22', bold = true })
hi('NonText', { fg = '#7f7f7f' })
hi('Normal', { fg = '#000000', bg = '#ffffff' })
hi('NormalFloat', { fg = '#000000', bg = '#bfbfbf' })
hi('Number', { fg = '#000000' })
hi('Operator', { fg = '#000000' })
hi('Parameter', { fg = '#a45f22' })
hi('PmenuSbar', { fg = '#bababa', bg = '#ffffff' })
hi('PmenuThumb', { fg = '#000000', bg = '#aaeccf' })
hi('PreCondit', { fg = '#800080', bold = true })
hi('PreProc', { fg = '#483d8b' })
hi('Property', { fg = '#228b22' })
hi('Repeat', { fg = '#800080', bold = true })
hi('SignColumn', { fg = '#000000', bg = '#ebebeb' })
hi('Special', { fg = '#483d8b', bold = true })
hi('SpecialChar', { fg = '#e00033' })
hi('SpecialComment', { fg = '#8b2252', italic = true })
hi('SpecialKey', { fg = '#001faf', bold = true })
hi('Statement', { fg = '#800080', bold = true })
hi('StatusLine', { fg = '#000000', bg = '#b3b3b3', underline = true })
hi('StatusLineNC', { fg = '#7f7f7f', bg = '#e5e5e5', underline = true })
hi('StorageClass', { fg = '#800080', bold = true })
hi('String', { fg = '#8b2252' })
hi('Structure', { fg = '#800080', bold = true })
hi('TabLine', { bg = '#dcdcdc' })
hi('TabLineFill', { bg = '#dcdcdc' })
hi('TabLineSel', { bg = '#ffffff', bold = true })
hi('Tag', { fg = '#008b8b', italic = true })
hi('Title', { fg = '#0000ff' })
hi('Todo', { fg = '#b6532f', bold = true })
hi('Type', { fg = '#228b22', bold = true })
hi('Typedef', { fg = '#800080', bold = true })
hi('Underlined', { fg = '#3a5fcd', underline = true })
hi('VertSplit', { fg = '#bababa' })
hi('Visual', { bg = '#eedc82' })
hi('VisualNOS', { fg = '#000000', bg = '#ffff00' })
hi('WarningMsg', { fg = '#b6532f', bold = true })
hi('WinSeparator', { fg = '#bababa' })

-- Terminal palette from the official theme.
local term = {
   '#000000', '#b3303a', '#228b22', '#a45f22', '#001faf', '#721045', '#1f6fbf', '#bfbfbf',
   '#7f7f7f', '#e00033', '#008858', '#b6532f', '#3a5fcd', '#800080', '#008b8b', '#ffffff',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
