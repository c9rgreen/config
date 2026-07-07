-- gitbrowse: open the current file on the git host (implementation in lua/gitbrowse/)
if vim.g.loaded_gitbrowse then
   return
end
vim.g.loaded_gitbrowse = true

vim.api.nvim_create_user_command('GitBrowse', function(cmd)
   local opts = {}
   if cmd.range > 0 then
      opts.line_start, opts.line_end = cmd.line1, cmd.line2
   end
   require('gitbrowse').open(opts)
end, { range = true, desc = 'Open the current file on the git host' })
