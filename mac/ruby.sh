#!/bin/bash
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -L https://get.rvm.io | bash -s stable
rvm get stable --autolibs=enable
source ~/.rvm/scripts/rvm
rvm install ruby-2.4.0

