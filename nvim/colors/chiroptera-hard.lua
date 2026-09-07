-- chiroptera-hard -- a mini.base16 port of Chiroptera, Dawid Kurek's
-- LAB-space day/night color system and the Vim colorscheme it generates:
--   https://dawikur.dev/chiroptera/
--   https://github.com/dawikur/chiroptera
-- 'background' picks the wing: chiroptera_light_hard when light,
-- chiroptera_dark_hard when dark. Hard raises the contrast by pushing the
-- background tiers further from the (unchanged) foregrounds. Shared
-- implementation: lua/chiroptera/init.lua.

require('chiroptera').load('hard', 'chiroptera-hard')
