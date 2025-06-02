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
  accent = "#300e00",
  accent_bg = "#ffd4be",
  azure = "#003140",
  azure_bg = "#baebff",
  bg = "#F2F3F3",
  bg_edge = "#f6f7f7",
  bg_edge2 = "#fafbfb",
  bg_mid = "#c6c7c7",
  bg_mid2 = "#9b9c9c",
  blue = "#01001e",
  blue_bg = "#c7d7ff",
  cyan = "#003a32",
  cyan_bg = "#bcfff2",
  fg = "#050000",
  fg_edge = "#050000",
  fg_edge2 = "#040000",
  fg_mid = "#35221f",
  fg_mid2 = "#5d4844",
  green = "#0b2100",
  green_bg = "#dbffca",
  orange = "#FF3F00",
  orange_bg = "#ffd4be",
  purple = "#14001c",
  purple_bg = "#f5d6ff",
  red = "#23000d",
  red_bg = "#ffd0df",
  yellow = "#352900",
  yellow_bg = "#ffedba"
]]

--[[
  Dark Palette
  accent = "#ffd4be",
  accent_bg = "#300e00",
  azure = "#baebff",
  azure_bg = "#003140",
  bg = "#050000",
  bg_edge = "#050000",
  bg_edge2 = "#040000",
  bg_mid = "#35221f",
  bg_mid2 = "#5d4844",
  blue = "#c7d7ff",
  blue_bg = "#01001e",
  cyan = "#bcfff2",
  cyan_bg = "#003a32",
  fg = "#F2F3F3",
  fg_edge = "#f6f7f7",
  fg_edge2 = "#fafbfb",
  fg_mid = "#c6c7c7",
  fg_mid2 = "#9b9c9c",
  green = "#dbffca",
  green_bg = "#0b2100",
  orange = "#FF3F00",
  orange_bg = "#300e00",
  purple = "#f5d6ff",
  purple_bg = "#14001c",
  red = "#ffd0df",
  red_bg = "#23000d",
  yellow = "#ffedba",
  yellow_bg = "#352900"
]]
