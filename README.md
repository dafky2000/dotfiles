# Personal dotfiles for use across machines

## TODO

- This is still very specific to my environment, installed applications, plugins and other dependencies. My first priority will be to make it more agnostic.

## Prerequisites (incomplete)

``` fish
# As root or using sudo
# Install OS supplied packages
pacman -Syu iotop iftop htop ntop nmap screen sed curl wget sudo rsync \
            git gvim tmux fish bash-completion xclip \
            openssh docker \
            gcc clang cmake make extra-cmake-modules clang-tools-extra \
            perl python php npm nodejs cargo rust rust-racer mono \
            valgrind cppcheck shellcheck gtest doxygen

# Install node modules
npm install -g diff-so-fancy htmlhint eslint

# Install cpan modules
cpam -T Dir::Self Vim::Debug::Protocol
```

## To use

Simply make symbolic links from the repository to your home directory for the desired configurations

``` fish
git clone --recursive -j4 git@github.com:dafky2000/dotfiles.git
cd dotfiles
```

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

## Post linkage

``` fish
# Perfom the rest as your local user
# Install vim plugins
vim +PluginInstall +qall

# Finalize YouCompleteMe installation
# https://github.com/Valloric/YouCompleteMe#full-installation-guide
cd ~/.vim/bundle/YouCompleteMe/
./install.py --all
```
