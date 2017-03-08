#install wget
echo "Installing wget"
sudo apt-get install wget
#install curl
echo "Installing curl"
sudo apt-get install curl
#install git
echo "Installing git"
sudo apt-get install git
#install vim
echo "Installing vim"
sudo apt-get install vim
#install tmux
echo "Installing tmux"
sudo apt-get install tmux
#install zsh
echo "Installing zsh"
sudo apt-get install zsh
echo "Setting  zsh as default"
chsh -s $(which zsh)
echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Changing theme to bureau"
sed 's/.*ZSH_THEME.*/ZSH_THEME="bureau"/' ~/.zshrc
deb http://dl.google.com/linux/chrome/deb/ stable main
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable


echo "Installing docker"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \ 
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce

echo "Installing docker-compose"

sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
echo "INSTALLING NERD TREE"
curl -sL https://raw.githubusercontent.com/egalpin/apt-vim/master/install.sh | sh 
source ~/.zshrc
apt-vim install -y https://github.com/scrooloose/nerdtree.git
sudo sh -c 'echo "autocm vimenter * NERDTree" >> ~/.vimrc'
