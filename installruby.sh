#!/bin/bash --login
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable --ruby
source /home/cyriac/.rvm/scripts/rvm
rvm get stable --autolibs=enable
rvm install ruby
rvm --default use ruby-2.4.0
echo "\n\n\n\n..........................\nInstalling NodeJS\n.................\n"
gem update --system
rvm gemset use global
gem update
echo "gem: --no-document" >> ~/.gemrc
gem install bundler
gem install nokogiri
gem install rails --version=5.0.2


