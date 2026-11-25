-- obsidian.nvim (Obsidian vault tools)
vim.pack.add({
   { src = 'https://github.com/obsidian-nvim/obsidian.nvim', version = vim.version.range('*') },
})

-- The vault isn't on every machine. setup() errors when none of its
-- workspaces exist, so skip the plugin entirely without one.
local vault = vim.fn.expand('~/PKM')
if vim.fn.isdirectory(vault) == 0 then
   return
end

-- obsidian.nvim's UI (checkboxes, link and tag highlighting) relies on
-- conceal. Set it for vault notes only, so other markdown stays unconcealed.
-- This autocmd is created before setup() so it runs ahead of the plugin's
-- BufEnter conceallevel check.
vim.api.nvim_create_autocmd('BufEnter', {
   group = vim.api.nvim_create_augroup('obsidian.conceal', { clear = true }),
   pattern = vault .. '/**.md',
   callback = function()
      vim.opt_local.conceallevel = 2
   end,
})

require('obsidian').setup({
   legacy_commands = false, -- removed in 4.0.0
   workspaces = {
      { name = 'pkm', path = vault },
   },
   picker = { name = 'mini.pick' },
})
