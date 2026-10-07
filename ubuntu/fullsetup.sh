#!/bin/bash
echo "\n\n...Installing Essential Tools...\n\n"
echo "Installing wget, curl, git, vim, tmux, and zsh"
sudo apt-get install -y wget curl git vim tmux zsh

echo "Setting  zsh as default"
chsh -s $(which zsh)

echo "source ~/dotfiles/defaults" >> ~/.zshrc

source ~/.zshrc

echo "\n\n...Essentials Installed...\n\n"

