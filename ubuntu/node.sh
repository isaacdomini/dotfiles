#!/bin/bash
echo "\n\n...Installing NodeJS, npm and build-essentials...\n\n"
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo sh nodesource_setup.sh
rm -f node nodesource_setup.sh
sudo apt-get install -y nodejs
sudo apt-get install build-essential
echo "Completed nodejs and npm install"
echo "\n\n...Docker installed...\n\n"
