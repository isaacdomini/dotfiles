#!/bin/bash
echo "\n...Installing git...\n"
sudo apt-get install git
echo "\n...Generate SSH key...\n"
ssh-keygen -t rsa -b 4096 -C "me@cyriacdomini.com"
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
git clone git@github.com:cyriacd/dotfiles.git

if [[ "$(basename ${PWD})" != "dotfiles" ]]; then
  if [[ -d dotfiles ]]; then
    echo "Found dotfiles directory. Running full setup and self destructing"
    rm -f $0   
    bash dotfiles/fullsetup.sh
    exit 0
  fi
  echo "Repository not cloned. Exiting with error code 2"
  exit 2
fi

echo "Currently in dotfiles, will not self destruct!. Exiting..."
exit 0
