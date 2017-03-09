#!/bin/bash
if [[ $(basename ${PWD}) != "dotfiles" ]]; then
  if [[ -d dotfiles ]]; then
    echo "Found dotfiles directory. Running full setup and self destructing"
    rm -f $0   
    dotfiles/fullsetup.sh
    exit 0
  fi
  echo "Repository not cloned. Exiting with error code 2"
  exit 2
fi

echo "Currently in dotfiles, will not self destruct!. Exiting..."
exit 0
