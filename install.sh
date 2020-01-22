#!/bin/bash

#####################################################
# Auto installation of preferred debian environment #
#####################################################

cd ~/debian-dots/

# fresh system stuff
if [ "$1" == "install" ]; then
    cat packages.txt | sudo apt install -y
    
    git clone https://github.com/vinceliuice/Mojave-gtk-theme.git mojave
    cd mojave
    ./install.sh
    cd ..
    rm -rf mojave

    #powerline fonts
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    
    #ohmyzsh 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    #powerlevel9k
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 
    
    #vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    mkdir -p ~/.local/share/xfce4/terminal/colorschemes
    cp ./Material.theme ~/.local/share/xfce4/terminal/colorschemes/

    sudo cp ./base16-material-darker.rasi /usr/share/rofi/themes/
    chsh -s /usr/bin/zsh
fi

#move dotfiles from repo to $HOME
if [ "$1" == "install" ] || [ "$1" == "download" ]; then
    cp -R .vim/ ~
    cp -R .config ~
    cp .vimrc ~
    cp .tmux.conf ~
    cp .Xresources ~
    cp .zprofile ~
    cp .zshrc ~

    vim -c "PlugInstall | q | q"
fi

#move dotfiles in $HOME to repo
if [ "$1" == "upload" ]; then
    cp -R ~/.config/i3 ./.config/
    cp -R ~/.config/autostart ./.config/
    cp -R ~/.config/ranger ./.config/
    cp -R ~/.config/xfce4 ./.config/
    cp -R ~/.config/compton.conf ./.config
    cp -R ~/.config/rofi ./.config/
    cp -R ~/.vim .
    cp ~/.vimrc .
    cp ~/.tmux.conf .
    cp ~/.Xresources .
    cp ~/.zprofile .
    cp ~/.zshrc .
    cd ./.vim/plugged/
    rm -rf *
fi

if [ $1 == "vimup" ]; then
    cp -R ~/.vim .
    cp ~/.vimrc .
    cd ./.vim/plugged/
    rm -rf *
elif [ $1 == "vimdown" ]; then
    cp -R .vim/ ~
    cp .vimrc ~
    vim -c "PlugInstall | q | q"
    cd ~
fi

echo "Done"
exit 0
