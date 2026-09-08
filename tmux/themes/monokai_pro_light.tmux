# Monokai Pro Light
# From Monokai Pro (https://monokai.pro/), via loctvl842/monokai-pro.nvim:
#   https://github.com/loctvl842/monokai-pro.nvim
# Recolored onto the status-line layout in ../tmux.conf. Source after
# tmux.conf to pin the Monokai palette instead of tracking the active
# terminal theme. Hexes match Ghostty's bundled "Monokai Pro Light" theme.
#
# The bar sits on the UI tier (dimmed5, what upstream paints floats and
# the popup menu with). Yellow is Monokai's active-tab and find-match hue,
# so it carries the pills and the active pane border; the current window
# opens back onto the pane background in yellow, like upstream's active tab.
set -g status-style "bg=#d3cdcc,fg=#29242a"

set -g status-left "#[bg=#cc7a0a,fg=#29242a,bold]  #S #[bg=#d3cdcc,fg=#cc7a0a] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#269d69]●\":\"#[fg=#918c8e]○\";printf \"%%s#[fg=#918c8e] %%dh%%02dm\",dot,h,m}') #[fg=#7058be] #(whoami)#[fg=#918c8e]@#[fg=#1c8ca8]#h #[fg=#1c8ca8,bg=#d3cdcc]  %b %d #[bg=#cc7a0a,fg=#29242a,bold]  %H:%M "

set -g window-status-format "#[fg=#918c8e,bg=#d3cdcc]  #I:#W "
set -g window-status-current-format "#[fg=#cc7a0a,bg=#faf4f2,bold]  #I:#W "

set -g pane-border-style "fg=#d3cdcc"
set -g pane-active-border-style "fg=#cc7a0a"

set -g message-style "bg=#d3cdcc,fg=#29242a,bold"
set -g message-command-style "bg=#d3cdcc,fg=#29242a"

# Selection is Ghostty's selection-background (dimmed4)
set -g mode-style "bg=#bfb9ba,fg=#29242a"

set -g clock-mode-colour "#cc7a0a"
