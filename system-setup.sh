RUBY_VERSION="2.2.2"
NODE_VERSION="iojs"
# Make a personal bin directory
mkdir ~/bin
echo "export PATH=$HOME/bin:$PATH"

# Standard stuff & common dependencies for building stuff
sudo apt-get install -y python-pip aptitude htop tmux curl git silversearcher-ag \
  xsel zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev \
  libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev \
  python-software-properties libffi-dev imagemagick libnss3-tools \
  graphicsmagick-imagemagick-compat python-dev cmake

# Google Chrome PPA
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get -y update
sudo apt-get -y install google-chrome-stable
sudo pip install neovim

# FZF (like ctrl-p for bash)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Node version manager
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash

# Both FZF and NVM need to resource the bashrc
source ~/.bashrc

# Install iojs (better nodejs) and some global executables
nvm install $NODE_VERSION
nvm use $NODE_VERSION
echo "nvm use $NODE_VERSION" >> ~/.bashrc
npm install -g jshint jscs grunt-cli

# Ruby version manager
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv rehash

# ain't nobody got time for manuals, that's what the internet is for
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

# Ack, way faster than grep
# note: this gets added to your personal bin directory added at the top
curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 !#:3

#Virtual box
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox
