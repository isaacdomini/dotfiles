#!/bin/bash
echo "Baseline (Individual):"
time {
  apt-get install -s wget > /dev/null
  apt-get install -s curl > /dev/null
  apt-get install -s git > /dev/null
  apt-get install -s vim > /dev/null
  apt-get install -s tmux > /dev/null
  apt-get install -s zsh > /dev/null
}
echo "----------------------"
echo "Optimized (Batched):"
time {
  apt-get install -s wget curl git vim tmux zsh > /dev/null
}
