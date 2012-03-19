# mwhite's .bashrc.  based on ubuntu's default

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# force ignoredups and ignorespace
HISTCONTROL=ignoreboth
HISTSIZE=2048

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h --color=auto --group-directories-first'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lhA'
alias lal='lla'

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gsi='git submodule init'
alias gsa='git submodule add'
alias gss='git submodule sync'
alias gsu='git submodule update'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function mkcd
{
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

# Load RVM into a shell session as a function
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

if [[ -s "$HOME/dotfiles/bash/pandoc-completion/pandoc-completion.bash" ]]; then
    source "$HOME/dotfiles/bash/pandoc-completion/pandoc-completion.bash"
fi

[[ $- == *i* ]] &&   . "$HOME/dotfiles/bash/git-prompt/git-prompt.sh"

PATH=$PATH:$HOME/dotfiles/bin
PATH=$PATH:$HOME/.cabal/bin
export PATH

PYTHONPATH=$HOME/.cabal/bin
