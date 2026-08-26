# Circadia Dark (Warm Ember)
# From the Circadia palette spec: https://github.com/tanmaymanojgandhi/circadia
# (ports/tmux/circadia-dark.tmux), recolored onto the status-line layout in
# ../tmux.conf. Source after tmux.conf to pin the Circadia palette instead of
# tracking the active terminal theme.

# The bar sits on bg_surface; the pills carry the accent per the official port
set -g status-style "bg=#1e1a15,fg=#c9c0b1"

set -g status-left "#[bg=#e89a49,fg=#17130f,bold]  #S #[bg=#1e1a15,fg=#e89a49] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#8cbb62]●\":\"#[fg=#91887d]○\";printf \"%%s#[fg=#91887d] %%dh%%02dm\",dot,h,m}') #[fg=#b991db] #(whoami)#[fg=#91887d]@#[fg=#d99148]#h #[fg=#d99148,bg=#1e1a15]  %b %d #[bg=#e89a49,fg=#17130f,bold]  %H:%M "

set -g window-status-format "#[fg=#aba195,bg=#1e1a15]  #I:#W "
set -g window-status-current-format "#[fg=#e89a49,bg=#29241e,bold]  #I:#W "

set -g pane-border-style "fg=#3b342b"
set -g pane-active-border-style "fg=#e89a49"

set -g message-style "bg=#29241e,fg=#c9c0b1,bold"
set -g message-command-style "bg=#29241e,fg=#c9c0b1"

set -g mode-style "bg=#29241e,fg=#e89a49,bold"

set -g clock-mode-colour "#e89a49"
