# Monokai Pro
# From Monokai Pro (https://monokai.pro/), via loctvl842/monokai-pro.nvim:
#   https://github.com/loctvl842/monokai-pro.nvim
# Recolored onto the status-line layout in ../tmux.conf. Source after
# tmux.conf to pin the Monokai palette instead of tracking the active
# terminal theme. Hexes match Ghostty's bundled "Monokai Pro" theme.
#
# The bar sits on the UI tier (dimmed5, what upstream paints floats and
# the popup menu with). Yellow is Monokai's active-tab and find-match hue,
# so it carries the pills and the active pane border; the current window
# opens back onto the pane background in yellow, like upstream's active tab.
set -g status-style "bg=#403e41,fg=#fcfcfa"

set -g status-left "#[bg=#ffd866,fg=#2d2a2e,bold]  #S #[bg=#403e41,fg=#ffd866] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#a9dc76]●\":\"#[fg=#939293]○\";printf \"%%s#[fg=#939293] %%dh%%02dm\",dot,h,m}') #[fg=#ab9df2] #(whoami)#[fg=#939293]@#[fg=#78dce8]#h #[fg=#78dce8,bg=#403e41]  %b %d #[bg=#ffd866,fg=#2d2a2e,bold]  %H:%M "

set -g window-status-format "#[fg=#939293,bg=#403e41]  #I:#W "
set -g window-status-current-format "#[fg=#ffd866,bg=#2d2a2e,bold]  #I:#W "

set -g pane-border-style "fg=#403e41"
set -g pane-active-border-style "fg=#ffd866"

set -g message-style "bg=#403e41,fg=#fcfcfa,bold"
set -g message-command-style "bg=#403e41,fg=#fcfcfa"

# Selection is Ghostty's selection-background (dimmed4)
set -g mode-style "bg=#5b595c,fg=#fcfcfa"

set -g clock-mode-colour "#ffd866"
