#!/bin/:bash

curros="unknownos"

unsupported_os()
{
  printf "Detected $curros"
  printf "\n\n\nUnsupported OS, exiting with code 2"
  exit 2
}

ostype=$OSTYPE
if [[ "$ostype" == "linux-gnu" ]]; then
  if type "apt-get" &> /dev/null; then
    curros="ubuntu"
  elif type "pacman" &> /dev/null; then
    curros="arch" 
  elif type "yum" &> /dev/null; then
    curros="fedora"
    unsupported_os
  else
    curros="linux-gnu"
    unsupported_os 
  fi
elif [[ "$ostype" == "darwin"* ]]; then
  curros = "mac"
elif [[ "$ostype" == "cygwin" ]]; then
  curros="cygwin"
  unsupported_os
elif [[ "$ostype" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
  curros="msys"
  unsupported_os
elif [[ "$ostype" == "win32" ]]; then
  # I'm not sure this can happen.
  curros="windows"
  unsupported_os
elif [[ "$ostype" == "freebsd"* ]]; then
  # Freebsd
  curros="freebsd"
  unsupported_os
else
  # Unknown.
  unsupported_os
fi

if [[ "$curros" == "ubuntu" ]]; then
  printf "\n\n...Installing git and openssh...\n\n"
  sudo apt-get install git -y
  sudo apt-get install openssh -y
  sudo apt-get install openssh-server -y
elif [[ "$curros" == "arch" ]]; then
  printf "\n\n...Installing git and openssh...\n\n"
  sudo pacman -S git
  sudo pacman -S openssh
  sudo pacman -S openssh-server
elif [[ "$curros" == "mac" ]]; then
  printf "\n\n...Installing xcode tools...\n\n"
  xcode-select --install
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sudo systemsetup -setremotelogin on
  sudo dseditgroup -o create -q com.apple.access_ssh
  sudo dseditgroup -o edit -a admin -t group com.apple.access_ssh  
else
  unsupported_os
  exit 3
fi
 

echo "\n...Generate SSH key...\n"
ssh-keygen -t rsa -b 4096 -C "me@isaacdomini.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sshkeygenerated=`cat ~/.ssh/id_rsa.pub`
echo $sshkeygenerated
generate_github_post_curl()
{
  cat <<EOF
{
  "title":"$(hostname)",
  "key":"$sshkeygenerated"
}
EOF
}
curl -u "cyriacd" --data "$(generate_github_post_curl)" https://api.github.com/user/keys

echo "Cloning dotfiles"
git config --global user.name "Isaac Domini"
git config --global user.email me@isaacdomini.com
git clone git@github.com:cyriacd/dotfiles.git

if [[ "$(basename ${PWD})" != "dotfiles" ]]; then
  if [[ -d dotfiles ]]; then
    echo "Found dotfiles directory. Running full setup and self destructing"
    rm -f $0   
    bash dotfiles/$curros/fullsetup.sh
    exit 0
  fi
  echo "Repository not cloned. Exiting with error code 2"
  exit 2
fi

echo "Currently in dotfiles, will not self destruct!. Exiting..."
exit 0 
