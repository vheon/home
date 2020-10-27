export ZSH="$HOME/.zsh.d"

fpath=($ZSH/func $ZSH/completion $fpath)

setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt vheon

autoload -U compinit
compinit

# case insensitive completion and middle word completion
setopt NO_CASE_GLOB
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

setopt AUTO_CD
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export SCALA_HOME=$(brew --repository)/Library/LinkedKegs/scala/libexec
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="/usr/local/bin:$HOME/bin:$GOBIN:${PATH}"
# append eclim bin to the path, but eclipse is installed by brew cask
export PATH="$PATH:$(readlink /Applications/Eclipse.app)/../"
export EDITOR=nvim
set -o emacs

export HISTFILE="$HOME/.history"
export HISTSIZE=100000
export SAVEHIST=100000

export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"

if ls --color > /dev/null 2>&1; then
  colorflag="--color"
else
  colorflag="-G"
fi
alias ls="command ls -F ${colorflag}"
alias a="ls -lrth ${colorflag}"
alias ll="ls -lh ${colorflag}"

# alias for start/stop ftp server
alias ftpstart='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias ftpstop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

alias serve='python -m SimpleHTTPServer'
alias retag='ctags -R . --exclude=.svn --exclude=.git --exclude=log --exclude=tmp'

alias ip="dig +short myip.opendns.com @resolver1.opendns.com | tee ~/var/ip"
# alias localip="ifconfig getifaddr en1"

alias flush="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

alias sub='subliminal download -l en -s'

# XXX: removes all WORDCHARS and add them when I see its needed
export WORDCHARS=''

bindkey '^[b' backward-word
bindkey '^[^[[D' backward-word
bindkey '^[f' forward-word
bindkey '^[^[[C' forward-word

# TODO: see if this is useful
# Use C-x C-e to edit the current command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs '^X^E' edit-command-line

# This inserts a tab after completing a redirect. You want this.
# (Source: http://www.zsh.org/mla/users/2006/msg00690.html)
self-insert-redir() {
    integer l=$#LBUFFER
    zle self-insert
    (( $l >= $#LBUFFER )) && LBUFFER[-1]=" $LBUFFER[-1]"
}
zle -N self-insert-redir
for op in \| \< \> \& ; do
    bindkey "$op" self-insert-redir
done

# # smart urls
# autoload -U url-quote-magic
# zle -N self-insert url-quote-magic

take() {
  mkdir -p $1 && cd $1
}

trash() {
  mv $1 ~/.Trash
}

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#65737e"
source $ZSH/func/zsh-autosuggestions/zsh-autosuggestions.zsh

# source $ZSH/func/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/func/fast-syntax-highlightin/fast-syntax-highlighting.plugin.zsh
source $ZSH/func/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
