-- fileref: insert `@path` file references via a fuzzy picker (implementation
-- in lua/fileref/)
if vim.g.loaded_fileref then
   return
end
vim.g.loaded_fileref = true

vim.api.nvim_create_autocmd('FileType', {
   group = vim.api.nvim_create_augroup('fileref', { clear = true }),
   pattern = 'markdown',
   callback = function(ev)
      vim.keymap.set('i', '@', function() require('fileref').insert() end, {
         buffer = ev.buf,
         desc = 'Insert @file reference',
      })
   end,
})
