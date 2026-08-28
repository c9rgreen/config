-- nvim-treesitter's yaml indentexpr indents gq-wrapped continuation lines as
-- if they belonged to the enclosing block, which mangles wrapped comments.
-- Route gq through a formatexpr that formats with indentexpr (and itself,
-- since gq re-evaluates formatexpr) disabled, so continuation lines take the
-- first line's indent via autoindent.
function _G.yaml_gq_format()
  -- Insert-mode wrapping is fine as-is; let the internal formatter handle it.
  if vim.fn.mode():find('[iR]') then
    return 1
  end
  local indentexpr, formatexpr = vim.bo.indentexpr, vim.bo.formatexpr
  vim.bo.indentexpr, vim.bo.formatexpr = '', ''
  local ok = pcall(
    vim.cmd,
    ('silent keepjumps normal! %dGgq%dG'):format(vim.v.lnum, vim.v.lnum + vim.v.count - 1)
  )
  vim.bo.indentexpr, vim.bo.formatexpr = indentexpr, formatexpr
  return ok and 0 or 1
end

vim.bo.formatexpr = 'v:lua.yaml_gq_format()'
