#!/usr/bin/env zsh

# This is a custom difftool for Tower
# https://www.git-tower.com/help/guides/integration/custom-diff-tools/mac
#
# $1: $LOCAL
# $2: $REMOTE
/opt/homebrew/bin/nvim -d "$1" "$2"
