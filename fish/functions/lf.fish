function lf --wraps=lf --description="lf, cd to the last directory on exit"
    cd (command lf -print-last-dir $argv)
end
