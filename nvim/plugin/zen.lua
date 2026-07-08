-- zen: distraction-free writing mode for markdown buffers (implementation in
-- lua/zen/)
if vim.g.loaded_zen then
   return
end
vim.g.loaded_zen = true

vim.api.nvim_create_user_command('Zen', function()
   require('zen').toggle()
end, { desc = 'Toggle distraction-free writing mode' })

vim.api.nvim_create_autocmd('FileType', {
   group = vim.api.nvim_create_augroup('zen.ftplugin', { clear = true }),
   pattern = 'markdown',
   callback = function(ev)
      vim.keymap.set('n', '<leader>z', function() require('zen').toggle() end, {
         buffer = ev.buf,
         desc = 'Toggle zen mode',
      })
   end,
})
