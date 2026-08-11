#
# zoxide
# https://github.com/ajeetdsouza/zoxide
#
# Replaces the completions `zoxide init fish` installs for `z`. Those only know
# about subdirectories of the current directory, and hand any keyword you type
# straight to fzf. These complete keywords against the database as well, so
# `z conf<TAB>` finds ~/.config from anywhere. Type a space before tab to get
# zoxide's fzf picker back.
#
# Two quirks explain the shape of this file:
#
#   - It has to be named for `__zoxide_z` rather than `z`. zoxide's init runs
#     `complete --erase --command z`, and an erase permanently stops fish
#     autoloading completions for that command, so a `completions/z.fish` would
#     never be read. `z` is an alias that wraps `__zoxide_z`, and fish follows
#     the wrap, autoload and all.
#
#   - zoxide's completions are erased rather than added to, and directories are
#     globbed by hand instead of via `__fish_complete_directories`. Both of
#     those call `complete -C` internally, which discards every other
#     completion offered for the command.
#

complete --erase --command __zoxide_z

function __zoxide_z_completions
    if not __fish_is_first_arg
        # Past the first keyword, resolve the query through fzf, the way
        # zoxide's own completions do.
        set -l tokens (builtin commandline --current-process --tokenize)
        set -l result (command zoxide query --exclude $PWD --interactive -- $tokens[2..-1] 2>/dev/null)
        and builtin commandline --replace -- "z "(string escape -- $result)
        and builtin commandline --function repaint execute
        return
    end

    # Directories under the token first, so `z` still behaves like `cd` for
    # paths that aren't in the database yet. The visible and hidden globs are
    # expanded separately because a glob that matches nothing aborts its own
    # command.
    set -l token (builtin commandline --current-token)
    set -l parent (string replace --regex -- '[^/]*$' '' $token)
    set -l leaf (string replace --regex -- '^.*/' '' $token)
    for dir in (path filter --type=dir -- $token* 2>/dev/null) \
        (path filter --type=dir -- $parent.$leaf* 2>/dev/null)
        printf '%s/\tDirectory\n' $dir
    end

    # Then the database, with each entry's rank as its description.
    command zoxide query --list --score --exclude $PWD | while read -l score dir
        printf '%s\t%s\n' (string replace -- $HOME '~' $dir) "score $score"
    end
end

complete --command __zoxide_z --no-files --arguments '(__zoxide_z_completions)'
