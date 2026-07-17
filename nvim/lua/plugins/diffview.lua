-- Diffview (git diff and file history views)
vim.pack.add({'https://github.com/dlyongemallo/diffview-plus.nvim'})

require('diffview').setup()

-- Open a Diffview against the commit sha reported by the `git last` alias
vim.api.nvim_create_user_command('DiffLast', function()
   local res = vim.system({ 'git', 'last' }, { text = true }):wait()
   local sha = vim.trim(res.stdout or '')
   if res.code ~= 0 or sha == '' then
      local err = vim.trim(res.stderr or '')
      vim.notify('git last failed: ' .. (err ~= '' and err or 'no output'), vim.log.levels.ERROR)
      return
   end
   vim.cmd('DiffviewOpen ' .. sha)
end, { desc = 'Diffview of the commit from `git last`' })

vim.keymap.set('n', '<leader>gg', '<cmd>DiffviewToggle<cr>', { desc = 'Toggle Diffview' })
vim.keymap.set('n', '<leader>gr', '<cmd>DiffviewToggle<cr>', { desc = 'Review branch' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory<cr>', { desc = 'File history (repo)' })
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', { desc = 'File history (current)' })
