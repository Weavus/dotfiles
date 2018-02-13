#!/bin/bash

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
elif [ "$(expr substr '$(uname -s)' 1 5)" == "Linux" ]; then
  colorEcho "Linux setup..."
fi

colorEcho "Install prezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto

colorEcho "Cloning dotfiles..."
git clone --bare https://github.com/weavus/dotfiles.git $HOME/.dotfiles
function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}
dotfiles checkout
if [ $? = 0 ]; then
  colorEcho "Checked out dotfiles";
else
  colorEcho "Backing up pre-existing dotfiles...";
  mkdir -p .dotfiles-backup
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no

colorEcho "Setting zsh as default shell..."
if [ "$(uname)" == "Darwin" ]; then
  echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells > /dev/null
  chsh -s /usr/local/bin/zsh
else
  chsh -s /bin/zsh
fi

colorEcho "Done"
