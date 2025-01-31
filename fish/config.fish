# Brew
eval (/opt/homebrew/bin/brew shellenv)

# Set editor to Neovim
set -Ux EDITOR nvim

# Save IEx history across sessions
# https://hexdocs.pm/iex/IEx.html#module-shell-history
set -Ux ERL_AFLAGS -kernel shell_history enabled

# Use NPM config in XDG_CONFIG_HOME
# https://github.com/npm/npm/issues/6675#issuecomment-251049832
set -Ux NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
set -Ux NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
set -Ux NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm

# Aliases 
alias ls="eza --icons=always --git"

if status is-interactive
    set -U fish_greeting # disable fish greeting
    set -U fish_key_bindings fish_vi_key_bindings

    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

    set fish_vi_force_cursor 1
end

# Direnv
direnv hook fish | source

# Helpful blog post
# https://www.joshmedeski.com/posts/set-up-fish-the-user-friendly-interactive-shell/
