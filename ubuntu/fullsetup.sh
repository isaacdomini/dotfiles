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

echo "source ~/dotfiles/defaults" >> ~/.zshrc

source ~/.zshrc

echo "\n\n...Essentials Installed...\n\n"

