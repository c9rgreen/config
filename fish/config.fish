# Brew
eval (/opt/homebrew/bin/brew shellenv)

# Variables
set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings
set -Ux EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Direnv
direnv hook fish | source

# Helpful docs
# https://www.joshmedeski.com/posts/set-up-fish-the-user-friendly-interactive-shell/
