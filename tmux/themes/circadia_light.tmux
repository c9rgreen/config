# Circadia Light (Warm Parchment)
# From the Circadia palette spec: https://github.com/tanmaymanojgandhi/circadia
# (ports/tmux/circadia-light.tmux), recolored onto the status-line layout in
# ../tmux.conf. Source after tmux.conf to pin the Circadia palette instead of
# tracking the active terminal theme.

# The bar sits on bg_surface; the pills carry the accent per the official port
set -g status-style "bg=#eee7d6,fg=#28323a"

set -g status-left "#[bg=#0048b3,fg=#f7f2e6,bold]  #S #[bg=#eee7d6,fg=#0048b3] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#005f2f]●\":\"#[fg=#43505c]○\";printf \"%%s#[fg=#43505c] %%dh%%02dm\",dot,h,m}') #[fg=#7a1f7a] #(whoami)#[fg=#43505c]@#[fg=#095b62]#h #[fg=#095b62,bg=#eee7d6]  %b %d #[bg=#0048b3,fg=#f7f2e6,bold]  %H:%M "

set -g window-status-format "#[fg=#46535f,bg=#eee7d6]  #I:#W "
set -g window-status-current-format "#[fg=#0048b3,bg=#e5dcc6,bold]  #I:#W "

set -g pane-border-style "fg=#d7cdb7"
set -g pane-active-border-style "fg=#0048b3"

set -g message-style "bg=#e5dcc6,fg=#28323a,bold"
set -g message-command-style "bg=#e5dcc6,fg=#28323a"

set -g mode-style "bg=#e5dcc6,fg=#0048b3,bold"

set -g clock-mode-colour "#0048b3"
