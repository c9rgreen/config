-- binos: preview the current markdown file in the browser via the binos tool
if vim.g.loaded_binos then
   return
end
vim.g.loaded_binos = true

local jobs = {} -- file path -> vim.SystemObj of a running preview server

vim.api.nvim_create_user_command('Binos', function()
   if vim.bo.filetype ~= 'markdown' then
      return vim.notify('binos: not a markdown buffer', vim.log.levels.ERROR)
   end
   local file = vim.api.nvim_buf_get_name(0)
   if file == '' then
      return vim.notify('binos: buffer has no file', vim.log.levels.ERROR)
   end
   if jobs[file] then
      return vim.notify('binos: preview already running for ' .. vim.fn.fnamemodify(file, ':~'))
   end
   vim.cmd('update')

   local cmd = { 'binos' }
   if vim.o.background == 'dark' then
      table.insert(cmd, '-dark')
   end
   table.insert(cmd, file)
   jobs[file] = vim.system(cmd, { text = true }, function(res)
      jobs[file] = nil
      if res.code ~= 0 then
         vim.schedule(function()
            vim.notify('binos: ' .. vim.trim(res.stderr or ''), vim.log.levels.ERROR)
         end)
      end
   end)
end, { desc = 'Preview the current markdown file with binos' })

-- The servers outlive Neovim otherwise (SIGHUP alone doesn't stop them).
vim.api.nvim_create_autocmd('VimLeavePre', {
   group = vim.api.nvim_create_augroup('binos', { clear = true }),
   callback = function()
      for _, job in pairs(jobs) do
         job:kill('sigterm')
      end
   end,
})
