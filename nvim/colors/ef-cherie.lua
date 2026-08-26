-- ef-cherie -- a mini.base16 port of the arete.nvim theme:
-- https://github.com/szymonwilczek/arete.nvim
-- mini.base16 lays the base and covers the groups arete leaves
-- undefined; every highlight the official theme defines is then
-- applied verbatim on top, exactly as arete's own loader does.

vim.o.background = 'dark'
vim.cmd('highlight clear')

require('mini.base16').setup({
   palette = {
      base00 = '#190a0f', -- bg
      base01 = '#392a2f', -- bg_dim
      base02 = '#232f3f', -- selection
      base03 = '#bf9f8f', -- comments
      base04 = '#808898', -- fg_dim
      base05 = '#d3cfcf', -- fg
      base06 = '#d3cfcf', -- fg
      base07 = '#d3cfcf', -- fg
      base08 = '#ff656f', -- error / red
      base09 = '#d3cfcf', -- numbers / constants
      base0A = '#f470df', -- types
      base0B = '#e5b76f', -- strings
      base0C = '#a897ef', -- special
      base0D = '#f59280', -- functions
      base0E = '#ef80bf', -- keywords
      base0F = '#bf9f8f', -- delimiters
   },
})
vim.g.colors_name = 'ef-cherie'

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
hi('Boolean', { fg = '#ff78aa' })
hi('Bracket', { fg = '#808898' })
hi('Character', { fg = '#e5b76f' })
hi('ColorColumn', { bg = '#594a4f' })
hi('Comment', { fg = '#bf9f8f', italic = true })
hi('Conditional', { fg = '#ef80bf', bold = true })
hi('Constant', { fg = '#ff78aa' })
hi('Cursor', { bg = '#ff5aaf' })
hi('CursorLine', { bg = '#401f33' })
hi('CursorLineNr', { fg = '#f470df', bold = true })
hi('Debug', { fg = '#ea9955', bold = true })
hi('Define', { fg = '#ef80bf', bold = true })
hi('Delimiter', { fg = '#bf9f8f' })
hi('DiagnosticError', { link = 'Error' })
hi('DiagnosticHint', { link = 'Question' })
hi('DiagnosticInfo', { link = 'MoreMsg' })
hi('DiagnosticOk', { link = 'MoreMsg' })
hi('DiagnosticWarn', { link = 'WarningMsg' })
hi('Directory', { fg = '#f470df' })
hi('Error', { fg = '#ff656f', bold = true })
hi('ErrorMsg', { fg = '#ff656f', bold = true })
hi('Exception', { fg = '#ef80bf', bold = true })
hi('Float', { fg = '#ff78aa' })
hi('FloatBorder', { fg = '#695960' })
hi('FoldColumn', { fg = '#d3cfcf' })
hi('Folded', { fg = '#808898' })
hi('Function', { fg = '#f59280' })
hi('FunctionCall', { fg = '#f59280' })
hi('Identifier', { fg = '#df7fff' })
hi('Ignore', { fg = '#808898' })
hi('Include', { fg = '#ef80bf', bold = true })
hi('Keyword', { fg = '#ef80bf', bold = true })
hi('Label', { fg = '#ef80bf', bold = true })
hi('LineNr', { fg = '#808898' })
hi('Macro', { fg = '#8fbaef' })
hi('MoreMsg', { fg = '#60b444', bold = true })
hi('NonText', { fg = '#808898' })
hi('Normal', { fg = '#d3cfcf', bg = '#190a0f' })
hi('NormalFloat', { fg = '#d3cfcf', bg = '#594a4f' })
hi('Number', { fg = '#d3cfcf' })
hi('Operator', { fg = '#d3cfcf' })
hi('Parameter', { fg = '#e5b76f' })
hi('PmenuSbar', { fg = '#695960', bg = '#190a0f' })
hi('PmenuThumb', { fg = '#d3cfcf', bg = '#303f6f' })
hi('PreCondit', { fg = '#ef80bf', bold = true })
hi('PreProc', { fg = '#8fbaef' })
hi('Property', { fg = '#a897ef' })
hi('Repeat', { fg = '#ef80bf', bold = true })
hi('SignColumn', { fg = '#d3cfcf' })
hi('Special', { fg = '#a897ef', bold = true })
hi('SpecialChar', { fg = '#ff656f' })
hi('SpecialComment', { fg = '#cc9bcf', italic = true })
hi('SpecialKey', { fg = '#ea9955', bold = true })
hi('Statement', { fg = '#ef80bf', bold = true })
hi('StatusLine', { fg = '#ffcfdf', bg = '#771a4f', underline = true })
hi('StatusLineNC', { fg = '#808898', bg = '#392a2f', underline = true })
hi('StorageClass', { fg = '#ef80bf', bold = true })
hi('String', { fg = '#e5b76f' })
hi('Structure', { fg = '#ef80bf', bold = true })
hi('TabLine', { bg = '#392a2f' })
hi('TabLineFill', { bg = '#392a2f' })
hi('TabLineSel', { bg = '#190a0f', bold = true })
hi('Tag', { fg = '#cc9bcf', italic = true })
hi('Title', { fg = '#f59280' })
hi('Todo', { fg = '#ea9955', bold = true })
hi('Type', { fg = '#f470df', bold = true })
hi('Typedef', { fg = '#ef80bf', bold = true })
hi('Underlined', { fg = '#df7fff', underline = true })
hi('VertSplit', { fg = '#695960' })
hi('Visual', { bg = '#232f3f' })
hi('VisualNOS', { fg = '#d3cfcf', bg = '#66364f' })
hi('WarningMsg', { fg = '#ea9955', bold = true })
hi('WinSeparator', { fg = '#695960' })

-- Terminal palette from the official theme.
local term = {
   '#190a0f', '#ff7359', '#60b444', '#e5b76f', '#8fa5f6', '#ef80bf', '#8fbaef', '#808898',
   '#594a4f', '#ff656f', '#60bf88', '#ea9955', '#a897ef', '#df7fff', '#8fcfdf', '#d3cfcf',
}
for i, color in ipairs(term) do vim.g['terminal_color_' .. (i - 1)] = color end
