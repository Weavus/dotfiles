#!/bin/bash

RED="$(tput setaf 1)"
NORMAL="$(tput sgr0)"

function colorEcho () {
    printf "${RED} $1${NORMAL}\n"
}

if [ "$(uname)" == "Darwin" ]; then
  if ! command -v brew >/dev/null 2>&1; then  
    colorEcho "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"

  brew tap homebrew/cask-fonts
  brew tap homebrew/cask

  colorEcho "Brew install..."
  brew install git
  brew install zsh
  brew install hub
  brew install coreutils
  brew install shellcheck
  brew install ripgrep
  brew install btop
  brew install lazydocker
  brew install tree
  brew install httpie
  #brew install mackup
  brew install macchina
  brew install wget
  brew install jq
  
  colorEcho "Installing fonts using brew cask..."
  brew install --cask font-meslo-lg-nerd-font

  colorEcho "Installing other applications using brew cask..."
  brew install --cask 1password
  brew install --cask little-snitch
  brew install --cask kitty
  brew install --cask visual-studio-code
  brew install --cask bartender
  brew install --cask private-internet-access
  brew install --cask cheatsheet

  #colorEcho "Installing MAS applications using mas..."
  brew install mas
  # Moom
  #mas install 419330170
  # Pixelmator Pro
  #mas install 1289583905
  # Blackmagic Disk Speed Test
  #mas install 425264550
  # DaisyDisk
  #mas install 411643860
  # The Unarchiver
  #mas install 425424353
  # UpNote
  #mas install 1398373917
  # AdGuard Safari
  #mas install 1440147259

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
  echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells > /dev/null
  chsh -s /opt/homebrew/bin/zsh
else
  chsh -s /bin/zsh
fi

colorEcho "Done"