# Change the default shell to fish, either via
# (1) Terminal - https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac
# (2) System Settings > Users and Groups > Advanced Options - https://support.apple.com/en-us/102547

# Binaries not managed by a package manager
fish_add_path --path --append $HOME/.local/bin

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
    # brblack here was the same trap as the pager below — it is fg_dim (#d9cdb8)
    # in atomic, so an uncolored token inside the match sat at 1.34:1 (1.53:1 in
    # atomic_light). Reuse the invariant fg-over-bg pairing, which means naming a
    # foreground too: syntax colors no longer show through the match, matching
    # fish's own default (bryellow --background=brblack).
    set fish_color_search_match white --background=black

    # Completion pager: the selected row defaults to reverse-video (-r), which
    # leaves the prefix/completion foregrounds dark on a dark reversed background.
    # Set explicit colors instead — white on black. These colors have to stay
    # readable under both atomic and atomic_light, and 7 (fg) over 0 (bg_border)
    # is the only pairing that does: atomic tracks 7/8/15 to the theme's
    # foreground and 0 to its background, so the two invert together and the
    # contrast holds either way (~9.6:1). A colored background does not work
    # here — every slot in 1..14 darkens in the light variant, so e.g. white on
    # blue is legible in the dark theme but dark-on-dark in the light one.
    set fish_pager_color_selected_background --background=black
    set fish_pager_color_selected_completion white --bold
    set fish_pager_color_selected_prefix white --bold --underline
    set fish_pager_color_selected_description white --italics
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
    # comes from the terminal's ANSI palette and follows the Ghostty theme.
    #
    # Only the chromatic slots are named. The neutrals (0/7/8/15) are assigned
    # inconsistently across the themes in ghostty/themes — atomic treats 0 as a
    # dark border and 7/8/15 as foregrounds, while the mini* themes invert that
    # (0/8 foreground, 7/15 background) — so -1, the terminal's own fg/bg, is
    # used wherever a neutral is wanted.
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
