# Chiroptera Light (Normal contrast)
# From Chiroptera, Dawid Kurek's LAB-space day/night color system:
#   https://dawikur.dev/chiroptera/
#   https://github.com/dawikur/chiroptera
# Recolored onto the status-line layout in ../tmux.conf. Source after
# tmux.conf to pin the Chiroptera palette instead of tracking the active
# terminal theme. Hexes match ../../ghostty/themes/chiroptera_light.
#
# The bar sits on the UI tier (bg_bright, what upstream paints status bars,
# tabs and floats with). Blue is Chiroptera's "selected" hue, so it carries
# the pills and the active pane border; the current window opens back onto
# the pane background.
set -g status-style "bg=#c3c1b8,fg=#5d5c5a"

set -g status-left "#[bg=#226569,fg=#dddacf,bold]  #S #[bg=#c3c1b8,fg=#226569] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#5f6000]●\":\"#[fg=#74736f]○\";printf \"%%s#[fg=#74736f] %%dh%%02dm\",dot,h,m}') #[fg=#8f4367] #(whoami)#[fg=#74736f]@#[fg=#0f6952]#h #[fg=#0f6952,bg=#c3c1b8]  %b %d #[bg=#226569,fg=#dddacf,bold]  %H:%M "

set -g window-status-format "#[fg=#74736f,bg=#c3c1b8]  #I:#W "
set -g window-status-current-format "#[fg=#004f52,bg=#dddacf,bold]  #I:#W "

set -g pane-border-style "fg=#c3c1b8"
set -g pane-active-border-style "fg=#226569"

set -g message-style "bg=#c3c1b8,fg=#5d5c5a,bold"
set -g message-command-style "bg=#c3c1b8,fg=#5d5c5a"

# Visual is the dim blue upstream
set -g mode-style "bg=#a5e6e9,fg=#5d5c5a"

set -g clock-mode-colour "#226569"
