#!/usr/bin/env bash

# ask for password upfront
sudo -v

# keep alive the sudo
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

brew tap beeftornado/rmtree
brew tap neovim/neovim

brew update

brew install rmtree
brew install vim --with-override-system-vi --with-lua
brew install neovim --HEAD
brew install cmake
brew install ctags
brew install findutils
brew install coreutils
brew install git
brew install pyenv
brew install homebrew/boneyard/pyenv-pip-rehash
brew install the_silver_searcher
brew install tmux
brew install tree
brew install aria2
brew install subliminal

brew install go

brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions
brew install brew-cask

brew cask install iterm2-beta

brew cask install flash

brew cask install java

brew cask install firefox
brew cask install google-chrome

brew cask install virtualbox
brew cask install vagrant

brew cask install mplayerx
brew cask install vlc

brew cask install transmission

brew cask install unrarx

brew cask install seil
brew cask install karabiner
brew cask install bettertouchtool
brew cask install flux

brew cask install spotify

sudo brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch --qlplugindir="/Library/QuickLook"
sudo brew cask install quicklook-csv betterzipql webpquicklook suspicious-package --qlplugindir="/Library/QuickLook"

brew cask install font-source-code-pro
brew cask install font-source-sans-pro

brew linkapps
brew cleanup
brew doctor
