-- chiroptera-soft -- a mini.base16 port of Chiroptera, Dawid Kurek's
-- LAB-space day/night color system and the Vim colorscheme it generates:
--   https://dawikur.dev/chiroptera/
--   https://github.com/dawikur/chiroptera
-- 'background' picks the wing: chiroptera_light_soft when light,
-- chiroptera_dark_soft when dark. Soft lowers the contrast by pulling the
-- background tiers toward the (unchanged) foregrounds. Shared
-- implementation: lua/chiroptera/init.lua.

require('chiroptera').load('soft', 'chiroptera-soft')
