#!/bin/bash
echo "\n\n...Installing docker...\n\n"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \ 
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce

echo "Installing docker-compose"

sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
echo "\n\n...Docker and Docker-Compose Intalled...\n\n"
