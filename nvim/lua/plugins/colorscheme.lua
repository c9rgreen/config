-- Colorscheme
vim.pack.add({
   'https://github.com/kurund/atomic.nvim'
})

-- mini.pick's current item defaults to CursorLine, which atomic paints with
-- the same color as the picker float's background, hiding the selection.
-- PmenuSel uses a distinct highlight background, so use it instead.
vim.api.nvim_create_autocmd('ColorScheme', {
   group = vim.api.nvim_create_augroup('config_colorscheme', { clear = true }),
   callback = function()
      vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { link = 'PmenuSel' })
      vim.api.nvim_set_hl(0, 'MiniPickPreviewLine',  { link = 'PmenuSel' })

      -- The diagnostic signs are shaded cells (see init.lua): severity is carried
      -- by density, so all four share one hue. Link to DiagnosticSignWarn rather
      -- than hardcoding the yellow, so it follows whatever theme is active.
      for _, severity in ipairs({ 'Error', 'Info', 'Hint' }) do
         vim.api.nvim_set_hl(0, 'DiagnosticSign' .. severity, { link = 'DiagnosticSignWarn' })
      end

      -- The terminal paints the cursor in the same orange atomic gives the match
      -- the cursor is sitting on, so it disappears on every jump. Recolor the
      -- match rather than the cursor: teal is the far side of the wheel from the
      -- cursor's orange, and still distinct from Search's yellow on the matches
      -- the cursor isn't on. Directory is borrowed for its color, not its
      -- meaning -- it carries the theme's teal, so this follows the theme.
      local accent = vim.api.nvim_get_hl(0, { name = 'Directory', link = false })
      local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
      for _, name in ipairs({ 'CurSearch', 'IncSearch', 'Substitute' }) do
         vim.api.nvim_set_hl(0, name, { fg = normal.bg, bg = accent.fg })
      end
   end,
})

vim.cmd.colorscheme('atomic')
