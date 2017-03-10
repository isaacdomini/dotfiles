#!/bin/bash
brew cask install docker docker-compose
docker-machine create -d virtualbox dev
eval "$(docker-machine env dev)"

