# What goes where:
#
#
# ↓ 1. .zshenv    - set environment variables here
# ↓ 2. .zprofile  - Set the environment for login shells "for ksh fans";
# ↓ 3. .zshrc     - Set the environment for interactive shells
# ↓ 			    - Set $PATH in .zshrc to get into the habit of making shell scripts portable.
# ↓ 4. .zlogin    - Set the environment for login shells
# ↓ 5. .zlogout   - Read when logging out of a session
#
# Source: https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# Source: https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where
# `export` makes the variable visible to programs run from zsh.

# Which characters should be considered as part of a word?
export WORDCHARS='*?[]~&;!$%^<>'

# Always use color when grepping.
export GREP_OPTIONS='--color=auto'

# Use the login keychain for aws-vault
export AWS_VAULT_KEYCHAIN_NAME=login

# Env vars which shouldn't be shared publicly
if [ -f $HOME/.env ]; then
    source $HOME/.env
fi

#
# Paths
#

# if [[ "$OSTYPE" == "darwin"* ]]; then
#     # Editor on macOS
#     export EDITOR='bbedit --wait'
# fi

export EDITOR='nvim'

# Location for global node modules. Avoids having to install with sudo.
export PATH="$HOME/.npm-global/bin:$PATH"

# Ruby Gems
export PATH="$HOME/.local/share/gem/ruby/3.1.0/bin:$PATH"
