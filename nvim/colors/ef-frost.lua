-- ef-frost -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#fcffff', -- bg
      base01 = '#d7dbdb', -- bg_dim
      base02 = '#d4eaf3', -- selection
      base03 = '#7a5f2f', -- comments
      base04 = '#66657f', -- fg_dim
      base05 = '#232323', -- fg
      base06 = '#232323', -- fg
      base07 = '#232323', -- fg
      base08 = '#c42d2f', -- error / red
      base09 = '#232323', -- numbers / constants
      base0A = '#7f5ae0', -- types
      base0B = '#4244ef', -- strings
      base0C = '#1f6fbf', -- special
      base0D = '#00845f', -- functions
      base0E = '#004fc0', -- keywords
      base0F = '#7a5f2f', -- delimiters
   },
})
vim.g.colors_name = 'ef-frost'

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
hi('Bracket', { fg = '#66657f' })
hi('Character', { fg = '#4244ef' })
hi('ColorColumn', { bg = '#b5b8b8' })
hi('Comment', { fg = '#7a5f2f', italic = true })
hi('Conditional', { fg = '#004fc0', bold = true })
hi('Constant', { fg = '#065fff' })
hi('Cursor', { bg = '#0055bb' })
hi('CursorLine', { bg = '#dff6e4' })
hi('CursorLineNr', { fg = '#4244ef', bold = true })
hi('Debug', { fg = '#996c4f', bold = true })
hi('Define', { fg = '#004fc0', bold = true })
hi('Delimiter', { fg = '#7a5f2f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#4244ef' })
hi('Error', { fg = '#c42d2f', bold = true })
hi('ErrorMsg', { fg = '#c42d2f', bold = true })
hi('Exception', { fg = '#004fc0', bold = true })
hi('Float', { fg = '#065fff' })
hi('FloatBorder', { fg = '#b0b7c0' })
hi('FoldColumn', { fg = '#232323' })
hi('Folded', { fg = '#66657f' })
hi('Function', { fg = '#00845f' })
hi('FunctionCall', { fg = '#00845f' })
hi('Identifier', { fg = '#3a6dd2' })
hi('Ignore', { fg = '#66657f' })
hi('Include', { fg = '#004fc0', bold = true })
hi('Keyword', { fg = '#004fc0', bold = true })
hi('Label', { fg = '#004fc0', bold = true })
hi('LineNr', { fg = '#66657f' })
hi('Macro', { fg = '#aa44c5' })
hi('MoreMsg', { fg = '#008a00', bold = true })
hi('NonText', { fg = '#66657f' })
hi('Normal', { fg = '#232323', bg = '#fcffff' })
hi('NormalFloat', { fg = '#232323', bg = '#b5b8b8' })
hi('Number', { fg = '#232323' })
hi('Operator', { fg = '#232323' })
hi('Parameter', { fg = '#aa6100' })
hi('PmenuSbar', { fg = '#b0b7c0', bg = '#fcffff' })
hi('PmenuThumb', { fg = '#232323', bg = '#eab5ff' })
hi('PreCondit', { fg = '#004fc0', bold = true })
hi('PreProc', { fg = '#aa44c5' })
hi('Property', { fg = '#c0469a' })
hi('Repeat', { fg = '#004fc0', bold = true })
hi('SignColumn', { fg = '#232323' })
hi('Special', { fg = '#1f6fbf', bold = true })
hi('SpecialChar', { fg = '#c42d2f' })
hi('SpecialComment', { fg = '#605f9f', italic = true })
hi('SpecialKey', { fg = '#065fff', bold = true })
hi('Statement', { fg = '#004fc0', bold = true })
hi('StatusLine', { fg = '#051524', bg = '#9ad0ff', underline = true })
hi('StatusLineNC', { fg = '#66657f', bg = '#d7dbdb', underline = true })
hi('StorageClass', { fg = '#004fc0', bold = true })
hi('String', { fg = '#4244ef' })
hi('Structure', { fg = '#004fc0', bold = true })
hi('TabLine', { bg = '#d7dbdb' })
hi('TabLineFill', { bg = '#d7dbdb' })
hi('TabLineSel', { bg = '#fcffff', bold = true })
hi('Tag', { fg = '#605f9f', italic = true })
hi('Title', { fg = '#00845f' })
hi('Todo', { fg = '#996c4f', bold = true })
hi('Type', { fg = '#7f5ae0', bold = true })
hi('Typedef', { fg = '#004fc0', bold = true })
hi('Underlined', { fg = '#1f6fbf', underline = true })
hi('VertSplit', { fg = '#b0b7c0' })
hi('Visual', { bg = '#d4eaf3' })
hi('VisualNOS', { fg = '#232323', bg = '#aae0bf' })
hi('WarningMsg', { fg = '#996c4f', bold = true })
hi('WinSeparator', { fg = '#b0b7c0' })

-- Terminal palette from the official theme.
local term = {
   '#232323', '#c42d2f', '#008a00', '#aa6100', '#004fc0', '#aa44c5', '#1f6fbf', '#b5b8b8',
   '#66657f', '#d03003', '#00845f', '#b6532f', '#4244ef', '#7f5ae0', '#007a85', '#fcffff',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
