# Personal dotfiles for use across machines

## TODO

- This is still very specific to my environment, installed applications, plugins and other dependencies. My first priority will be to make it more agnostic.

## To use

Simply make symbolic links from the repository to your home directory for the desired configurations

### bash

``` bash
ln -s $(pwd)/.config/fish/config.fish ~/.config/fish/config.fish
ln -s $(pwd)/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
ln -s $(pwd)/.config/Code/User/settings.json ~/.config/Code/User/settings.json
ln -s $(pwd)/.config/xfce4/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
ln -s $(pwd)/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -s $(pwd)/.bashrc ~/.bashrc
ln -s $(pwd)/.bash_profile ~/.bash_profile
ln -s $(pwd)/.conkyrc ~/.conkyrc
ln -s $(pwd)/.gdbinit ~/.gdbinit
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.gitignore_global ~/.gitignore_global
ln -s $(pwd)/.htmlhintrc ~/.htmlhintrc
ln -s $(pwd)/.inputrc ~/.inputrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.tern-project ~/.tern-project
ln -s $(pwd)/.toprc ~/.toprc
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.xinitrc ~/.xinitrc
ln -s $(pwd)/.Xmodmap ~/.Xmodmap
ln -s $(pwd)/.ycm_extra_conf.py ~/.ycm_extra_conf.py
```

### fish

``` fish
ln -s (pwd)/.config/fish/config.fish ~/.config/fish/config.fish
ln -s (pwd)/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
ln -s (pwd)/.config/Code/User/settings.json ~/.config/Code/User/settings.json
ln -s (pwd)/.config/xfce4/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
ln -s (pwd)/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -s (pwd)/.bashrc ~/.bashrc
ln -s (pwd)/.bash_profile ~/.bash_profile
ln -s (pwd)/.conkyrc ~/.conkyrc
ln -s (pwd)/.gdbinit ~/.gdbinit
ln -s (pwd)/.gitconfig ~/.gitconfig
ln -s (pwd)/.gitignore_global ~/.gitignore_global
ln -s (pwd)/.htmlhintrc ~/.htmlhintrc
ln -s (pwd)/.inputrc ~/.inputrc
ln -s (pwd)/.tmux.conf ~/.tmux.conf
ln -s (pwd)/.tern-project ~/.tern-project
ln -s (pwd)/.toprc ~/.toprc
ln -s (pwd)/.vimrc ~/.vimrc
ln -s (pwd)/.xinitrc ~/.xinitrc
ln -s (pwd)/.Xmodmap ~/.Xmodmap
ln -s (pwd)/.ycm_extra_conf.py ~/.ycm_extra_conf.py
```
