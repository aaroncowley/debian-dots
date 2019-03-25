cat packages.txt | sudo apt install -y

#powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

#ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

cp -R .vim/ ..
cp -R .i3/ ..
cp .vimrc
cp .tmux.conf ..
cp .Xresources ..
cp .zprofile ..
cp .zshrc ..
cp compton.conf ../.config/
