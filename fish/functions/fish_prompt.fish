function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix (printf '\ue0b0')
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # One-line powerline left prompt. The hostname sits in its own darker segment
    # (`black` on `white`, inverted from the main segment; on a mini theme `white`
    # is the dark color, so this reads darker). A hard divider (U+E0B0) transitions
    # from it into the pwd segment (`white` on `black`), which the suffix then caps.
    # ANSI 0/7 are the fg/bg pair, so text always contrasts; strip the codes
    # prompt_login/prompt_pwd emit and recolor uniformly.
    set -l bg (set_color white --background black)
    set -l host_bg (set_color black --background white)
    set -l cap (set_color black)
    set -l div (printf '\ue0b0')
    set -l login (prompt_login | string replace -r -a -- '\x1b\[[0-9;]*m' '')
    set -l dir (prompt_pwd | string replace -r -a -- '\x1b\[[0-9;]*m' '')
    set -l status_plain (string replace -r -a -- '\x1b\[[0-9;]*m' '' "$prompt_status")

    # Git branch as part of the pwd segment, after a thin divider (U+E0B1) and
    # the branch glyph (U+E0A0). The divider keeps the segment background but
    # its foreground is the terminal's default background color \u2014 no SGR can
    # name that directly, so reset to the default background, set `black` as
    # the foreground, and let reverse video swap the two. Use fish_git_prompt
    # (not fish_vcs_prompt): in a colocated jj+git repo the latter runs
    # fish_jj_prompt first, which succeeds silently and swallows the branch.
    # Strip the surrounding parens it emits.
    set -l branch (fish_git_prompt 2>/dev/null | string trim | string replace -r '^\(' '' | string replace -r '\)$' '')
    set -l branch_seg ''
    if test -n "$branch"
        set branch_seg $normal(set_color --reverse black)(printf '\ue0b1')$normal$bg(printf ' \ue0a0 %s ' "$branch")
    end

    echo -n -s $host_bg ' '"$login"' ' $bg $div ' '"$dir"' '"$branch_seg""$status_plain" $normal $cap $suffix $normal ' '
end
