function tmux_escape -d "Escape an escape sequence for tmux"
  set -l escape $argv[0]
  if test -n "$TMUX"
    set escape (sed -e 's|\\\033|\\\033\\\033|g' (echo $escape | psub))
    set escape "\033Ptmux;$escape\033\\"
  end
  echo $escape
end

# fish colors
#
# What I really want is use the base01 from solarized but I cant, so let's
# change the 240th color in the 256 color palette and let fish-shell use that color
printf (tmux_escape "\033]4;240;rgb:58/6e/75\007") > /dev/tty
set fish_color_autosuggestion 585858
set fish_color_command green
set fish_color_param blue
set fish_color_quote yellow
set fish_color_error red
set fish_color_search_match --bright --background=black
set fish_pager_color_description yellow

set -gx LESS_TERMCAP_so \e'[01;43;30m'    # begin standout-mode – info
set -gx LESS_TERMCAP_mb \e'[01;31m'       # enter blinking mode
set -gx LESS_TERMCAP_md \e'[01;34m'       # enter double-bright mode
set -gx LESS_TERMCAP_me \e'[0m'           # turn off all appearance modes (mb, md, so, us)
set -gx LESS_TERMCAP_se \e'[0m'           # leave standout mode
set -gx LESS_TERMCAP_ue \e'[0m'           # leave underline mode
set -gx LESS_TERMCAP_us \e'[04;36m'       # enter underline mode

set -x LESS '--RAW-CONTROL-CHARS'

set -x EDITOR vi
set -x LC_ALL "en_US.UTF-8"
set -x LANG "en_US.UTF-8"
set -x GOPATH $HOME/code/go
set -x GOBIN $GOPATH/bin
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x FZF_DEFAULT_OPTS "--reverse --color bg:8,fg:12,hl:4,bg+:0,fg+:15,info:11,prompt:3,spinner:6,pointer:2,marker:1"
set -x PATH /usr/local/bin $HOME/bin $GOBIN $PATH
set -x PATH $PATH

set -x fish_greeting ''

status --is-interactive; . (rbenv init - --no-rehash -|psub)
# status --is-interactive; . (pyenv init - --no-rehash -|psub)

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

# function mountg
#   mkdir -p $HOME/tmp/storage
#   # sshfs -o volname=Storage -o Compression=no -o Ciphers=arcfour $USER@ghost.local:/mnt/storage $HOME/tmp/storage
#   sshfs -o volname=Storage -o Compression=no $USER@ghost.local:/mnt/storage $HOME/tmp/storage
# end

function sub
  subliminal -len -s $argv
end
complete -c sub -x -a "(__fish_complete_suffix .mkv) (__fish_complete_suffix .mp4)"

function itermprofile
  printf (tmux_escape "\033]50;SetProfile=$argv[1]\x7") > /dev/tty
end

# tmux_escape is not needed outside of this script
functions -e tmux_escape
