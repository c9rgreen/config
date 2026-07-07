-- Kitty graphics protocol backend (Unicode placeholder flavor).
--
-- Each image is transmitted once with a numeric id and a virtual placement
-- (U=1). It is then displayed by filling cells with the U+10EEEE placeholder
-- character, whose foreground color encodes the image id and whose combining
-- diacritics encode the row/column within the image. The terminal draws the
-- image over those cells and keeps it attached to them while scrolling, so
-- Neovim never has to reposition anything itself.

local M = {}

-- kitty's rowcolumn-diacritics list, in order: index n encodes row/column n.
local DIACRITICS = vim.split(
   '0305,030D,030E,0310,0312,033D,033E,033F,0346,034A,034B,034C,0350,0351,0352,0357,'
      .. '035B,0363,0364,0365,0366,0367,0368,0369,036A,036B,036C,036D,036E,036F,0483,0484,'
      .. '0485,0486,0487,0592,0593,0594,0595,0597,0598,0599,059C,059D,059E,059F,05A0,05A1,'
      .. '05A8,05A9,05AB,05AC,05AF,05C4,0610,0611,0612,0613,0614,0615,0616,0617,0657,0658,'
      .. '0659,065A,065B,065D,065E,06D6,06D7,06D8,06D9,06DA,06DB,06DC,06DF,06E0,06E1,06E2,'
      .. '06E4,06E7,06E8,06EB,06EC,0730,0732,0733,0735,0736,073A,073D,073F,0740,0741,0743,'
      .. '0745,0747,0749,074A,07EB,07EC,07ED,07EE,07EF,07F0,07F1,07F3,0816,0817,0818,0819,'
      .. '081B,081C,081D,081E,081F,0820,0821,0822,0823,0825,0826,0827,0829,082A,082B,082C,'
      .. '082D,0951,0953,0954,0F82,0F83,0F86,0F87,135D,135E,135F,17DD,193A,1A17,1A75,1A76,'
      .. '1A77,1A78,1A79,1A7A,1A7B,1A7C,1B6B,1B6D,1B6E,1B6F,1B70,1B71,1B72,1B73,1CD0,1CD1,'
      .. '1CD2,1CDA,1CDB,1CE0,1DC0,1DC1,1DC3,1DC4,1DC5,1DC6,1DC7,1DC8,1DC9,1DCB,1DCC,1DD1,'
      .. '1DD2,1DD3,1DD4,1DD5,1DD6,1DD7,1DD8,1DD9,1DDA,1DDB,1DDC,1DDD,1DDE,1DDF,1DE0,1DE1,'
      .. '1DE2,1DE3,1DE4,1DE5,1DE6,1DFE,20D0,20D1,20D4,20D5,20D6,20D7,20DB,20DC,20E1,20E7,'
      .. '20E9,20F0,2CEF,2CF0,2CF1,2DE0,2DE1,2DE2,2DE3,2DE4,2DE5,2DE6,2DE7,2DE8,2DE9,2DEA,'
      .. '2DEB,2DEC,2DED,2DEE,2DEF,2DF0,2DF1,2DF2,2DF3,2DF4,2DF5,2DF6,2DF7,2DF8,2DF9,2DFA,'
      .. '2DFB,2DFC,2DFD,2DFE,2DFF,A66F,A67C,A67D,A6F0,A6F1,A8E0,A8E1,A8E2,A8E3,A8E4,A8E5,'
      .. 'A8E6,A8E7,A8E8,A8E9,A8EA,A8EB,A8EC,A8ED,A8EE,A8EF,A8F0,A8F1,AAB0,AAB2,AAB3,AAB7,'
      .. 'AAB8,AABE,AABF,AAC1,FE20,FE21,FE22,FE23,FE24,FE25,FE26,10A0F,10A38,1D185,1D186,'
      .. '1D187,1D188,1D189,1D1AA,1D1AB,1D1AC,1D1AD,1D242,1D243,1D244',
   ','
)

M.MAX_CELLS = #DIACRITICS

local PLACEHOLDER = vim.fn.nr2char(0x10EEEE)

local dia_chars
local function diacritic(n)
   if not dia_chars then
      dia_chars = {}
      for i, hex in ipairs(DIACRITICS) do
         dia_chars[i] = vim.fn.nr2char(tonumber(hex, 16))
      end
   end
   return dia_chars[n]
end

function M.supported()
   local term = vim.env.TERM or ''
   return vim.env.KITTY_WINDOW_ID ~= nil
      or term:find('ghostty', 1, true) ~= nil
      or term:find('kitty', 1, true) ~= nil
end

-- Escape sequences reach the terminal through the stderr channel, which the
-- TUI passes through untouched.
local function write(data)
   pcall(vim.fn.chansend, vim.v.stderr, data)
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

-- One highlight group per image id; the foreground color *is* the id, which
-- is how placeholder cells reference their image. Groups are re-applied
-- after colorscheme changes wipe them.
local hl_ids = {}
local function ensure_hl(id)
   local group = 'GlimpseImage' .. id
   hl_ids[id] = true
   vim.api.nvim_set_hl(0, group, { fg = id })
   return group
end

function M.apply_highlights()
   for id in pairs(hl_ids) do
      ensure_hl(id)
   end
end

-- virt_lines chunks forming a rows×columns grid of placeholder cells.
function M.placeholder_lines(id, rows, cols)
   local group = ensure_hl(id)
   local lines = {}
   for r = 1, rows do
      local cells = {}
      for c = 1, cols do
         cells[c] = PLACEHOLDER .. diacritic(r) .. diacritic(c)
      end
      lines[r] = { { table.concat(cells), group } }
   end
   return lines
end

-- Transmit a PNG and create its virtual placement scaled to rows×cols.
-- Payload is base64 in ≤4096-byte chunks per the protocol; q=2 suppresses
-- terminal responses (we have no way to read them from inside the TUI).
function M.transmit(id, png_path, rows, cols)
   local f = io.open(png_path, 'rb')
   if not f then
      return false
   end
   local payload = vim.base64.encode(f:read('*a'))
   f:close()
   local ctrl = string.format('a=T,U=1,q=2,f=100,t=d,i=%d,r=%d,c=%d,', id, rows, cols)
   local out = {}
   for pos = 1, #payload, 4096 do
      local m = (pos + 4096 <= #payload) and 1 or 0
      out[#out + 1] = string.format(
         '\27_G%sm=%d;%s\27\\',
         pos == 1 and ctrl or '', m, payload:sub(pos, pos + 4095)
      )
   end
   write(table.concat(out))
   return true
end

-- Free an image (and its placements) in the terminal.
function M.delete(id)
   write(string.format('\27_Ga=d,d=I,i=%d,q=2\27\\', id))
end

return M
