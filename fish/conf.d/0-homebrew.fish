# Homebrew
# https://docs.brew.sh/Installation
#
# Linuxbrew on Linux, /opt/homebrew on Apple Silicon. Sourced from conf.d so it
# runs before config.fish and brew's bin lands ahead of the system package
# manager's on PATH.
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
else if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end
