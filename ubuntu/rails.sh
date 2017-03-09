#!/bin/bash --login
gem update --system
rvm gemset use global
gem update
echo "gem: --no-document" >> ~/.gemrc
gem install bundler
gem install nokogiri
gem install rails --version=5.0.2
