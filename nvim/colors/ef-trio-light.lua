-- ef-trio-light -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'light'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#f8f5ff', -- bg
      base01 = '#e3e0e9', -- bg_dim
      base02 = '#eed0ff', -- selection
      base03 = '#a05b5f', -- comments
      base04 = '#786e74', -- fg_dim
      base05 = '#4f3363', -- fg
      base06 = '#4f3363', -- fg
      base07 = '#4f3363', -- fg
      base08 = '#d03033', -- error / red
      base09 = '#4f3363', -- numbers / constants
      base0A = '#0f7a9d', -- types
      base0B = '#007f6f', -- strings
      base0C = '#705ae3', -- special
      base0D = '#5165e4', -- functions
      base0E = '#ad45ba', -- keywords
      base0F = '#a05b5f', -- delimiters
   },
})
vim.g.colors_name = 'ef-trio-light'

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
hi('Boolean', { fg = '#c035aa' })
hi('Bracket', { fg = '#786e74' })
hi('Character', { fg = '#007f6f' })
hi('ColorColumn', { bg = '#c3c0c9' })
hi('Comment', { fg = '#a05b5f', italic = true })
hi('Conditional', { fg = '#ad45ba', bold = true })
hi('Constant', { fg = '#c035aa' })
hi('Cursor', { bg = '#4f45ff' })
hi('CursorLine', { bg = '#cfe6ff' })
hi('CursorLineNr', { fg = '#c035aa', bold = true })
hi('Debug', { fg = '#b8532f', bold = true })
hi('Define', { fg = '#ad45ba', bold = true })
hi('Delimiter', { fg = '#a05b5f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#c035aa' })
hi('Error', { fg = '#d03033', bold = true })
hi('ErrorMsg', { fg = '#d03033', bold = true })
hi('Exception', { fg = '#ad45ba', bold = true })
hi('Float', { fg = '#c035aa' })
hi('FloatBorder', { fg = '#c6bac5' })
hi('FoldColumn', { fg = '#4f3363' })
hi('Folded', { fg = '#786e74' })
hi('Function', { fg = '#5165e4' })
hi('FunctionCall', { fg = '#5165e4' })
hi('Identifier', { fg = '#3f6faf' })
hi('Ignore', { fg = '#786e74' })
hi('Include', { fg = '#ad45ba', bold = true })
hi('Keyword', { fg = '#ad45ba', bold = true })
hi('Label', { fg = '#ad45ba', bold = true })
hi('LineNr', { fg = '#786e74' })
hi('Macro', { fg = '#c01f5f' })
hi('MoreMsg', { fg = '#057800', bold = true })
hi('NonText', { fg = '#786e74' })
hi('Normal', { fg = '#4f3363', bg = '#f8f5ff' })
hi('NormalFloat', { fg = '#4f3363', bg = '#c3c0c9' })
hi('Number', { fg = '#4f3363' })
hi('Operator', { fg = '#4f3363' })
hi('Parameter', { fg = '#a45f22' })
hi('PmenuSbar', { fg = '#c6bac5', bg = '#f8f5ff' })
hi('PmenuThumb', { fg = '#4f3363', bg = '#aaeccf' })
hi('PreCondit', { fg = '#ad45ba', bold = true })
hi('PreProc', { fg = '#c01f5f' })
hi('Property', { fg = '#5165e4' })
hi('Repeat', { fg = '#ad45ba', bold = true })
hi('SignColumn', { fg = '#4f3363' })
hi('Special', { fg = '#705ae3', bold = true })
hi('SpecialChar', { fg = '#d03033' })
hi('SpecialComment', { fg = '#804fb0', italic = true })
hi('SpecialKey', { fg = '#c035aa', bold = true })
hi('Statement', { fg = '#ad45ba', bold = true })
hi('StatusLine', { fg = '#241f48', bg = '#ddb4ff', underline = true })
hi('StatusLineNC', { fg = '#786e74', bg = '#e3e0e9', underline = true })
hi('StorageClass', { fg = '#ad45ba', bold = true })
hi('String', { fg = '#007f6f' })
hi('Structure', { fg = '#ad45ba', bold = true })
hi('TabLine', { bg = '#e3e0e9' })
hi('TabLineFill', { bg = '#e3e0e9' })
hi('TabLineSel', { bg = '#f8f5ff', bold = true })
hi('Tag', { fg = '#804fb0', italic = true })
hi('Title', { fg = '#5165e4' })
hi('Todo', { fg = '#b8532f', bold = true })
hi('Type', { fg = '#0f7a9d', bold = true })
hi('Typedef', { fg = '#ad45ba', bold = true })
hi('Underlined', { fg = '#1f6fbf', underline = true })
hi('VertSplit', { fg = '#c6bac5' })
hi('Visual', { bg = '#eed0ff' })
hi('VisualNOS', { fg = '#4f3363', bg = '#b4cfff' })
hi('WarningMsg', { fg = '#b8532f', bold = true })
hi('WinSeparator', { fg = '#c6bac5' })

-- Terminal palette from the official theme.
local term = {
   '#4f3363', '#c3303a', '#057800', '#a45f22', '#375cd6', '#ad45ba', '#1f6fbf', '#c3c0c9',
   '#786e74', '#d03033', '#007f6f', '#b8532f', '#5165e4', '#705ae3', '#0f7a9d', '#f8f5ff',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
