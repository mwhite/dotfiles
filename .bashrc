# mwhite's .bashrc.  based on ubuntu's default

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

set -o vi

#. ~/.gkr

PATH=$PATH:$HOME/dotfiles/bin
PATH=$PATH:$HOME/.cabal/bin
PATH=$PATH:$HOME/.local/bin
PATH="/usr/local/heroku/bin:$PATH"
PATH=$PATH:$HOME/dotfiles/bash/git-pull-request
export PATH

export EDITOR=vim
export TERM='xterm-256color'

PYTHONPATH=$HOME/.cabal/bin

mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

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
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

DOTFILES=$HOME/dotfiles

LP_PS1_PREFIX="\[[\e]0;\u@\h: \w\a]\]"


if [[ -f "$DOTFILES/bash/liquidprompt/liquidprompt" ]]; then
    . "$DOTFILES/bash/liquidprompt/liquidprompt"
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_private ]; then
    source ~/.bash_private
fi
