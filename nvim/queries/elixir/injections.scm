; extends
;
; Without the modeline above, this file would replace nvim-treesitter's own
; elixir injections rather than adding to them: the config directory comes
; first in the runtimepath, so its copy of a query wins outright. "extends"
; appends these patterns to the ones already found instead, keeping the
; markdown-in-@doc, ~r regex and ~H HEEx injections that ship with the parser.

; Hologram templates (https://hologram.page). ~HOLO holds markup in
; Hologram's own template syntax: HTML plus {expr} interpolation in both
; body and attribute position, {%if}/{%else}/{/if} and {%for}/{/for} blocks,
; and $-prefixed event attributes like $click.
;
; There is no tree-sitter grammar for that dialect, so this borrows heex,
; which is the closest fit: it already models {expr} the same way, and it
; parses every template in the nsl project with no errors, where the plain
; html grammar reports several. The block tags are the one gap -- heex reads
; {%if @x} as an interpolated expression and hands "%if @x" to the elixir
; parser, which cannot parse it -- so the braces and the condition inside
; still highlight, but the %if/%for keywords themselves do not.
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
  (#eq? @_sigil_name "HOLO")
  (#set! injection.language "heex"))
