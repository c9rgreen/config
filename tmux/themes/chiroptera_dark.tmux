# Chiroptera Dark (Normal contrast)
# From Chiroptera, Dawid Kurek's LAB-space day/night color system:
#   https://dawikur.dev/chiroptera/
#   https://github.com/dawikur/chiroptera
# Recolored onto the status-line layout in ../tmux.conf. Source after
# tmux.conf to pin the Chiroptera palette instead of tracking the active
# terminal theme. Hexes match ../../ghostty/themes/chiroptera_dark.
#
# The bar sits on the UI tier (bg_bright, what upstream paints status bars,
# tabs and floats with). Blue is Chiroptera's "selected" hue, so it carries
# the pills and the active pane border; the current window opens back onto
# the pane background.
set -g status-style "bg=#4c4c4a,fg=#a4a29b"

set -g status-left "#[bg=#6dadaf,fg=#373737,bold]  #S #[bg=#4c4c4a,fg=#6dadaf] "

# Mirrors the timewarrior widget in tmux.conf (see the notes there on the %%
# doubling and fish/sh compatibility) with the palette pinned to hex
set -g status-right "#(timew day 2>/dev/null | awk -v a=\"$(timew get dom.active 2>/dev/null)\" '/Tracked/{split($2,t,\":\");h=t[1]+0;m=t[2]+0;dot=(a==1)?\"#[fg=#a9a72d]●\":\"#[fg=#8b8a84]○\";printf \"%%s#[fg=#8b8a84] %%dh%%02dm\",dot,h,m}') #[fg=#dc89ad] #(whoami)#[fg=#8b8a84]@#[fg=#61b197]#h #[fg=#61b197,bg=#4c4c4a]  %b %d #[bg=#6dadaf,fg=#373737,bold]  %H:%M "

set -g window-status-format "#[fg=#8b8a84,bg=#4c4c4a]  #I:#W "
set -g window-status-current-format "#[fg=#85c6c9,bg=#373737,bold]  #I:#W "

set -g pane-border-style "fg=#4c4c4a"
set -g pane-active-border-style "fg=#6dadaf"

set -g message-style "bg=#4c4c4a,fg=#a4a29b,bold"
set -g message-command-style "bg=#4c4c4a,fg=#a4a29b"

# Visual is the dim blue upstream
set -g mode-style "bg=#003e41,fg=#a4a29b"

set -g clock-mode-colour "#6dadaf"
