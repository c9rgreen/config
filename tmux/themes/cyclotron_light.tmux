# Cyclotron Light
# Hexes from nvim/colors/cyclotron.lua.
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/cyclotron_light.tmux

# Status line colors (see tmux.conf)
set -g @accent "#b84820"
set -g @dim    "#4a4538"
set -g @warn   "#8a7520"
set -g @mode   "#6a558a"
set -g @track  "#3a7a4a"
set -g @date   "#8a7520"
set -g @host   "#6a558a"

# Bar background (the base01 surface)
set -g status-style "bg=#e9e7df,fg=#2a2920"

set -g pane-border-style "fg=#d4d1c7"
set -g pane-active-border-style "fg=#b84820"

set -g message-style "bg=#cbc8bc,fg=#2a2920,bold"
set -g message-command-style "bg=#cbc8bc,fg=#2a2920"

set -g mode-style "fg=#b84820,reverse"

set -g clock-mode-color "#b84820"
