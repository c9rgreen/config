-- gitbrowse — open the current file on its git host's website.
--
-- Opens the file on the branch you are on, or at the commit hash when there is
-- no branch. Selecting lines first, or giving the command a line range, links
-- to those lines. SSH remote addresses are turned into https ones. GitHub,
-- GitLab, Bitbucket and sourcehut link formats are all known; anything else is
-- given the GitHub format.

local M = {}

local function git(cwd, ...)
   local res = vim.system({ 'git', ... }, { cwd = cwd, text = true }):wait()
   if res.code ~= 0 then
      return nil
   end
   return vim.trim(res.stdout)
end

-- Turn an SSH remote address into an https one, dropping any .git ending.
local function remote_to_url(remote)
   remote = remote:gsub('%.git$', '')
   local host, path = remote:match('^git@([^:]+):(.+)$')
   if not host then
      host, path = remote:match('^ssh://git@([^:/]+)[^/]*/(.+)$')
   end
   if host then
      return 'https://' .. host .. '/' .. path
   end
   if remote:match('^https?://') then
      return remote
   end
end

-- Escape any character that cannot appear in a URL; '/' is left alone.
local function encode(s)
   return (s:gsub('[^%w/%-._~]', function(c)
      return ('%%%02X'):format(c:byte())
   end))
end

-- Link formats per host. The first entry whose `host` pattern matches wins, so
-- the GitHub format -- which gitea and forgejo use too -- sits last and
-- catches everything else.
local HOSTS = {
   { host = 'bitbucket%.', file = '/src/%s/%s', line = '#lines-%d', range = '#lines-%d:%d' },
   { host = 'git%.sr%.ht', file = '/tree/%s/item/%s', line = '#L%d', range = '#L%d' },
   { host = 'gitlab%.', file = '/-/blob/%s/%s', line = '#L%d', range = '#L%d-%d' },
   { host = '', file = '/blob/%s/%s', line = '#L%d', range = '#L%d-L%d' },
}

local function host_spec(base)
   local host = base:match('^https?://([^/]+)') or ''
   for _, spec in ipairs(HOSTS) do
      if host:find(spec.host) then
         return spec
      end
   end
end

--- opts.line_start/line_end are used instead of the lines currently selected.
function M.open(opts)
   opts = opts or {}
   if not opts.line_start and vim.fn.mode():match('^[vV\022]') then
      opts.line_start = vim.fn.line('v')
      opts.line_end = vim.fn.line('.')
      vim.api.nvim_feedkeys(vim.keycode('<esc>'), 'n', false)
   end

   local file = vim.api.nvim_buf_get_name(0)
   local cwd = file ~= '' and vim.fs.dirname(file) or vim.fn.getcwd()
   local root = git(cwd, 'rev-parse', '--show-toplevel')
   if not root then
      return vim.notify('gitbrowse: not a git repository', vim.log.levels.ERROR)
   end

   local remote = git(cwd, 'remote', 'get-url', 'origin')
   if not remote then
      local first = (git(cwd, 'remote') or ''):match('[^\n]+')
      remote = first and git(cwd, 'remote', 'get-url', first)
   end
   if not remote then
      return vim.notify('gitbrowse: no git remote found', vim.log.levels.ERROR)
   end
   local base = remote_to_url(remote)
   if not base then
      return vim.notify('gitbrowse: unsupported remote url: ' .. remote, vim.log.levels.ERROR)
   end

   local ref = git(cwd, 'rev-parse', '--abbrev-ref', 'HEAD')
   if not ref or ref == 'HEAD' then
      ref = git(cwd, 'rev-parse', 'HEAD')
   end

   -- Files git does not track, and buffers with no file at all, link to the
   -- repository's main page instead.
   local relpath = file ~= '' and vim.fs.relpath(root, file) or nil
   if relpath and not git(cwd, 'ls-files', '--error-unmatch', file) then
      relpath = nil
   end

   local url = base
   if relpath and ref then
      local spec = host_spec(base)
      url = base .. spec.file:format(encode(ref), encode(relpath))
      if opts.line_start then
         local s, e = opts.line_start, opts.line_end or opts.line_start
         if s > e then
            s, e = e, s
         end
         url = url .. (e > s and spec.range:format(s, e) or spec.line:format(s))
      end
   end

   vim.notify('gitbrowse: ' .. url)
   vim.ui.open(url)
end

return M
