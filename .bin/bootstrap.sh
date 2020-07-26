#!/bin/bash

RED="$(tput setaf 1)"
NORMAL="$(tput sgr0)"

function colorEcho () {
    printf "${RED} $1${NORMAL}\n"
}

if [ "$(uname)" == "Darwin" ]; then
  if ! command -v brew >/dev/null 2>&1; then  
    colorEcho "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew tap caskroom/fonts
  brew tap homebrew/cask

  colorEcho "Brew install..."
  brew install git
  brew install hub
  brew install ansible
  brew install coreutils
  brew install shellcheck
  brew install ack
  brew install tree
  brew install httpie
  brew install telnet
  brew install mackup
  brew install bluetoothconnector
  brew install diff-so-fancy
  brew install neofetch
  brew install exiftool
  brew install mkvtoolnix
  brew install wget
  brew install tmux
  brew install jq
  brew install zsh
  brew install mas

  colorEcho "Installing fonts using brew cask..."
  brew cask install font-meslolg-nerd-font
  brew cask install font-saucecodepro-nerd-font
  brew cask install font-cascadia-mono-pl
  brew cask install font-cascadia-pl
  brew cask install font-cascadia-mono
  brew cask install font-cascadia
  brew cask install font-fira-code

  colorEcho "Installing other applications using brew cask..."
  # brew cask install iterm2
  brew cask install hyper
  brew cask install google-chrome
  brew cask install microsoft-edge
  brew cask install 1password
  brew cask install alfred
  brew cask install visual-studio-code
  brew cask install bartender
  brew cask install controlplane
  brew cask install tower
  brew cask install little-snitch
  brew cask install royal-tsx
  brew cask install db-browser-for-sqlite
  brew cask install microsoft-teams
  brew cask install datagrip
  brew cask install private-internet-access
  brew cask install postman
  brew cask install multipass
  brew cask install cheatsheet

  colorEcho "Installing MAS applications using mas..."
  mas signin weavus@icloud.com
  # Microsoft Remote Desktop
  mas install 409907375
  # Moom
  mas install 419330170
  # Pixelmator
  mas install 407963104
  # Blackmagic Disk Speed Test
  mas install 425264550
  # Reeder
  mas install 880001334 
  # DaisyDisk
  mas install 411643860
  # Microsoft To Do
  mas install 1274495053
  # The Unarchiver
  mas install 425424353
  # Bear
  mas install 1091189122
  # The Clock
  mas install 488764545
  # Bumpr
  mas install 1166066070

  colorEcho "Setting iTerm preference folder..."
  defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/Documents/Config/iTerm"

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
