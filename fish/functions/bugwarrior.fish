function bugwarrior --description 'bugwarrior pointed at the repo taskrc'
    # The `task` command is a wrapper that sets TASKRC per-invocation, so there is no
    # global TASKRC. Point bugwarrior at a dedicated theme-free taskrc: bugwarrior's
    # config parser can't resolve taskwarrior's built-in theme includes, but this rc
    # shares data.location with the interactive variants so tasks land in the same db.
    env TASKRC=$HOME/.config/task/taskrc.bugwarrior command bugwarrior $argv
end
