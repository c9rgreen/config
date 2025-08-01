# Credit: Many comments are copied verbatim from
# https://zsh.sourceforge.io/Doc/Release/Options.html.

# Enable colors.
autoload -U colors && colors

# Try to complete the word based on the position where the cursor is,
# rather than from the end of the word.
setopt COMPLETE_IN_WORD

# Move cursor to end of word after every completion, even if the cursor
# was in the middle of the word.
setopt ALWAYS_TO_END

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD

# Don’t push multiple copies of the same directory onto the directory
# stack.
setopt PUSHD_IGNORE_DUPS

# Change directories by typing the directory name alone without a "cd".
setopt AUTOCD

# Zsh sessions will append their history list to the history file,
# rather than replace it.
setopt APPEND_HISTORY

# Save each command’s beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to the history file
setopt EXTENDED_HISTORY

# If the internal history needs to be trimmed to add the current command
# line, setting this option will cause the oldest history event that has
# a duplicate to be lost before losing a unique event from the list.
setopt HIST_EXPIRE_DUPS_FIRST

# Do not enter command lines into the history list if they are
# duplicates of the previous event.
setopt HIST_IGNORE_DUPS

# Remove command lines from the history list when the first character on
# the line is a space, or when one of the expanded aliases contains a
# leading space.
setopt HIST_IGNORE_SPACE

# Whenever the user enters a line with history expansion, don’t execute
# the line directly; instead, perform history expansion and reload the
# line into the editing buffer.
setopt HIST_VERIFY

# The maximum number of events stored in the internal history list. If
# you use the HIST_EXPIRE_DUPS_FIRST option, setting this value larger
# than the SAVEHIST size will give you the difference as a cushion for
# saving duplicated history events.
export HISTSIZE=10000000

# The maximum number of history events to save in the history file.
export SAVEHIST=10000000

# This option both imports new commands from the history file, and also
# causes your typed commands to be appended to the history file (the
# latter is like specifying INC_APPEND_HISTORY, which should be turned
# off if this option is in effect).
setopt SHARE_HISTORY

# On an ambiguous completion, instead of listing possibilities or
# beeping, insert the first match immediately. Then when completion is
# requested again, remove the first match and insert the second match,
# etc. When there are no more matches, go back to the first one again.
setopt MENU_COMPLETE

# Display a dropdown-list style menu for completions.
zstyle ':completion:*' menu yes select

# Autocompletions
autoload -Uz compinit
compinit

# Bash autocompletions
autoload bashcompinit
bashcompinit

