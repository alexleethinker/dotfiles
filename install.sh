#!/bin/bash 

DOTFILES_DIR="$HOME/dev/dotfiles"

source "$DOTFILES_DIR/helpers.sh"

function install_PACKAGES {
  echo "Updating packages repository"

  # spotify repository
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

  sudo apt-get update
  echo ""

  echo "Installing packages"
  sudo apt-get install -y \
  # general
    zip \
    ubuntu-restricted-extras \
    unzip \
    rar \
    git \
    vim \
    vim-gnome \
    zsh \
    git-core \
    indicator-multiload \
    bison \
    curl \
    make \
    binutils \
    gcc \
    build-essential \
    terminator \
    xclip \
    silversearcher-ag \
    spotify-client \
  # vim
    cmake \
    python3-dev \
    python-dev \
    exuberant-ctags \
    mercurial \
    libmagic-dev \
  # docker
    apt-transport-https \
    ca-certificates \
    software-properties-common
  echo ""
}

function install_GOLANG {
  # Install Golang
  echo "Installing Go"
  git clone https://github.com/udhos/update-golang ~/dev/update-golang
  cd ~/dev/update-golang
  sudo ./update-golang.sh
  gitUsername=$(git config --global user.name)
  if [ ! -z "$gitUsername" ] ;then
    echo "Creating your Github's go directory"
    mkdir -p $GOPATH/src/github.com/$gitUsername
  fi

  goinstall "Find Unleashed" github.com/kbrgl/fu
  goinstall the_platinum_searcher github.com/monochromegane/the_platinum_searcher/...

  # only install td if fetching todos-data is succesful 
  # since it's a private repo, so only would work for me
  git clone git@github.com:gillchristian/todos-data.git ~/.todos
  if [ $? -eq 0 ]; then
    goinstall Todos github.com/gillchristian/todos/cmd/td
  fi
}

function install_VIM {
  echo "Adding VIM config"
  link "$DOTFILES_DIR/vim" ~/.vim
  link "$DOTFILES_DIR/vim/vimrc" ~/.vimrc
  echo ""
}

function install_SSH {
  echo "Updating SSH and adding config"
  update openssh-client
  update openssh-server
  mkdir -p ~/.ssh/
  link "$DOTFILES_DIR/ssh/config" ~/.ssh/config
  echo ""
}

function install_GIT {
  echo "Adding Git config"
  link "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
  link "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global
  echo ""
}

function install_ANTIGEN {
  echo "Installing Antigen and adding config"
  mkdir ~/antigen
  curl -L git.io/antigen > ~/antigen/antigen.zsh
  link "$DOTFILES_DIR/zsh/antigenrc" ~/.antigenrc
  echo ""
}

function install_ZSH {
  echo "Adding ZSH config"
  link "$DOTFILES_DIR/zsh" ~/.zsh
  link "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc
  if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo "Setting ZSH as the default shell"
    chsh -s $(which zsh)
  fi
  echo ""
}


function install_CONFIG {
  install_ZSH

  install_ANTIGEN

  install_GIT

  install_SSH

  install_VIM

  install_GOLANG
}

function main {
  install_PACKAGES

  install_CONFIG
}

main
