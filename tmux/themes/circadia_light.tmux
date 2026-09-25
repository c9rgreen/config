# Circadia Light (Warm Parchment)
# Colors from https://github.com/tanmaymanojgandhi/circadia (ports/tmux/circadia-light.tmux).
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/circadia_light.tmux

# Status line colors (see tmux.conf)
set -g @accent "#0048b3"
set -g @dim    "#43505c"
set -g @warn   "#843900"
set -g @mode   "#7a1f7a"
set -g @track  "#005f2f"
set -g @date   "#095b62"
set -g @host   "#7a1f7a"

# Bar background (bg_surface in the upstream port)
set -g status-style "bg=#eee7d6,fg=#28323a"

set -g pane-border-style "fg=#d7cdb7"
set -g pane-active-border-style "fg=#0048b3"

set -g message-style "bg=#e5dcc6,fg=#28323a,bold"
set -g message-command-style "bg=#e5dcc6,fg=#28323a"

set -g mode-style "fg=#0048b3,reverse"

set -g clock-mode-color "#0048b3"
