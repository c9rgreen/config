-- Kitty graphics protocol backend, placing images on screen itself.
--
-- An image is sent to the terminal once under a numeric id (a=t) and then
-- shown on screen (a=p) as many times as needed. Each on-screen copy lands
-- wherever the cursor is when the command arrives, and the terminal does not
-- keep it stuck to the text underneath, so it is up to Neovim to work out the
-- position again after every redraw.
--
-- The older approach (U=1) marked cells with a special character and let the
-- terminal do the tracking. Zellij refuses that outright -- it answers
-- `ENOTSUPPORTED:unicode placeholders are not supported` -- but does accept
-- sending, showing and deleting images, so the tracking moved in here.

local M = {}

local ESC = '\27'

M.in_tmux = (vim.env.TMUX or '') ~= ''

-- Runs a tmux command and returns its trimmed output, or nil on failure.
local function tmux(...)
   local ok, res = pcall(function(...)
      return vim.system({ 'tmux', ... }, { text = true }):wait()
   end, ...)
   if not ok or res.code ~= 0 then
      return nil
   end
   return vim.trim(res.stdout or '')
end

-- Expands a tmux format for this Neovim's pane.
local function pane_format(fmt)
   if vim.env.TMUX_PANE then
      return tmux('display-message', '-p', '-t', vim.env.TMUX_PANE, fmt)
   end
   return tmux('display-message', '-p', fmt)
end

-- tmux drops graphics escapes unless they come in its passthrough wrapper,
-- with every ESC inside doubled.
local function wrap(seq)
   if not M.in_tmux then
      return seq
   end
   return ESC .. 'Ptmux;' .. (seq:gsub(ESC, ESC .. ESC)) .. ESC .. '\\'
end

-- Escape sequences reach the terminal through the stderr channel, which the
-- TUI passes through untouched.
local function write(data)
   pcall(vim.fn.chansend, vim.v.stderr, data)
end

-- Inside tmux, panes see TERM_PROGRAM=tmux. The outer terminal's value is
-- in the session environment when tmux.conf lists it in update-environment.
local function outer_env(name)
   if not M.in_tmux then
      return vim.env[name] or ''
   end
   local line = tmux('show-environment', name)
   return line and line:match('^[^=]+=(.*)$') or ''
end

-- Returns ok, reason. Zellij passes TERM through and shows the images itself,
-- so it needs no special case here.
local support
function M.supported()
   if support then
      return support[1], support[2]
   end
   local term, program = outer_env('TERM'), outer_env('TERM_PROGRAM')
   if vim.env.KITTY_WINDOW_ID
      or term:find('ghostty', 1, true) ~= nil
      or term:find('kitty', 1, true) ~= nil
      or program == 'ghostty'
   then
      support = { true }
      -- `all` lets deletes through after the pane is hidden, so images
      -- don't linger over another tmux window.
      if M.in_tmux and vim.env.TMUX_PANE then
         tmux('set-option', '-p', '-t', vim.env.TMUX_PANE, 'allow-passthrough', 'all')
      end
   else
      support = { false, 'no kitty graphics protocol detected (TERM=' .. term .. ')' }
   end
   return support[1], support[2]
end

-- Restores the pane's inherited allow-passthrough setting.
function M.release()
   if M.in_tmux and support and support[1] and vim.env.TMUX_PANE then
      tmux('set-option', '-p', '-u', '-t', vim.env.TMUX_PANE, 'allow-passthrough')
   end
end

-- Offset of the pane's top-left cell on the terminal screen, as rows and
-- columns. Zero outside tmux. A status line at the top pushes panes down.
local offset
function M.offset(refresh)
   if not M.in_tmux then
      return 0, 0
   end
   if not offset or refresh then
      offset = { row = 0, col = 0 }
      local out = pane_format('#{pane_top} #{pane_left} #{status} #{status-position}') or ''
      local top, left, status, pos = out:match('^(%d+) (%d+) (%S+) (%S+)$')
      if top then
         local lines = status == 'on' and 1 or tonumber(status) or 0
         offset = { row = tonumber(top) + (pos == 'top' and lines or 0), col = tonumber(left) }
      end
   end
   return offset.row, offset.col
end

-- Whether the pane is on screen. tmux doesn't know about images, so they stay
-- up after a switch to another window or session, or a zoom of another pane.
function M.visible()
   if not M.in_tmux then
      return true
   end
   local out = pane_format('#{session_attached} #{window_active} #{pane_active} #{window_zoomed_flag}')
   local attached, win, pane, zoomed = (out or ''):match('^(%d+) (%d) (%d) (%d)$')
   if not attached then
      return true
   end
   return attached ~= '0' and win == '1' and (zoomed == '0' or pane == '1')
end

-- Terminal cell size in pixels, used to map image pixels onto a rows×columns
-- box. TIOCGWINSZ reports the terminal's pixel dimensions next to its grid.
local cell, winsize_cdef
function M.cell_size(refresh)
   if cell and not refresh then
      return cell.w, cell.h
   end
   cell = { w = 9, h = 19 } -- rough guess if the ioctl is unavailable
   pcall(function()
      local ffi = require('ffi')
      if not winsize_cdef then
         ffi.cdef([[
            struct glimpse_winsize { unsigned short row, col, xpixel, ypixel; };
            int ioctl(int fd, unsigned long request, ...);
         ]])
         winsize_cdef = true
      end
      local TIOCGWINSZ = jit.os == 'OSX' and 0x40087468 or 0x5413
      local ws = ffi.new('struct glimpse_winsize')
      if ffi.C.ioctl(1, TIOCGWINSZ, ws) == 0 and ws.xpixel > 0 and ws.ypixel > 0 then
         cell = { w = ws.xpixel / ws.col, h = ws.ypixel / ws.row }
      end
   end)
   return cell.w, cell.h
end

-- Send an image's data under `id` without showing it. The protocol wants
-- base64 in chunks of at most 4096 bytes, and q=2 asks the terminal not to
-- reply (there is no way to read a reply from in here). No size is included,
-- so one send covers every size it is shown at, and resizing a window does
-- not mean sending the pixels again.
function M.transmit(id, png_path)
   local f = io.open(png_path, 'rb')
   if not f then
      return false
   end
   local payload = vim.base64.encode(f:read('*a'))
   f:close()
   if payload == '' then
      return false
   end
   local ctrl = string.format('a=t,q=2,f=100,t=d,i=%d,', id)
   local out = {}
   for pos = 1, #payload, 4096 do
      local m = (pos + 4096 <= #payload) and 1 or 0
      -- Each chunk is wrapped on its own, since tmux caps one escape's length.
      out[#out + 1] = wrap(string.format(
         '%s_G%sm=%d;%s%s\\',
         ESC, pos == 1 and ctrl or '', m, payload:sub(pos, pos + 4095), ESC
      ))
   end
   write(table.concat(out))
   return true
end

-- Show image `id` as on-screen copy `pid`, its top-left corner at cell
-- (row, col), covering rows×cols cells. `src`, when given, picks out part of
-- the image in pixels: that is how a block hanging off the top or bottom of a
-- window gets cut down, since the terminal will not do that for us.
--
-- C=1 keeps the terminal from moving the cursor, and the save and restore
-- sequences around the command put it back where Neovim thinks it is. In
-- tmux they go inside the wrapper, so they move the real terminal's cursor.
function M.put(id, pid, row, col, rows, cols, src)
   local keys = string.format('a=p,q=2,i=%d,p=%d,r=%d,c=%d,z=0,C=1', id, pid, rows, cols)
   if src then
      keys = keys .. string.format(',x=0,y=%d,w=%d,h=%d', src.y, src.w, src.h)
   end
   local dr, dc = M.offset()
   write(wrap(table.concat({
      ESC, '7',
      string.format('%s[%d;%dH', ESC, row + dr, col + dc),
      ESC, '_G', keys, ESC, '\\',
      ESC, '8',
   })))
end

-- Remove one on-screen copy but keep the image data, so it can be shown
-- again without sending it over.
function M.unput(id, pid)
   write(wrap(string.format('%s_Ga=d,d=i,i=%d,p=%d,q=2%s\\', ESC, id, pid, ESC)))
end

-- Free an image and every on-screen copy of it.
function M.delete(id)
   write(wrap(string.format('%s_Ga=d,d=I,i=%d,q=2%s\\', ESC, id, ESC)))
end

return M
