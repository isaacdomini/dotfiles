#!/bin/bash

curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo sh nodesource_setup.sh
sudo apt-get install -y nodejs
echo "Completed nodejs and npm install"
exit 0

