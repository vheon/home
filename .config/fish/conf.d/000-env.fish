set -x BREW_PREFIX /usr/local/
if test -d /home/linuxbrew/.linuxbrew/
  set -x BREW_PREFIX /home/linuxbrew/.linuxbrew/
end

set -x EDITOR nvim
set -x LC_ALL "en_US.UTF-8"
set -x LANG "en_US.UTF-8"
set -u PATH
set -x PATH $HOME/bin $HOME/.fzf/bin $BREW_PREFIX/bin /bin /usr/bin /usr/local/bin $BREW_PREFIX/sbin /sbin /usr/sbin /usr/local/sbin
