#!/bin/bash

RED="$(tput setaf 1)"
NORMAL="$(tput sgr0)"

function colorEcho () {
    printf "${RED} $1${NORMAL}\n"
}

if [ "$(uname)" == "Darwin" ]; then
  colorEcho "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/fonts
  brew tap homebrew/cask

  colorEcho "Brew install..."
  brew install git
  brew install hub
  brew install awscli
  brew install node
  brew install python
  brew install ansible
  brew install coreutils
  brew install shellcheck
  brew install ack
  brew install tree
  brew install httpie
  brew install diff-so-fancy
  brew install neofetch
  brew install zsh
  brew install mas

  colorEcho "Installing fonts using brew cask..."
  brew cask install font-meslo-nerd-font

  colorEcho "Installing other applications using brew cask..."
  brew cask install iterm2
  brew cask install google-chrome-beta
  brew cask install 1password
  brew cask install agenda
  brew cask install alfred
  brew cask install atom
  brew cask install bartender
  brew cask install controlplane
  brew cask install tower
  brew cask install little-snitch

  colorEcho "Installing MAS applications using mas..."
  mas signin weavus@icloud.com
  # Remote Desktop (3.9)
  # mas install 409907375
  # Xcode (9.4)
  # mas install 497799835
  # Slack (3.2.0)
  # mas install 803453959
  # Moom (3.2.11)
  mas install 419330170
  # Pixelmator (3.7)
  # mas install 407963104
  # Blackmagic Disk Speed Test (3.1)
  mas install 425264550
  # Reeder (3.1.2)
  # mas install 880001334 
  # DaisyDisk (4.6.1)
  mas install 411643860

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
