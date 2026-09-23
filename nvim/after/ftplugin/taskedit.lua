-- `task edit` files pad every field to a fixed column, so blank values end in
-- spaces that Taskwarrior writes and expects. Keep mini.trailspace from
-- flagging them, and clear any highlight it drew before 'filetype' was set.
vim.b.minitrailspace_disable = true
if _G.MiniTrailspace then
   MiniTrailspace.unhighlight()
end
