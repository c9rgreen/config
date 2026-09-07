# Chiroptera for Vim (vendored)

Verbatim copies of the generated Vim colorscheme from Chiroptera, Dawid
Kurek's LAB-space day/night color system (MIT, see LICENSE):

- https://dawikur.dev/chiroptera/
- https://github.com/dawikur/chiroptera (`main`, fetched 2026-09-07)

Files:

- `../chiroptera_dark_normal.vim`, `../chiroptera_light_normal.vim`: the two
  normal-contrast variants. Each builds `g:chiroptera` and then runs
  `runtime colors/chiroptera/{utils,core}.vim`.
- `utils.vim`: the `ChiropteraHL` / `ChiropteraLN` helpers.
- `core.vim`: the highlight groups shared by every variant.

Upstream also ships `plugins/*.vim` for Neovim plugins (cmp, telescope,
tree-sitter, ...). They are left out here since Vim does not load those
plugins; the `runtime! colors/chiroptera/plugins/*.vim` line in each
variant simply matches nothing. Hard and soft contrast variants are
available upstream under the same layout if wanted.

The hexes match ghostty/themes/chiroptera_{dark,light} and
nvim/lua/chiroptera/init.lua.
