-- zen — distraction-free writing mode for markdown buffers.
--
-- Floats the current buffer in a centered column over a backdrop that hides
-- the rest of the editor, drops the window chrome (numbers, signs, folds,
-- statusline, tabline), and turns on soft wrap and spell. Toggling again or
-- closing the float (:q) restores everything, syncing the cursor back to the
-- original window. Column width comes from vim.g.zen_width, falling back to
-- the buffer's 'textwidth' and then 80.

local M = {}

local state -- { main, backdrop, prev_win, laststatus, showtabline, augroup }

local function editor_size()
   return vim.o.columns, vim.o.lines - vim.o.cmdheight
end

local function main_config(buf)
   local cols, lines = editor_size()
   local tw = vim.bo[buf].textwidth
   local width = vim.g.zen_width or (tw > 0 and tw + 2) or 80
   width = math.min(width, cols - 2)
   local height = math.max(lines - 2, 1)
   return {
      relative = 'editor',
      width = width,
      height = height,
      col = math.floor((cols - width) / 2),
      row = math.floor((lines - height) / 2),
      border = 'none',
      zindex = 40,
   }
end

-- Move the cursor back to the window the buffer came from, so leaving zen
-- mode doesn't lose the position gained while writing.
local function sync_cursor(s)
   if
      vim.api.nvim_win_is_valid(s.main)
      and vim.api.nvim_win_is_valid(s.prev_win)
      and vim.api.nvim_win_get_buf(s.prev_win) == vim.api.nvim_win_get_buf(s.main)
   then
      vim.api.nvim_win_set_cursor(s.prev_win, vim.api.nvim_win_get_cursor(s.main))
   end
end

function M.open()
   if state then
      return
   end
   if vim.bo.filetype ~= 'markdown' then
      return vim.notify('zen: not a markdown buffer', vim.log.levels.ERROR)
   end

   local buf = vim.api.nvim_get_current_buf()
   local prev_win = vim.api.nvim_get_current_win()

   local backdrop_buf = vim.api.nvim_create_buf(false, true)
   vim.bo[backdrop_buf].bufhidden = 'wipe'
   local cols, lines = editor_size()
   local backdrop = vim.api.nvim_open_win(backdrop_buf, false, {
      relative = 'editor',
      row = 0,
      col = 0,
      width = cols,
      height = lines,
      style = 'minimal',
      focusable = false,
      border = 'none',
      zindex = 30,
   })
   vim.wo[backdrop].winhighlight = 'NormalFloat:Normal'

   local main = vim.api.nvim_open_win(buf, true, main_config(buf))
   local wo = vim.wo[main]
   wo.winhighlight = 'NormalFloat:Normal'
   wo.number = false
   wo.relativenumber = false
   wo.signcolumn = 'no'
   wo.statuscolumn = ''
   wo.foldcolumn = '0'
   wo.colorcolumn = ''
   wo.cursorline = false
   wo.winbar = ''
   wo.fillchars = 'eob: '
   wo.wrap = true
   wo.linebreak = true
   wo.breakindent = true
   wo.spell = true

   state = {
      main = main,
      backdrop = backdrop,
      prev_win = prev_win,
      laststatus = vim.o.laststatus,
      showtabline = vim.o.showtabline,
      augroup = vim.api.nvim_create_augroup('zen', { clear = true }),
   }
   vim.o.laststatus = 0
   vim.o.showtabline = 0

   vim.api.nvim_create_autocmd('WinClosed', {
      group = state.augroup,
      pattern = tostring(main),
      callback = function()
         M.close()
      end,
   })
   vim.api.nvim_create_autocmd('VimResized', {
      group = state.augroup,
      callback = function()
         local c, l = editor_size()
         vim.api.nvim_win_set_config(state.backdrop, { relative = 'editor', row = 0, col = 0, width = c, height = l })
         vim.api.nvim_win_set_config(state.main, main_config(vim.api.nvim_win_get_buf(state.main)))
      end,
   })
end

function M.close()
   if not state then
      return
   end
   local s = state
   state = nil
   vim.api.nvim_del_augroup_by_id(s.augroup)
   pcall(sync_cursor, s)
   vim.o.laststatus = s.laststatus
   vim.o.showtabline = s.showtabline
   -- Deferred so cleanup is safe when triggered from the WinClosed autocmd.
   vim.schedule(function()
      for _, win in ipairs({ s.main, s.backdrop }) do
         if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
         end
      end
      if vim.api.nvim_win_is_valid(s.prev_win) then
         vim.api.nvim_set_current_win(s.prev_win)
      end
   end)
end

function M.toggle()
   if state then
      M.close()
   else
      M.open()
   end
end

return M
