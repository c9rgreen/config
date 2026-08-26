# Circadia Forest Dark (Obsidian Pine)
# From the Circadia palette spec: https://github.com/tanmaymanojgandhi/circadia
# (ports/tmux/circadia-dark-forest.tmux), recolored onto the status-line layout in
# ../tmux.conf. Source after tmux.conf to pin the Circadia palette instead of
# tracking the active terminal theme.

# The bar sits on bg_surface; the pills carry the accent per the official port
set -g status-style "bg=#1a1e1b,fg=#c4ccc5"

set -g status-left "#[bg=#83b384,fg=#131714,bold]  #S #[bg=#1a1e1b,fg=#83b384] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#92b87e]●\":\"#[fg=#838d85]○\";printf \"%%s#[fg=#838d85] %%dh%%02dm\",dot,h,m}') #[fg=#b29ace] #(whoami)#[fg=#838d85]@#[fg=#d19b66]#h #[fg=#d19b66,bg=#1a1e1b]  %b %d #[bg=#83b384,fg=#131714,bold]  %H:%M "

set -g window-status-format "#[fg=#9fa9a1,bg=#1a1e1b]  #I:#W "
set -g window-status-current-format "#[fg=#83b384,bg=#242a25,bold]  #I:#W "

set -g pane-border-style "fg=#353c36"
set -g pane-active-border-style "fg=#83b384"

set -g message-style "bg=#242a25,fg=#c4ccc5,bold"
set -g message-command-style "bg=#242a25,fg=#c4ccc5"

set -g mode-style "bg=#242a25,fg=#83b384,bold"

set -g clock-mode-colour "#83b384"
