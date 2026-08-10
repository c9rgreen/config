-- kubectl.nvim (Kubernetes resource browser)
-- blink.download fetches the plugin's prebuilt Rust binary on first run,
-- so no local cargo build is needed.
vim.pack.add({
   { src = 'https://github.com/ramilito/kubectl.nvim', version = vim.version.range('2.*') },
   'https://github.com/saghen/blink.download',
})

require('kubectl').setup()

vim.keymap.set('n', '<leader>K', function() require('kubectl').toggle() end, { desc = 'Toggle kubectl' })
