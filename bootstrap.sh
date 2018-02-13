#!/bin/bash

# Define colors
RED="$(tput setaf 1)"
NORMAL="$(tput sgr0)"

function colorEcho () {
    printf "${RED} $1${NORMAL}\n"
}

if [ "$(uname)" == "Darwin" ]; then
  colorEcho "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap homebrew/core
  brew tap homebrew/versions
  brew tap caskroom/fonts

  colorEcho "Brew install..."
  brew install git
  brew install node
  brew install python
  brew install coreutils
  brew install shellcheck
  brew install stow
  brew install ack
  brew install tree
  brew install httpie
  brew install diff-so-fancy
  brew install neofetch
  brew install zsh

  colorEcho "Installing fonts using brew cask..."
  brew cask install font-meslo-nerd-font

  colorEcho "Installing node global modules..."
  npm i -g vtop

  colorEcho "Update pip..."
  pip install --upgrade setuptools
  pip install --upgrade pip
elif [ "$(expr substr '$(uname -s)' 1 5)" == "Linux" ]; then
  colorEcho "Linux setup..."
fi

colorEcho "Cloning dotfiles..."
git clone --recursive https://github.com/weavus/dotfiles.git "${ZDOTDIR:-$HOME}/.dotfiles"

colorEcho "Install prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

colorEcho "Linking dotfiles..."
${ZDOTDIR:-$HOME}/.dotfiles/make stow

if [ "$(uname)" == "Darwin" ]; then
  colorEcho "Setting zsh as default shell..."
  echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells > /dev/null
  chsh -s /usr/local/bin/zsh
fi

colorEcho "Done"
