# Cyclotron Dark
# Hexes from nvim/colors/cyclotron.lua.
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/cyclotron_dark.tmux

# Status line colors (see tmux.conf)
set -g @accent "#fd8760"
set -g @dim    "#c4beaf"
set -g @warn   "#c8b362"
set -g @mode   "#a690c9"
set -g @track  "#77b884"
set -g @date   "#c8b362"
set -g @host   "#a690c9"

# Bar background (the base01 surface)
set -g status-style "bg=#201f19,fg=#cfcec3"

set -g pane-border-style "fg=#323028"
set -g pane-active-border-style "fg=#fd8760"

set -g message-style "bg=#3a382e,fg=#cfcec3,bold"
set -g message-command-style "bg=#3a382e,fg=#cfcec3"

set -g mode-style "fg=#fd8760,reverse"

set -g clock-mode-color "#fd8760"
