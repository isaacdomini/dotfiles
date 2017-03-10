#!/bin/bash --login
echo "\n\n...Installing Rails...\n\n"
gem update --system
rvm gemset use global
gem update
echo "gem: --no-document" >> ~/.gemrc
gem install bundler
gem install nokogiri
gem install rails --version=5.0.2
echo "\n\n...Rails 5.0.2 installed...\n\n"
