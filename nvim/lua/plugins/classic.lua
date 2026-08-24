-- Vimscript classics: git, database, and editing utilities.
-- vim-flog isn't tpope's, but it renders its commit graph through fugitive, so
-- it lives here to keep the load order (fugitive first) in one place.
vim.pack.add({
   'https://github.com/tpope/vim-fugitive',       -- :Git and the status buffer
   'https://github.com/rbong/vim-flog',           -- :Flog commit graph
   'https://github.com/tpope/vim-dadbod',         -- :DB database queries
   'https://github.com/tpope/vim-endwise',        -- auto-close end/endif/fi
   'https://github.com/tpope/vim-projectionist',  -- :A alternate-file navigation
   'https://github.com/tpope/vim-dispatch',       -- :Make and :Dispatch async builds
})

-- :GBrowse handler for GitLab remotes. fugitive has no forge knowledge of its
-- own: it calls each g:fugitive_browse_handlers entry with the parsed remote,
-- revision, path, and range, and opens the first URL-looking string returned.
-- Declining (nil) leaves other remotes to their own handlers.
local function gitlab_url(opts)
   local remote = opts.remote or ''
   local host, path = remote:match('^git@([^:]+):(.+)$')
   if not host then
      host, path = remote:match('^ssh://git@([^:/]+)[^/]*/(.+)$')
   end
   if not host then
      host, path = remote:match('^https?://([^/]+)/(.+)$')
   end
   if not host or not host:find('gitlab%.') then
      return
   end
   local base = 'https://' .. host .. '/' .. path:gsub('%.git$', '')
   if opts.type == 'commit' then
      return base .. '/-/commit/' .. opts.commit
   end
   -- The repo root and .git internals (index, refs) have no blob to show.
   if opts.path == '' or opts.path:find('^%.git/') then
      return base
   end
   local kind = opts.type == 'tree' and 'tree' or 'blob'
   local url = base .. '/-/' .. kind .. '/' .. opts.commit .. '/' .. opts.path
   if kind == 'blob' and opts.line1 > 0 then
      url = url .. '#L' .. opts.line1 .. (opts.line2 > opts.line1 and '-' .. opts.line2 or '')
   end
   return url
end

vim.g.fugitive_browse_handlers = { gitlab_url }
