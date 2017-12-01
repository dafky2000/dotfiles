# Personal dotfiles for use across machines

## TODO

- This is still very specific to my environment, installed applications, plugins and other dependencies. My first priority will be to make it more agnostic.

## To use

Simply make symbolic links from the repository to your home directory for the desired configurations

``` bash
ln -s ~/dev/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dev/dotfiles/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
ln -s ~/dev/dotfiles/.config/Code/User/settings.json ~/.config/Code/User/settings.json
ln -s ~/dev/dotfiles/.config/xfce4/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
ln -s ~/dev/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/dev/dotfiles/.bashrc ~/.bashrc
ln -s ~/dev/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dev/dotfiles/.conkyrc ~/.conkyrc
ln -s ~/dev/dotfiles/.gdbinit ~/.gdbinit
ln -s ~/dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dev/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dev/dotfiles/.htmlhintrc ~/.htmlhintrc
ln -s ~/dev/dotfiles/.inputrc ~/.inputrc
ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dev/dotfiles/.tern-project ~/.tern-project
ln -s ~/dev/dotfiles/.toprc ~/.toprc
ln -s ~/dev/dotfiles/.vimrc ~/.vimrc
ln -s ~/dev/dotfiles/.xinitrc ~/.xinitrc
ln -s ~/dev/dotfiles/.Xmodmap ~/.Xmodmap
ln -s ~/dev/dotfiles/.ycm_extra_conf ~/.ycm_extra_conf
```
