#!/usr/bin/env bash

# https://multipass.run/docs/alias-command

# Multipass aliases make it easy to run a command inside of the guest OS from the host OS.
# For instance, running `$ tree` on the host OS will actuall run `tree` within the Ubuntu VM.
# If mount $HOME on your VM, the alias will even cwd on your host OS.
# https://multipass.run/docs/share-data-with-an-instance

multipass alias c9r:stow stow
multipass alias c9r:lilypond lilypond
multipass alias c9r:tree tree
multipass alias c9r:hugo hugo
multipass alias c9r:potrace potrace
multipass alias c9r:ctags ctags
