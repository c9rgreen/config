-- difftool: git revision diffing on top of the built-in nvim.difftool plugin:
--   :Compare        diff working tree against HEAD
--   :Compare <rev>  diff working tree against <rev>
--
-- The revision is materialized as a directory via git-archive, and the working
-- tree as a farm of symlinks to the real files. difftool resolves symlinks
-- before editing, so working-tree buffers are the actual files and stay
-- editable. The working tree always appears on the right.
if vim.g.loaded_compare then
   return
end
vim.g.loaded_compare = true

local function git(args, cwd)
   local res = vim.system(vim.list_extend({ 'git' }, args), { text = true, cwd = cwd }):wait()
   if res.code ~= 0 then
      return nil, vim.trim(res.stderr or '')
   end
   return res.stdout or ''
end

local function fail(msg)
   vim.notify(msg, vim.log.levels.ERROR)
end

-- tempname() directories are cleaned up by Neovim on exit
local function tempdir()
   local dir = vim.fn.tempname()
   vim.fn.mkdir(dir, 'p')
   return dir
end

--- Extract the tree of `rev` into a directory.
local function rev_tree(root, rev)
   -- bsdtar extracts an empty stream without complaint, so a bad revision
   -- would silently yield an empty tree; verify it up front instead
   if not git({ 'rev-parse', '--verify', '--quiet', rev .. '^{commit}' }, root) then
      return nil, 'cannot resolve ' .. rev
   end
   local dir = tempdir()
   local script = 'git archive --format=tar "$1" | tar -xf - -C "$0"'
   local res = vim.system({ 'sh', '-c', script, dir, rev }, { text = true, cwd = root }):wait()
   if res.code ~= 0 then
      return nil, ('extracting %s failed: %s'):format(rev, vim.trim(res.stderr or ''))
   end
   return dir
end

--- Mirror the working tree (tracked plus untracked files) into a directory of
--- symlinks to the real files. Files deleted from the working tree yield
--- dangling links, which difftool reports as D.
local function worktree_dir(root)
   local out, err = git({ 'ls-files', '-z', '--cached', '--others', '--exclude-standard' }, root)
   if not out then
      return nil, 'listing working tree failed: ' .. err
   end
   local dir = tempdir()
   for _, file in ipairs(vim.split(out, '\0', { trimempty = true })) do
      local link = vim.fs.joinpath(dir, file)
      vim.fn.mkdir(vim.fs.dirname(link), 'p')
      vim.uv.fs_symlink(vim.fs.joinpath(root, file), link)
   end
   return dir
end

local function complete(arg_lead)
   local out = git({ 'for-each-ref', '--format=%(refname:short)' })
   local refs = out and vim.split(out, '\n', { trimempty = true }) or {}
   table.insert(refs, 1, 'HEAD')
   return vim.tbl_filter(function(ref) return vim.startswith(ref, arg_lead) end, refs)
end

vim.api.nvim_create_user_command('Compare', function(cmd)
   local root = git({ 'rev-parse', '--show-toplevel' })
   root = root and vim.trim(root)
   if not root or root == '' then
      return fail('not in a git repository')
   end

   local left, lerr = rev_tree(root, cmd.fargs[1] or 'HEAD')
   if not left then
      return fail(lerr)
   end
   local right, rerr = worktree_dir(root)
   if not right then
      return fail(rerr)
   end
   require('difftool').open(left, right)
end, {
   nargs = '?',
   complete = complete,
   desc = 'Diff the working tree (right) against a git revision (left, default HEAD)',
})
