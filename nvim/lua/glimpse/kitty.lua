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

-- Escape sequences reach the terminal through the stderr channel, which the
-- TUI passes through untouched.
local function write(data)
   pcall(vim.fn.chansend, vim.v.stderr, data)
end

-- Returns ok, reason. Zellij passes TERM through and shows the images itself,
-- so it needs no special case here.
function M.supported()
   if vim.env.TMUX then
      -- tmux swallows these commands unless they are wrapped in its own
      -- passthrough escape, which this file does not do. Turning on
      -- `allow-passthrough` is not enough by itself; the wrapper has to be
      -- there.
      return false, 'tmux needs DCS-wrapped graphics escapes'
   end
   local term = vim.env.TERM or ''
   if vim.env.KITTY_WINDOW_ID
      or term:find('ghostty', 1, true) ~= nil
      or term:find('kitty', 1, true) ~= nil
      or vim.env.TERM_PROGRAM == 'ghostty'
   then
      return true
   end
   return false, 'no kitty graphics protocol detected (TERM=' .. term .. ')'
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
      out[#out + 1] = string.format(
         '%s_G%sm=%d;%s%s\\',
         ESC, pos == 1 and ctrl or '', m, payload:sub(pos, pos + 4095), ESC
      )
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
-- sequences around the command put it back where Neovim thinks it is.
function M.put(id, pid, row, col, rows, cols, src)
   local keys = string.format('a=p,q=2,i=%d,p=%d,r=%d,c=%d,z=0,C=1', id, pid, rows, cols)
   if src then
      keys = keys .. string.format(',x=0,y=%d,w=%d,h=%d', src.y, src.w, src.h)
   end
   write(table.concat({
      ESC, '7',
      string.format('%s[%d;%dH', ESC, row, col),
      ESC, '_G', keys, ESC, '\\',
      ESC, '8',
   }))
end

-- Remove one on-screen copy but keep the image data, so it can be shown
-- again without sending it over.
function M.unput(id, pid)
   write(string.format('%s_Ga=d,d=i,i=%d,p=%d,q=2%s\\', ESC, id, pid, ESC))
end

-- Free an image and every on-screen copy of it.
function M.delete(id)
   write(string.format('%s_Ga=d,d=I,i=%d,q=2%s\\', ESC, id, ESC))
end

return M
