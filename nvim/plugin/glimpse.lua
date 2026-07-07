-- glimpse: inline images and mermaid diagrams (implementation in lua/glimpse/)
if vim.g.loaded_glimpse then
   return
end
vim.g.loaded_glimpse = true

require('glimpse').setup()
