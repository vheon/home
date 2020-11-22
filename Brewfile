#!/usr/bin/env bash

# TODO(andra): we should look into either moving this to ansible as we should
# do with the rest of the dotfile for bootstrapping or look into the native
# brew Brewfile support.

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

brew install vim --with-override-system-vi --with-lua
brew install neovim --HEAD
# brew install fish
brew install cmake
# brew install ctags
brew install findutils
brew install coreutils
brew install git
# brew install pyenv
# brew install homebrew/boneyard/pyenv-pip-rehash
brew install the_silver_searcher
brew install tmux
# brew install tree
brew install aria2
brew install subliminal

# XXX(andrea): this also needs `brew services start clipper`
brew install clipper
# brew install go

brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions

# brew cask install iterm2-beta
brew cask install kitty

# brew cask install flash-npapi

# brew cask install java

brew cask install firefox
brew cask install google-chrome

# brew cask install virtualbox
# brew cask install vagrant

# brew cask install mplayerx
brew cask install vlc

brew cask install transmission

# brew cask install unrarx

# brew cask install seil
# brew cask install karabiner
brew cask install bettertouchtool
# brew cask install flux

brew cask install spotify

brew cask install font-source-code-pro
brew cask install font-source-sans-pro

brew linkapps
brew cleanup
brew doctor
