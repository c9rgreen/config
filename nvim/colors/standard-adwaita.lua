-- standard-adwaita -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#ededed', -- bg
      base01 = '#eeeeec', -- bg_dim
      base02 = '#c2d5e9', -- selection
      base03 = '#204a87', -- comments
      base04 = '#373e41', -- fg_dim
      base05 = '#2e3436', -- fg
      base06 = '#2e3436', -- fg
      base07 = '#2e3436', -- fg
      base08 = '#b50000', -- error / red
      base09 = '#2e3436', -- numbers / constants
      base0A = '#2f8b58', -- types
      base0B = '#4e9a06', -- strings
      base0C = '#a020f0', -- special
      base0D = '#00578e', -- functions
      base0E = '#a52a2a', -- keywords
      base0F = '#204a87', -- delimiters
   },
})
vim.g.colors_name = 'standard-adwaita'

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
hi('Boolean', { fg = '#f5666d' })
hi('Bracket', { fg = '#373e41' })
hi('Character', { fg = '#4e9a06' })
hi('ColorColumn', { bg = '#d6d6d6' })
hi('Comment', { fg = '#204a87', italic = true })
hi('Conditional', { fg = '#a52a2a', bold = true })
hi('Constant', { fg = '#f5666d' })
hi('Cursor', { bg = '#00bbff' })
hi('CursorLine', { bg = '#d9e2ef' })
hi('CursorLineNr', { fg = '#2e3436', bg = '#d9e2ef', bold = true })
hi('Debug', { fg = '#ce5c00', bold = true })
hi('Define', { fg = '#a52a2a', bold = true })
hi('Delimiter', { fg = '#204a87' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#3584e4' })
hi('Error', { fg = '#b50000', bold = true })
hi('ErrorMsg', { fg = '#b50000', bold = true })
hi('Exception', { fg = '#a52a2a', bold = true })
hi('Float', { fg = '#f5666d' })
hi('FloatBorder', { fg = '#ededed' })
hi('FoldColumn', { fg = '#2e3436', bg = '#e6e6e6' })
hi('Folded', { fg = '#373e41' })
hi('Function', { fg = '#00578e' })
hi('FunctionCall', { fg = '#00578e' })
hi('Identifier', { fg = '#0084c8' })
hi('Ignore', { fg = '#373e41' })
hi('Include', { fg = '#a52a2a', bold = true })
hi('Keyword', { fg = '#a52a2a', bold = true })
hi('Label', { fg = '#a52a2a', bold = true })
hi('LineNr', { fg = '#373e41' })
hi('Macro', { fg = '#820014' })
hi('MoreMsg', { fg = '#4e9a06', bold = true })
hi('NonText', { fg = '#373e41' })
hi('Normal', { fg = '#2e3436', bg = '#ededed' })
hi('NormalFloat', { fg = '#2e3436', bg = '#d6d6d6' })
hi('Number', { fg = '#2e3436' })
hi('Operator', { fg = '#2e3436' })
hi('Parameter', { fg = '#c88800' })
hi('PmenuSbar', { fg = '#ededed', bg = '#ededed' })
hi('PmenuThumb', { fg = '#2e3436', bg = '#3cc0d8' })
hi('PreCondit', { fg = '#a52a2a', bold = true })
hi('PreProc', { fg = '#820014' })
hi('Property', { fg = '#2190a4' })
hi('Repeat', { fg = '#a52a2a', bold = true })
hi('SignColumn', { fg = '#2e3436', bg = '#e6e6e6' })
hi('Special', { fg = '#a020f0', bold = true })
hi('SpecialChar', { fg = '#b50000' })
hi('SpecialComment', { fg = '#2f8b58', italic = true })
hi('SpecialKey', { fg = '#0066cc', bold = true })
hi('Statement', { fg = '#a52a2a', bold = true })
hi('StatusLine', { fg = '#2e3436', bg = '#ffffff', underline = true })
hi('StatusLineNC', { fg = '#c6c6c6', bg = '#ffffff', underline = true })
hi('StorageClass', { fg = '#a52a2a', bold = true })
hi('String', { fg = '#4e9a06' })
hi('Structure', { fg = '#a52a2a', bold = true })
hi('TabLine', { bg = '#eeeeec' })
hi('TabLineFill', { bg = '#eeeeec' })
hi('TabLineSel', { bg = '#ededed', bold = true })
hi('Tag', { fg = '#f5666d', italic = true })
hi('Title', { fg = '#00578e' })
hi('Todo', { fg = '#ce5c00', bold = true })
hi('Type', { fg = '#2f8b58', bold = true })
hi('Typedef', { fg = '#a52a2a', bold = true })
hi('Underlined', { fg = '#0066cc', underline = true })
hi('VertSplit', { fg = '#ededed' })
hi('Visual', { bg = '#c2d5e9' })
hi('VisualNOS', { fg = '#2e3436', bg = '#b8e3b8' })
hi('WarningMsg', { fg = '#ce5c00', bold = true })
hi('WinSeparator', { fg = '#ededed' })

-- Terminal palette from the official theme.
local term = {
   '#2e3436', '#b50000', '#4cb64a', '#c88800', '#3584e4', '#9841bb', '#2190a4', '#d6d6d6',
   '#373e41', '#c01c28', '#2f8b58', '#a56100', '#2f5cb0', '#a020f0', '#0084c8', '#ededed',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
