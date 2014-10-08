#!/usr/bin/env bash

# ask for password upfront
sudo -v

# keep alive the sudo
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

function bot() {
  # echo -n '\[._.]/ '
  # echo -n '┌[._.]┐'
  echo -n '【ツ】'
}

function brew() {
  echo "$(bot)brew $@"
  $(which brew) "$@"
}

brew update

brew install vim --override-system-vi --with-lua
brew install cmake
brew install ctags
brew install findutils
brew install coreutils
brew install git
brew install ranger
brew install rbenv
brew install ruby-build
brew install the_silver_searcher
brew install tmux
brew install tree

# XXX: Create a version that support --HEAD
brew install selecta

brew tap caskroom/cask
brew tap caskroom/fonts
brew install brew-cask

brew cask install iterm2

brew cask install flash

brew cask install java

brew cask install firefox
brew cask install google-chrome

brew cask install mplayerx

brew cask install unrarx

brew cask install karabiner
brew cask install bettertouchtool

brew cask install osxfuse
brew cask install fuse-xfs
brew cask install sshfs

brew cask install spotify

brew cask install qlcolorcode
brew cask install qlstephen

brew cask install font-source-code-pro
brew cask install font-source-sans-pro

brew cleanup
brew doctor
