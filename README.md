# cgreen's setup

![Workspace](workspace.jpeg)

* Packages managed by [Homebrew](https://brew.sh)
* Terminal is [Ghostty](https://ghostty.org)
* Virtual Machines via [OrbStack](https://orbstack.dev)
* Dotfiles managed with [Stow](https://www.gnu.org/software/stow/)
* Shell handled by [Fish](https://fishshell.com)
* Editor, [Neovim](https://neovim.io)

## Usage

1. Clone this repository to `$HOME/.config`
1. Install [Homebrew](https://brew.sh)
1. In this directory, run `brew bundle` to install the packages
1. Use `stow` to symlink the config files in each directory. i.e. `cd $/HOME/.config && stow zsh` results in `~/.zshrc -> ~/$HOME/.config/zsh/.zshrc` ([more on managing dotfiles with stow](https://alex.pearwin.com/2016/02/managing-dotfiles-with-stow/))
