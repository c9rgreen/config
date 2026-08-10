# broot launcher — https://github.com/Canop/broot
#
# `broot --install` normally symlinks this file into ~/Library/Application
# Support/org.dystroy.broot; it is kept as a real file here so it travels with
# this repo. Regenerate with `broot --install` if broot changes the launcher.
#
# The function is needed because broot emits commands (like `cd`) that have no
# useful effect when executed in a subshell.
function br --wraps=broot
    set -l cmd_file (mktemp)
    if broot --outcmd $cmd_file $argv
        source $cmd_file
        rm -f $cmd_file
    else
        set -l code $status
        rm -f $cmd_file
        return $code
    end
end
