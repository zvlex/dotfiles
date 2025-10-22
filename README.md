# Dotfiles

### Dependencies
Fedora Linux

```bash
sudo dnf install git stow emacs neovim vim
```

### Install:
```bash
git clone git@github.com:zvlex/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Usage:

Will symlink config files

```bash
# Emacs
stow emacs

# Neovim
stow nvim
```
