set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx GOKU_EDN_CONFIG_FILE $XDG_CONFIG_HOME/karabiner/karabiner.edn
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"

set -Ux fish_user_paths
fish_add_path -a $HOME/bin
fish_add_path -a $XDG_DATA_HOME/bin
fish_add_path -a $XDG_CONFIG_HOME/fzf/bin

# XXX(andrea): This should be set somehow by the go role :/ maybe the role could add a fish file
set -x GOPATH $HOME/go
fish_add_path -a $GOPATH/bin

set -x BREW_PREFIX /usr/local
if test -d /home/linuxbrew/.linuxbrew
  set -x BREW_PREFIX /home/linuxbrew/.linuxbrew
end
if test -d /opt/homebrew
  set -x BREW_PREFIX /opt/homebrew
end
fish_add_path -a $BREW_PREFIX/bin
fish_add_path -a $BREW_PREFIX/sbin

# XXX(andrea): this is work-related and should be set in a specific role
fish_add_path -a $HOME/code/bigfix-builders-images
