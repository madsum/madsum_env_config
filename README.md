# madsum_env_config
All development environment configuration

# Install dev environment 

* First install WSL
* Install Ubuntu from Windows store
* Install git in WSL
* Copy all config files in WSL home. 

## Install fzf for reverse search

 git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
 cd ~/.fzf
 sudo ./install 

## Install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb   

sudo dpkg -i ripgrep_13.0.0_amd64.deb


## Install pose git
* If node is installed by all the option, it will install chocolaty. 
* If no node, then install chocolatey https://community.chocolatey.org/packages/poshgit
* choco install poshgit 


