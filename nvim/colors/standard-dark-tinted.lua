-- standard-dark-tinted -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#182440', -- bg
      base01 = '#3f4560', -- bg_dim
      base02 = '#4f2f99', -- selection
      base03 = '#ff7f24', -- comments
      base04 = '#a6a6a6', -- fg_dim
      base05 = '#ffffff', -- fg
      base06 = '#ffffff', -- fg
      base07 = '#ffffff', -- fg
      base08 = '#ff6f60', -- error / red
      base09 = '#ffffff', -- numbers / constants
      base0A = '#98fb98', -- types
      base0B = '#ffa07a', -- strings
      base0C = '#b0c4de', -- special
      base0D = '#87cefa', -- functions
      base0E = '#00ffff', -- keywords
      base0F = '#ff7f24', -- delimiters
   },
})
vim.g.colors_name = 'standard-dark-tinted'

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
hi('Boolean', { fg = '#7fffd4' })
hi('Bracket', { fg = '#a6a6a6' })
hi('Character', { fg = '#ffa07a' })
hi('ColorColumn', { bg = '#5f6580' })
hi('Comment', { fg = '#ff7f24', italic = true })
hi('Conditional', { fg = '#00ffff', bold = true })
hi('Constant', { fg = '#7fffd4' })
hi('Cursor', { bg = '#d072f0' })
hi('CursorLine', { bg = '#304845' })
hi('CursorLineNr', { fg = '#ffffff', bold = true })
hi('Debug', { fg = '#fec43f', bold = true })
hi('Define', { fg = '#00ffff', bold = true })
hi('Delimiter', { fg = '#ff7f24' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#80aaff' })
hi('Error', { fg = '#ff6f60', bold = true })
hi('ErrorMsg', { fg = '#ff6f60', bold = true })
hi('Exception', { fg = '#00ffff', bold = true })
hi('Float', { fg = '#7fffd4' })
hi('FloatBorder', { fg = '#707090' })
hi('FoldColumn', { fg = '#ffffff', bg = '#2e3355' })
hi('Folded', { fg = '#a6a6a6' })
hi('Function', { fg = '#87cefa' })
hi('FunctionCall', { fg = '#87cefa' })
hi('Identifier', { fg = '#eedd82' })
hi('Ignore', { fg = '#a6a6a6' })
hi('Include', { fg = '#00ffff', bold = true })
hi('Keyword', { fg = '#00ffff', bold = true })
hi('Label', { fg = '#00ffff', bold = true })
hi('LineNr', { fg = '#a6a6a6' })
hi('Macro', { fg = '#b0c4de' })
hi('MoreMsg', { fg = '#44cc44', bold = true })
hi('NonText', { fg = '#a6a6a6' })
hi('Normal', { fg = '#ffffff', bg = '#182440' })
hi('NormalFloat', { fg = '#ffffff', bg = '#5f6580' })
hi('Number', { fg = '#ffffff' })
hi('Operator', { fg = '#ffffff' })
hi('Parameter', { fg = '#eedd82' })
hi('PmenuSbar', { fg = '#707090', bg = '#182440' })
hi('PmenuThumb', { fg = '#ffffff', bg = '#35705f' })
hi('PreCondit', { fg = '#00ffff', bold = true })
hi('PreProc', { fg = '#b0c4de' })
hi('Property', { fg = '#44cc44' })
hi('Repeat', { fg = '#00ffff', bold = true })
hi('SignColumn', { fg = '#ffffff', bg = '#2e3355' })
hi('Special', { fg = '#b0c4de', bold = true })
hi('SpecialChar', { fg = '#ff6f60' })
hi('SpecialComment', { fg = '#ffa07a', italic = true })
hi('SpecialKey', { fg = '#02cfff', bold = true })
hi('Statement', { fg = '#00ffff', bold = true })
hi('StatusLine', { fg = '#ffffff', bg = '#5b59b2', underline = true })
hi('StatusLineNC', { fg = '#a6a6a6', bg = '#353a52', underline = true })
hi('StorageClass', { fg = '#00ffff', bold = true })
hi('String', { fg = '#ffa07a' })
hi('Structure', { fg = '#00ffff', bold = true })
hi('TabLine', { bg = '#3f4560' })
hi('TabLineFill', { bg = '#3f4560' })
hi('TabLineSel', { bg = '#182440', bold = true })
hi('Tag', { fg = '#7fffd4', italic = true })
hi('Title', { fg = '#87cefa' })
hi('Todo', { fg = '#fec43f', bold = true })
hi('Type', { fg = '#98fb98', bold = true })
hi('Typedef', { fg = '#00ffff', bold = true })
hi('Underlined', { fg = '#00ffff', underline = true })
hi('VertSplit', { fg = '#707090' })
hi('Visual', { bg = '#4f2f99' })
hi('VisualNOS', { fg = '#ffffff', bg = '#00688b' })
hi('WarningMsg', { fg = '#fec43f', bold = true })
hi('WinSeparator', { fg = '#707090' })

-- Terminal palette from the official theme.
local term = {
   '#182440', '#ff6f60', '#44cc44', '#eedd82', '#87ceff', '#df8faf', '#00ffff', '#a6a6a6',
   '#5f6580', '#ff7f24', '#98fb98', '#fec43f', '#80aaff', '#ce82ff', '#7fffd4', '#ffffff',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
