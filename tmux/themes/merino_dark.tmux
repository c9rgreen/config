# Merino Dark
# Rex's built-in theme; hexes from nvim/colors/merino.lua.
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/merino_dark.tmux

# Status line colors (see tmux.conf)
set -g @accent "#3485fa"
set -g @dim    "#82878c"
set -g @warn   "#d29922"
set -g @mode   "#bc8cff"
set -g @track  "#3fb950"
set -g @date   "#d29922"
set -g @host   "#bc8cff"

# Bar background (the base01 surface)
set -g status-style "bg=#1e2023,fg=#e6edf3"

set -g pane-border-style "fg=#424549"
set -g pane-active-border-style "fg=#3485fa"

set -g message-style "bg=#2d2f32,fg=#e6edf3,bold"
set -g message-command-style "bg=#2d2f32,fg=#e6edf3"

set -g mode-style "fg=#3485fa,reverse"

set -g clock-mode-color "#3485fa"
