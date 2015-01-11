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
  # echo -n '【ツ】'
  echo -n ' ►_◄ '
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
brew install hg
brew install ranger
brew install rbenv
brew install rbenv-gem-rehash
brew install ruby-build
brew install the_silver_searcher
brew install tmux
brew install reattach-to-user-namespace
brew install tree

brew install go

brew install maven

# XXX: Create a version that support --HEAD
brew install selecta

brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap vheon/custom
brew install brew-cask

brew cask install iterm2-nightly

brew cask install flash

brew cask install java

brew cask install firefox
brew cask install google-chrome

brew cask install virtualbox
brew cask install vagrant

brew cask install mplayerx

brew cask install unrarx

brew cask install seil
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
