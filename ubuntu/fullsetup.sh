#!/bin/bash
#install wget
echo "\n\n...Installing Essential Tools...\n\n"
echo "Installing wget"
sudo apt-get install wget
#install curl
echo "Installing curl"
sudo apt-get install curl
#install git
echo "Installing git"
sudo apt-get install git
#install vim
echo "Installing vim"
sudo apt-get install vim
#install tmux
echo "Installing tmux"
sudo apt-get install tmux
#install zsh
echo "Installing zsh"
sudo apt-get install zsh
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

