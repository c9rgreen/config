# Change the default shell to fish, either via
# (1) Terminal - https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac
# (2) System Settings > Users and Groups > Advanced Options - https://support.apple.com/en-us/102547

# Binaries not managed by a package manager
fish_add_path --path --append $HOME/.local/bin

# rustup is keg-only in Homebrew, so its cargo/rustc proxies aren't linked
if test -d /opt/homebrew/opt/rustup/bin
    fish_add_path --path /opt/homebrew/opt/rustup/bin
end

# macOS has no default for XDG_CONFIG_HOME, so tools that only fall back to
# ~/Library/Application Support when it's unset (e.g. lazygit) would look
# there instead of in this repo. Setting it pins everything to ~/.config.
set -gx XDG_CONFIG_HOME "$HOME/.config"

#
# Vim keybindings
#
if status is-interactive
    # The greeting is defined in functions/fish_greeting.fish (runs fastfetch),
    # which replaces the default function that echoes $fish_greeting.
    set -g fish_key_bindings fish_vi_key_bindings

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
    # Search matches and the selected pager row share one pairing: black text
    # on a brwhite row, named in full so syntax colors don't show through.
    # Merino Light has no near-white ANSI slot — 7, 8 and 15 are all mid grays
    # and 0 is its foreground — so brwhite-on-brblack drops to 2.1:1 there.
    # Black on brwhite is the only pairing above 4.5:1 in both variants: the
    # text lands at 8.3:1 (Merino Dark) and 4.8:1 (Merino Light), and the row
    # separates from the page at 18.9:1 and 3.0:1. In Merino Dark it reads as
    # an inverted row, like Rex's own selection.
    set fish_color_search_match black --background=brwhite

    # Completion pager: the selected row defaults to reverse-video (-r), which
    # leaves the prefix/completion foregrounds dark on a dark reversed background.
    set fish_pager_color_selected_background --background=brwhite
    set fish_pager_color_selected_completion black --bold
    set fish_pager_color_selected_prefix black --bold --underline
    set fish_pager_color_selected_description black --italics
end

#
# Starship prompt
# https://starship.rs
#
# Replaces functions/fish_prompt.fish — the init defines fish_prompt and
# fish_right_prompt itself, and erases fish_mode_prompt so fish's default [N]/[I]
# vi-mode tag stays hidden (starship's character module shows the mode instead).
#
# Config is ~/.config/starship.toml.
#
if status is-interactive; and type -q starship
    starship init fish | source
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
    fish_add_path --path --append $HOME/.npm-global/bin
end

#
# Eza
#
if type -q eza
    alias ls "eza --icons --git"
end

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
    # Colors: --color=16 drops fzf's built-in 256-color scheme so everything
    # comes from the terminal's ANSI palette and follows the terminal theme.
    #
    # Only the chromatic slots are named. The neutrals (0/7/8/15) are assigned
    # inconsistently across themes — Merino Dark makes 0 a dim gray and 15
    # white, Merino Light makes 0 its foreground and 7/8/15 mid grays, and the
    # circadia and mini* themes differ again — so -1, the terminal's own
    # fg/bg, is used wherever a neutral is wanted.
    #
    # For the same reason the current line gets no background: bold text and a
    # red pointer mark it instead, which stays legible in light and dark alike.
    set -gx FZF_DEFAULT_OPTS "--color=16
        --color=fg:-1,bg:-1,gutter:-1,query:-1
        --color=fg+:-1:bold,bg+:-1
        --color=hl:yellow,hl+:yellow:bold
        --color=pointer:red,marker:green
        --color=prompt:blue:bold,info:blue,spinner:blue
        --color=border:blue,separator:blue,scrollbar:blue,label:blue
        --color=header:magenta
        --color=preview-fg:-1,preview-bg:-1"

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
# direnv
#
if type -q direnv
    direnv hook fish | source
end

#
# zoxide
# https://github.com/ajeetdsouza/zoxide
#
# Defines `z` (jump to a frecent directory) and `zi` (interactive, via fzf).
# Must come after the fzf integration above so `zi` picks up fzf.
#
if type -q zoxide
    zoxide init fish | source
end

