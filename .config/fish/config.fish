# fish colors
#
# What I really want is use the base01 from solarized but I cant, so let's
# change the 240th color in the 256 color palette and let fish-shell use that color
printf "\033Ptmux;\033\033]4;240;rgb:58/6e/75\007\033\\" > /dev/tty
set fish_color_autosuggestion 585858
set fish_color_command green
set fish_color_param blue
set fish_color_quote yellow
set fish_color_error red
set fish_color_search_match --background=green
set fish_pager_color_description yellow

set -x EDITOR vi
set -x LC_ALL "en_US.UTF-8"
set -x LANG "en_US.UTF-8"
set -x JAVA_HOME (/usr/libexec/java_home)
set -x SCALA_HOME (brew --repository)"/Library/LinkedKegs/scala/libexec"
set -x GOPATH $HOME/code/go
set -x GOBIN $GOPATH/bin
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x PATH /usr/local/bin $HOME/bin $GOBIN $PATH
# append eclim bin to the path, but eclipse is installed by brew cask
set -x PATH $PATH (readlink /Applications/Eclipse.app)"/../"

set -x fish_greeting ''

function a
  ls -lrth -G $argv
end

function ll
  ls -lh -G $argv
end

function take
  mkdir -p $argv[1]; and cd $argv[1]
end

# cd into whatever is the forefront Finder window.
function cdf # short for cdfinder
  cd (osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')
end

function mountg
  mkdir -p $HOME/tmp/storage
  sshfs -o volname=Storage -o Compression=no -o Ciphers=arcfour $USER@ghost.local:/mnt/storage $HOME/tmp/storage
end
