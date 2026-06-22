# Change the default shell to fish, either via
# (1) Terminal - https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac
# (2) System Settings > Users and Groups > Advanced Options - https://support.apple.com/en-us/102547

# Binaries not managed by a package manager
set -a PATH "$HOME/.local/bin"

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

    # Syntax highlighting colors
    set fish_color_command blue
    set fish_color_keyword blue --bold
    set fish_color_param cyan
    set fish_color_option cyan
    set fish_color_quote yellow
    set fish_color_error red --bold
    set fish_color_comment brblack --italics
    set fish_color_autosuggestion brblack
    set fish_color_valid_path --underline
    set fish_color_operator green
    set fish_color_redirection magenta
    set fish_color_end green
    set fish_color_escape magenta
    set fish_color_search_match --background=brblack
end

#
# Neovim
#
if type -q nvim
    set -gx EDITOR "nvim"
    set -gx MANPAGER "nvim +Man!"
end

#
# NPM
#
if type -q npm
    # Location for global node modules. Avoids having to install with sudo.
    # https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
    set -gx NPM_CONFIG_PREFIX "$HOME/.npm-global"
    set -a PATH "$HOME/.npm-global/bin"
end

#
# Eza
#
if type -q eza
    alias ls "eza --icons --git --git-repos"
end

#
# Lazygit
#
if type -q lazygit
    alias lgit "lazygit"
end

#
# Launch Google Chrome with remote debug enabled
# https://github.com/ChromeDevTools/chrome-devtools-mcp
#
alias chrome "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-profile-stable"

#
# Global ZK notebook location
# https://github.com/zk-org/zk-nvim
#
set -gx ZK_NOTEBOOK_DIR "$HOME/ZK"

#
# fzf shell integration
# https://github.com/junegunn/fzf#fish
#
# Sourced from config.fish (not conf.d) so it loads after vi key bindings.
# Provides Ctrl-T (paste paths), Ctrl-R (history), Alt-C (cd into subdir).
#
if type -q fzf
    # Use fd for file listing: fast, gitignore-aware, includes dotfiles.
    if type -q fd
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'
    end

    # Syntax-highlighted preview for Ctrl-T; directory tree for Alt-C.
    if type -q bat
        set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=numbers {}'"
    end
    if type -q eza
        set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --icons --color=always {}'"
    end

    fzf --fish | source
end
