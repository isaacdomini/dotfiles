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
  curros="mac"
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

  #sudo systemsetup -setremotelogin on
  #sudo dseditgroup -o create -q com.apple.access_ssh
  #sudo dseditgroup -o edit -a admin -t group com.apple.access_ssh  
else
  unsupported_os
  exit 3
fi
 

echo "\n...Generate SSH key...\n"
ssh-keygen -f ~/.ssh/id_ed25519_github -t ed25519 -C "7013557+isaacdomini@users.noreply.github.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github

touch ~/.ssh/config
text="Host *\n  
  AddKeysToAgent yes\n
  UseKeychain yes\n
  IdentityFile ~/.ssh/id_ed25519_github"

echo -e $text > ~/.ssh/config
  
brew install gh
gh auth login

echo "Cloning dotfiles"
git clone git@github.com:isaacdomini/dotfiles.git

brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

echo "source ~/dotfiles/defaults" >> ~/.zshrc

git config --global user.name "Isaac Domini"
git config --global user.email "7013557+isaacdomini@users.noreply.github.com"
git config --global commit.gpgsign true


if [[ "$(basename ${PWD})" != "dotfiles" ]]; then
  if [[ -d dotfiles ]]; then
    echo "Found dotfiles directory. Running full setup and self destructing"
    rm -f $0

    read -n1 -p "Run full setup? [y,n]" doit 
    case $doit in  
      y|Y) bash dotfiles/$curros/fullsetup.sh ;; 
      n|N) exit 0 ;; 
      *) exit 0 ;; 
    esac
    exit 0
  fi
  echo "Repository not cloned. Exiting with error code 2"
  exit 2
fi

echo "Currently in dotfiles, will not self destruct!. Exiting..."
exit 0 
