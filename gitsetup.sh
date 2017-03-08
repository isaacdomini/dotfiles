#install wget
echo "Installing wget"
sudo apt-get install wget
#install curl
echo "Installing curl"
sudo apt-get install curl
#install git
echo "Installing git"
sudo apt-get install git
echo "Generate SSH key"
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

