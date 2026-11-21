-- obsidian.nvim (Obsidian vault tools)
vim.pack.add({
   { src = 'https://github.com/obsidian-nvim/obsidian.nvim', version = vim.version.range('*') },
})

-- obsidian.nvim's UI (checkboxes, link and tag highlighting) relies on
-- conceal. Set it for vault notes only, so other markdown stays unconcealed.
-- This autocmd is created before setup() so it runs ahead of the plugin's
-- BufEnter conceallevel check.
vim.api.nvim_create_autocmd('BufEnter', {
   group = vim.api.nvim_create_augroup('obsidian.conceal', { clear = true }),
   pattern = vim.fn.expand('~/PKM') .. '/**.md',
   callback = function()
      vim.opt_local.conceallevel = 2
   end,
})

require('obsidian').setup({
   legacy_commands = false, -- removed in 4.0.0
   workspaces = {
      { name = 'pkm', path = '~/PKM' },
   },
   picker = { name = 'mini.pick' },
})
