-- Spell checking and line wrapping for prose (the `@` file-reference mapping
-- lives in plugin/fileref.lua)
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
-- Indent wrapped list items to the text after the marker; `list:-1` sizes the
-- indent by the 'formatlistpat' match, which the runtime ftplugin sets for
-- `-`, `*`, `+`, and `1.` bullets.
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = 'list:-1'
