-- pack: Ex commands for the native plugin manager (vim.pack)
if vim.g.loaded_pack then
   return
end
vim.g.loaded_pack = true

local function pack_complete(arg_lead)
   local names = vim.tbl_map(
      function(p) return p.spec.name end,
      vim.pack.get(nil, { info = false })
   )
   return vim.tbl_filter(function(name) return vim.startswith(name, arg_lead) end, names)
end

vim.api.nvim_create_user_command('PackUpdate', function(cmd)
   vim.pack.update(#cmd.fargs > 0 and cmd.fargs or nil, { force = cmd.bang })
end, {
   nargs = '*',
   bang = true,
   complete = pack_complete,
   desc = 'Update plugins (all if no names; ! applies without confirmation)',
})

vim.api.nvim_create_user_command('PackDel', function(cmd)
   vim.pack.del(cmd.fargs, { force = cmd.bang })
end, {
   nargs = '+',
   bang = true,
   complete = pack_complete,
   desc = 'Remove plugins from disk (! removes even active ones)',
})

vim.api.nvim_create_user_command('PackClean', function()
   local inactive = vim.tbl_map(
      function(p) return p.spec.name end,
      vim.tbl_filter(function(p) return not p.active end, vim.pack.get(nil, { info = false }))
   )
   if #inactive == 0 then
      vim.notify('No inactive plugins to clean', vim.log.levels.INFO)
      return
   end
   local prompt = 'Remove inactive plugins?\n' .. table.concat(inactive, '\n')
   if vim.fn.confirm(prompt, '&Yes\n&No', 2) == 1 then
      vim.pack.del(inactive)
   end
end, { desc = 'Remove plugins on disk that are not active in this session' })

vim.api.nvim_create_user_command('PackList', function()
   for _, p in ipairs(vim.pack.get(nil, { info = false })) do
      local hl = p.active and 'Normal' or 'Comment'
      local line = string.format(
         '%s %-28s %-8s %s',
         p.active and '●' or '○', p.spec.name, p.rev:sub(1, 8), p.spec.src
      )
      vim.api.nvim_echo({ { line, hl } }, false, {})
   end
end, { desc = 'List plugins managed by vim.pack' })
