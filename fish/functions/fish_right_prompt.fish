function fish_right_prompt --description 'Time tracked today (timewarrior)'
    type -q timew; or return

    # 1 when an interval is currently running, 0 otherwise
    set -l active (timew get dom.active 2>/dev/null)

    # `timew day` footer: "Tracked   8:10:04" (includes the running interval)
    set -l tracked (timew day 2>/dev/null | string match -rg 'Tracked\s+([0-9:]+)')
    set -l h 0
    set -l m 0
    if test -n "$tracked"
        set -l parts (string split ':' -- $tracked)
        # math strips leading zeros so printf doesn't read e.g. "08" as octal
        set h (math $parts[1])
        set m (math $parts[2])
    end

    # Filled green dot while tracking, dim hollow dot when stopped
    if test "$active" = 1
        set_color green
        printf '●'
    else
        set_color brblack
        printf '○'
    end

    set_color brblack
    printf ' %dh%02dm' $h $m
    set_color normal
end
