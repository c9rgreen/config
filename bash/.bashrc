#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --human-readable'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Direnv
if type direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

export PATH="$HOME/.npm-global/bin:$PATH"
