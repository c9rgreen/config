function yazi --wraps=yazi --description="yazi, cd to the last directory on exit"
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    command yazi $argv --cwd-file=$tmp
    if read -z cwd <$tmp; and test "$cwd" != "$PWD"; and test -d "$cwd"
        builtin cd -- $cwd
    end
    command rm -f -- $tmp
end
