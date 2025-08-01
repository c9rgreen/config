# Change the default shell to fish, either via
# (1) Terminal - https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac
# (2) System Settings > Users and Groups > Advanced Options - https://support.apple.com/en-us/102547

#
# Homebrew
#
if type -q /opt/homebrew/bin/brew shellenv
    eval (/opt/homebrew/bin/brew shellenv)
end

#
# Eza
#
if type -q eza
    alias ls="eza --git --icons"
end  

#
# Vim keybindings
#
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

#
# Neovim
#
if type -q nvim
    set -gx EDITOR "nvim"
    set -gx MANPAGER "nvim +Man!"
else if type -q vim
    set -gx EDITOR "vim"
end

#
# NPM
#
if type -q npm
    # Look for npm config in ~/.config
    set -gx NPM_CONFIG_USERCONFIG "$HOME/.config/npm/config"

    # Location for global node modules. Avoids having to install with sudo.
    # https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
    set -a PATH "$HOME/.npm-global/bin"
end

#
# ASDF
#
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims


#
# Orbstack
# Command line tools and shell integration
# https://orbstack.dev/
#
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
