-- fileref — fuzzy-pick a file and insert its path at the cursor as `@path`,
-- for referencing files in Claude Code prompts edited via $EDITOR. Paths are
-- relative to Neovim's cwd, matching what Claude Code expects for @ refs.

local M = {}

function M.insert()
   local buf = vim.api.nvim_get_current_buf()
   -- Capture the insertion point before stopinsert shifts the cursor left.
   local row, col = unpack(vim.api.nvim_win_get_cursor(0))
   local was_insert = vim.fn.mode():find('^i') ~= nil
   if was_insert then
      vim.cmd('stopinsert')
   end

   -- Insert text at the captured point and restore mode and cursor. Deferred
   -- so the picker window is closed and the target window is current again
   -- before we touch the buffer and mode.
   local function insert_text(text)
      vim.schedule(function()
         vim.api.nvim_buf_set_text(buf, row - 1, col, row - 1, col, { text })
         local win = vim.fn.bufwinid(buf)
         if win == -1 then
            return
         end
         local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, true)[1]
         if not was_insert then
            vim.api.nvim_win_set_cursor(win, { row, col + #text - 1 })
         elseif col + #text >= #line then
            vim.api.nvim_win_set_cursor(win, { row, #line })
            vim.cmd('startinsert!')
         else
            vim.api.nvim_win_set_cursor(win, { row, col + #text })
            vim.cmd('startinsert')
         end
      end)
   end

   local chosen = MiniPick.builtin.files(nil, {
      source = {
         name = 'Insert @file',
         choose = function(item)
            insert_text('@' .. item)
         end,
      },
   })
   -- Aborting the picker types the literal `@` that triggered it.
   if chosen == nil then
      insert_text('@')
   end
end

return M
