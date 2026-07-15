function fish_right_prompt --description 'Git branch'
    # Branch from fish_git_prompt with its surrounding parens stripped. Use
    # fish_git_prompt (not fish_vcs_prompt): in a colocated jj+git repo the latter
    # runs fish_jj_prompt first, which succeeds silently and swallows the branch.
    set -l branch (fish_git_prompt 2>/dev/null | string trim | string replace -r '^\(' '' | string replace -r '\)$' '')
    test -n "$branch"; or return

    # Powerline left cap (U+E0B2) in the block color, then the branch segment
    # (U+E0A0 branch glyph + name) as white-on-black -- readable in every theme
    # since ANSI 0/7 are the fg/bg pair. printf expands the \u escapes.
    set_color black
    printf '\ue0b2'
    set_color white --background black
    printf ' \ue0a0 %s ' "$branch"
    set_color normal
end
