# Circadia Forest Dark (Obsidian Pine)
# Colors from https://github.com/tanmaymanojgandhi/circadia (ports/tmux/circadia-dark-forest.tmux).
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/circadia_forest_dark.tmux

# Status line colors (see tmux.conf)
set -g @accent "#83b384"
set -g @dim    "#838d85"
set -g @warn   "#d19b66"
set -g @mode   "#b29ace"
set -g @track  "#92b87e"
set -g @date   "#d19b66"
set -g @host   "#b29ace"

# Bar background (bg_surface in the upstream port)
set -g status-style "bg=#1a1e1b,fg=#c4ccc5"

set -g pane-border-style "fg=#353c36"
set -g pane-active-border-style "fg=#83b384"

set -g message-style "bg=#242a25,fg=#c4ccc5,bold"
set -g message-command-style "bg=#242a25,fg=#c4ccc5"

set -g mode-style "fg=#83b384,reverse"

set -g clock-mode-color "#83b384"
