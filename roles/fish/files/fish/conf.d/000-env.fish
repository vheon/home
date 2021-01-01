set -x BREW_PREFIX /usr/local
if test -d /home/linuxbrew/.linuxbrew
  set -x BREW_PREFIX /home/linuxbrew/.linuxbrew
end

set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim
set -x LC_ALL "en_US.UTF-8"
set -x LANG "en_US.UTF-8"
set -x GOPATH $HOME/go
set -u PATH
set -x PATH $HOME/bin $XDG_CONFIG_HOME/fzf/bin $GOPATH/bin $BREW_PREFIX/bin /bin /usr/bin /usr/local/bin $BREW_PREFIX/sbin /sbin /usr/sbin /usr/local/sbin
