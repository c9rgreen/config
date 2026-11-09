# Merino Light
# Rex's built-in theme; hexes from nvim/colors/merino.lua.
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/merino_light.tmux

# Status line colors (see tmux.conf)
set -g @accent "#0667d8"
set -g @dim    "#696d71"
set -g @warn   "#9d5c00"
set -g @mode   "#8250df"
set -g @track  "#116329"
set -g @date   "#9d5c00"
set -g @host   "#8250df"

# Bar background (the base01 surface)
set -g status-style "bg=#eceef2,fg=#1f2328"

set -g pane-border-style "fg=#d1d2d5"
set -g pane-active-border-style "fg=#0667d8"

set -g message-style "bg=#dcdee2,fg=#1f2328,bold"
set -g message-command-style "bg=#dcdee2,fg=#1f2328"

set -g mode-style "fg=#0667d8,reverse"

set -g clock-mode-color "#0667d8"
