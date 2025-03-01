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
    alias ls="eza --icons=always --git"
end    

#
# Vim
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
# Direnv
#
if type -q direnv
    direnv hook fish | source
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
