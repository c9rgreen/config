# Circadia Dark (Warm Ember)
# Colors from https://github.com/tanmaymanojgandhi/circadia (ports/tmux/circadia-dark.tmux).
#
# Pins this palette instead of following the terminal theme. Source it after
# tmux.conf:
#   source-file ~/.config/tmux/themes/circadia_dark.tmux

# Status line colors (see tmux.conf)
set -g @accent "#e89a49"
set -g @dim    "#91887d"
set -g @warn   "#8cbb62"
set -g @mode   "#b991db"
set -g @track  "#8cbb62"
set -g @date   "#d99148"
set -g @host   "#b991db"

# Bar background (bg_surface in the upstream port)
set -g status-style "bg=#1e1a15,fg=#c9c0b1"

set -g pane-border-style "fg=#3b342b"
set -g pane-active-border-style "fg=#e89a49"

set -g message-style "bg=#29241e,fg=#c9c0b1,bold"
set -g message-command-style "bg=#29241e,fg=#c9c0b1"

set -g mode-style "fg=#e89a49,reverse"

set -g clock-mode-color "#e89a49"
