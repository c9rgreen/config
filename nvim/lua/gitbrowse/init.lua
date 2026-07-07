-- gitbrowse — open the current file on its git host's web UI.
--
-- Opens the file at the current branch (or commit hash when detached).
-- Visual mode and command ranges add a line fragment. SSH and scp-style
-- remotes are rewritten to https; GitHub, GitLab, Bitbucket, and sourcehut
-- URL shapes are recognized, anything else gets the GitHub shape.

local M = {}

local function git(cwd, ...)
   local res = vim.system({ 'git', ... }, { cwd = cwd, text = true }):wait()
   if res.code ~= 0 then
      return nil
   end
   return vim.trim(res.stdout)
end

-- Rewrite an ssh/scp-style remote to an https URL, dropping the .git suffix.
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

-- Percent-encode everything a path segment can't carry ('/' stays).
local function encode(s)
   return (s:gsub('[^%w/%-._~]', function(c)
      return ('%%%02X'):format(c:byte())
   end))
end

-- Per-host URL shapes; the first `host` pattern matching wins, so the
-- GitHub shape (also used by gitea/forgejo) is the catch-all.
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

--- opts.line_start/line_end override the range taken from visual mode.
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

   -- Untracked files (and no-file buffers) fall back to the repo page.
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
