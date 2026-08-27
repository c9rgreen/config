-- codediff: VS Code-style git diff viewer (:CodeDiff)
-- It downloads the ready-made programs it needs the first time it runs, so
-- nothing has to be compiled, and it registers :CodeDiff itself. There is
-- nothing to set up beyond adding it.
vim.pack.add({'https://github.com/esmuellert/codediff.nvim'})

-- codediff leaves the filetype unset on the buffers holding older versions of
-- a file, on purpose: setting one makes language servers try to open an
-- address they cannot handle, so it starts the highlighter by hand instead.
-- glimpse keys off the filetype as well, which is why only the working-copy
-- pane showed its diagrams. The plugin does announce each of those buffers
-- once it has the content, and glimpse only needs the text, so hook that.
vim.api.nvim_create_autocmd('User', {
   group = vim.api.nvim_create_augroup('config_codediff', { clear = true }),
   pattern = 'CodeDiffVirtualFileLoaded',
   callback = function(ev)
      local buf = ev.data and ev.data.buf
      if not buf or not vim.api.nvim_buf_is_valid(buf) then
         return
      end
      local glimpse = require('glimpse')
      local name = vim.api.nvim_buf_get_name(buf)
      local ft = vim.filetype.match({ filename = name })
      if not ft or not vim.list_contains(glimpse.config.filetypes, ft) then
         return
      end
      -- The buffer's name is a codediff:// address, so there is no real folder
      -- for a relative image link to start from. Work out the file's actual
      -- folder instead; parse_url handles every way a version can be written
      -- (a hash, a hash with ^, a branch name, :0 for the staged copy).
      local ok, virtual_file = pcall(require, 'codediff.core.virtual_file')
      if ok then
         local root, _, rel = virtual_file.parse_url(name)
         if root and rel then
            vim.b[buf].glimpse_base_dir = vim.fs.dirname(vim.fs.joinpath(root, rel))
         end
      end
      glimpse.attach(buf)
   end,
})

-- Review the current branch: compare the working copy against `git last`, the
-- alias for the point the branch started from, which `git rb` uses too. The
-- alias is run here rather than dropped straight into the command, because
-- :CodeDiff expects a version: if the alias fails (no repository, a branch
-- with no commits yet, $REVIEW_BASE not set) it would hand over an empty
-- argument and quietly compare against HEAD instead.
vim.keymap.set('n', '<leader>gr', function()
   local root = vim.fs.root(0, '.git')
   if not root then
      vim.notify('CodeDiff: not in a git repository', vim.log.levels.WARN)
      return
   end
   local res = vim.system({ 'git', 'last' }, { cwd = root, text = true }):wait()
   local rev = vim.trim(res.stdout or '')
   if res.code ~= 0 or rev == '' then
      vim.notify('git last: ' .. vim.trim(res.stderr or 'no revision'), vim.log.levels.ERROR)
      return
   end
   vim.cmd('CodeDiff ' .. rev)
end, { desc = 'Review branch (codediff vs git last)' })
