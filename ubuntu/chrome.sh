#!/bin/bash
echo "\n\n...Installing Google Chrome...\n\n"
deb http://dl.google.com/linux/chrome/deb/ stable main
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
echo "\n\n...Google Chrome Installed...\n\n"
