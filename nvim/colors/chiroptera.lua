-- chiroptera -- a mini.base16 port of Chiroptera, Dawid Kurek's LAB-space
-- day/night color system and the Vim colorscheme it generates:
--   https://dawikur.dev/chiroptera/
--   https://github.com/dawikur/chiroptera
-- 'background' picks the wing: chiroptera_light_normal when light,
-- chiroptera_dark_normal when dark. The -hard and -soft siblings pick the
-- other two contrast levels. The palettes, the role mapping and every
-- highlight group live in lua/chiroptera/init.lua.

require('chiroptera').load('normal', 'chiroptera')
