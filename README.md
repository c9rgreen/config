# cgreen's setup

![Workspace](workspace.jpeg)

## Highlights

| Role | Tool |
|-|-|
| Terminal | [Ghostty](https://ghostty.org) |
| Virtual Machines | [OrbStack](https://orbstack.dev) |
| Dotfiles | [Stow](https://www.gnu.org/software/stow/) |
| Shell | [Fish](https://fishshell.com) |
| Editor | [Neovim](https://neovim.io) |

## Usage

1. Clone this repository to `$HOME/.config`
1. Use `stow` to symlink the config files in each directory. i.e. `cd $/HOME/.config && stow zsh` results in `~/.zshrc -> ~/$HOME/.config/zsh/.zshrc` ([more on managing dotfiles with stow](https://alex.pearwin.com/2016/02/managing-dotfiles-with-stow/))
