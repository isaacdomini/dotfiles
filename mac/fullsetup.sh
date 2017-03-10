#!/bin/bash

export PATH=/usr/local/bin:$PATH
brew tap caskroom/cask
brew update
brew install vim
brew install gpg
echo "Setting  zsh as default"
chsh -s $(which zsh)
echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Changing theme to bureau"
sed 's/.*ZSH_THEME.*/ZSH_THEME="bureau"/' ~/.zshrc
echo "INSTALLING NERD TREE"
curl -sL https://raw.githubusercontent.com/egalpin/apt-vim/master/install.sh | sh 
source ~/.zshrc
apt-vim install -y https://github.com/scrooloose/nerdtree.git
sudo sh -c 'echo "autocm vimenter * NERDTree" >> ~/.vimrc'
echo "\n\n...Essentials Installed...\n\n"

