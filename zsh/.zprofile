# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

export PATH="$HOME/.npm-global/bin:$PATH"
##
# Your previous /Users/cgreen/.zprofile file was backed up as /Users/cgreen/.zprofile.macports-saved_2024-09-09_at_06:33:30
##

# MacPorts Installer addition on 2024-09-09_at_06:33:30: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Brew package manager
eval "$(/opt/homebrew/bin/brew shellenv)"
