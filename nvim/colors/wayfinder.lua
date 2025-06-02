-- Based on the Wayfinder Apple Watch face
-- Author: Christopher Green
-- Credit: Evgeni Chasnovski, Apple

local ok, hues = pcall(require, 'mini.hues')
if not ok then
  vim.notify('mini.hues (https://github.com/echasnovski/mini.hues) not found', vim.log.levels.ERROR)
  return
end

vim.g.colors_name = 'wayfinder'

local function setup()
   -- Clear existing colors
   vim.cmd('highlight clear')
   if vim.fn.exists('syntax_on') then
      vim.cmd('syntax reset')
   end

   -- Light theme
   local light_colors = {
      background = '#F2F3F3',
      foreground = '#050000',
      accent = '#FF3F00'
   }

   -- Dark theme
   local dark_colors = {
      background = '#050000',
      foreground = '#F2F3F3',
      accent = '#FF3F00'
   }

   local is_dark = vim.o.background == 'dark'
   local active_colors = is_dark and dark_colors or light_colors

   local palette = hues.make_palette({
      background = active_colors.background,
      foreground = active_colors.foreground,
      accent = 'orange',
      saturation = 'medium',
      n_hues = 8
   })

   palette.orange = active_colors.accent

   hues.apply_palette(palette)

   vim.api.nvim_set_hl(0, 'Comment', { italic = true })
   vim.api.nvim_set_hl(0, '@comment', { italic = true })  -- For Tree-sitter

   -- print(vim.inspect(palette))
end

setup()

-- TODO: This colorscheme doesn't reload correctly when the background changes
vim.api.nvim_create_autocmd('OptionSet', {
   pattern = 'background',
   callback = function()
      if vim.g.colors_name == 'wayfinder' then
         setup()
         vim.cmd.colorscheme('wayfinder')
      end
   end,
   desc = 'Reload wayfinder colorscheme when background changes'
})

--[[
  Light Palette
  accent = "#5f2a00",
  accent_bg = "#ffbc91",
  azure = "#00506d",
  azure_bg = "#8fdaff",
  bg = "#E6E6E6",
  bg_edge = "#eeeeee",
  bg_edge2 = "#f7f7f7",
  bg_mid = "#bdbdbd",
  bg_mid2 = "#949494",
  blue = "#0d0044",
  blue_bg = "#aab7ff",
  cyan = "#006a63",
  cyan_bg = "#6ffff2",
  fg = "#050000",
  fg_edge = "#050000",
  fg_edge2 = "#040000",
  fg_mid = "#33211e",
  fg_mid2 = "#594441",
  green = "#044100",
  green_bg = "#a6ff9b",
  orange = "#FF3F00",
  orange_bg = "#ffbc91",
  purple = "#36003e",
  purple_bg = "#f9b7ff",
  red = "#4b001c",
  red_bg = "#ffacbf",
  yellow = "#5f5000",
  yellow_bg = "#ffe571"
]]

--[[
  Dark Palette
  accent = "#ffbc91",
  accent_bg = "#5f2a00",
  azure = "#8fdaff",
  azure_bg = "#00506d",
  bg = "#050000",
  bg_edge = "#050000",
  bg_edge2 = "#040000",
  bg_mid = "#33211e",
  bg_mid2 = "#594441",
  blue = "#aab7ff",
  blue_bg = "#0d0044",
  cyan = "#6ffff2",
  cyan_bg = "#006a63",
  fg = "#E6E6E6",
  fg_edge = "#eeeeee",
  fg_edge2 = "#f7f7f7",
  fg_mid = "#bdbdbd",
  fg_mid2 = "#949494",
  green = "#a6ff9b",
  green_bg = "#044100",
  orange = "#FF3F00",
  orange_bg = "#5f2a00",
  purple = "#f9b7ff",
  purple_bg = "#36003e",
  red = "#ffacbf",
  red_bg = "#4b001c",
  yellow = "#ffe571",
  yellow_bg = "#5f5000"
]]
