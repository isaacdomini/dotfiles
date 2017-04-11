#!/bin/bash

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
  sudo apt-get install gnupg -y
  curl -O https://prerelease.keybase.io/keybase_amd64.deb
  sudo dpkg -i keybase_amd64.deb
  sudo apt-get install -f
  run_keybase
  deb http://archive.monkeysphere.info/debian experimental monkeysphere
  deb-src http://archive.monkeysphere.info/debian experimental monkeysphere
elif [[ "$curros" == "arch" ]]; then
  printf "\n\n...Installing git and openssh...\n\n"
  pacman -S git
  pacman -S openssh
  pacman -S openssh-server
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
 

echo "Log into Keybase..."
keybase login

echo "Exporting your PGP keys..."
# Exporting your Keybase public key to keybase.public.key
keybase pgp export -o keybase.public.key
# Exporting your Keybase private key to keybase.private.key
keybase pgp export -s -o keybase.private.key

echo "Importing your Keybase keys..."
# Import your Keybase public key
gpg -q --import keybase.public.key
# Import your Keybase private key
gpg -q --allow-secret-key-import --import keybase.private.key
# The key import process produces a short hexadecimal hash
# We need to extract this hash and use it to generate the RSA key
# The hash is temporarily saved into hash.key
gpg --list-keys | grep '^pub\s*.*\/*.\s.*' | grep -oEi '\/(.*)\s' | cut -c 2- | awk '{$1=$1};1' > hash.key

echo "Generating RSA keys..."
# Generate the RSA private key using the hexadecimal hash
# The private key will be saved in the id_rsa file
gpg --export-options export-reset-subkey-passwd,export-minimal,no-export-attributes --export-secret-keys --no-armor `cat hash.key` | openpgp2ssh `cat hash.key` > id_rsa
# Secure the private RSA key file  
chmod 400 id_rsa
# Generate the public RSA key file  
ssh-keygen -y -f id_rsa > id_rsa.pub

echo "Cleaning up..."
# Remove all the temporary files  
rm *.key

echo "Success"

echo "\n...Generate SSH key...\n"

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
