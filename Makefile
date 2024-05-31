.PHONY: *

install:
	brew bundle
	stow git
	stow npm
	stow vim
	stow zsh
