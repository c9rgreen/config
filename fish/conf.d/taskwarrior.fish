function task
    # Read the current macOS appearance setting
    set -l is_dark (defaults read -g AppleInterfaceStyle 2>/dev/null)

    set -l taskrc_path

    if test "$is_dark" = "Dark"
        set taskrc_path $HOME/.config/task/taskrc.dark
    else
        set taskrc_path $HOME/.config/task/taskrc.light
    end

    env TASKRC=$taskrc_path command task $argv
end
