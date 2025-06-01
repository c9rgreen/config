-- Based on the Wayfinder Apple Watch face
-- Author: Christopher Green
-- Credit: Evgeni Chasnovski, Apple

local ok, hues = pcall(require, 'mini.hues')
if not ok then
  vim.notify('mini.hues (https://github.com/echasnovski/mini.hues) not found', vim.log.levels.ERROR)
  return
end

-- Clear existing colors
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'wayfinder'
vim.o.background = 'light'

local colors = {
   light = '#E6E6E6',
   dark = '#050000',
   accent = '#FC5401'
}

local palette = hues.make_palette({
   background = colors.light,
   foreground = colors.dark,
   accent = 'orange',
   saturation = 'high',
   n_hues = 8
})

palette.orange = colors.accent

hues.apply_palette(palette)

vim.api.nvim_set_hl(0, 'Comment', { italic = true })
vim.api.nvim_set_hl(0, '@comment', { italic = true })  -- For Tree-sitter

--[[
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
  orange = "#FC5401",
  orange_bg = "#ffbc91",
  purple = "#36003e",
  purple_bg = "#f9b7ff",
  red = "#4b001c",
  red_bg = "#ffacbf",
  yellow = "#5f5000",
  yellow_bg = "#ffe571"
]]
