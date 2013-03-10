# mwhite's .bashrc.  based on ubuntu's default

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

PATH=$PATH:$HOME/dotfiles/bin
PATH=$PATH:$HOME/.cabal/bin
PATH="/usr/local/heroku/bin:$PATH"
PATH=$PATH:$HOME/dotfiles/bash/git-pull-request
export PATH

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

# Load RVM into a shell session as a function
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

if [[ -s "$HOME/dotfiles/bash/pandoc-completion/pandoc-completion.bash" ]]; then
    source "$HOME/dotfiles/bash/pandoc-completion/pandoc-completion.bash"
fi

if [[ -f "$HOME/dotfiles/bash/django_bash_completion" ]]; then
    source "$HOME/dotfiles/bash/django_bash_completion"
fi

if [[ -f "$HOME/dotfiles/bash/virtualenv-auto-activate/virtualenv-auto-activate.sh" ]]; then
    source "$HOME/dotfiles/bash/virtualenv-auto-activate/virtualenv-auto-activate.sh"
fi

if [[ -f "$HOME/dotfiles/bash/git-prompt/git-prompt.sh" ]]; then
    [[ $- == *i* ]] &&   . "$HOME/dotfiles/bash/git-prompt/git-prompt.sh"
fi

if [[ -f "$HOME/dotfiles/bash/bashmarks/bashmarks.sh" ]]; then
    source "$HOME/dotfiles/bash/bashmarks/bashmarks.sh"
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
