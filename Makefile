.PHONY: *

install:
	brew bundle
	stow git
	stow npm
	stow tmux
	stow vim
	stow zsh
