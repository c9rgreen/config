-- Org: org-lsp (replaces nvim-orgmode; binds the same default keys)

-- Re-download the server binary whenever vim.pack updates the plugin.
-- Must be registered before vim.pack.add().
vim.api.nvim_create_autocmd('PackChanged', {
   callback = function(ev)
      if ev.data.spec.name == 'org-lsp' and ev.data.kind == 'update' then
         vim.cmd('OrgLspDownload')
      end
   end,
})

vim.g.org_lsp = {
   settings = {
      org_agenda_files = { '~/Desktop/Org/**/*' },
      org_default_notes_file = '~/Desktop/Org/refile.org',
   },
}

vim.pack.add({'https://github.com/kristijanhusak/org-lsp'})
