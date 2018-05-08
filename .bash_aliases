alias gvim='UBUNTU_MENUPROXY= gvim'
alias viml='vim -V9vimlog'
alias v='viml'

alias ack='ack-grep'
alias l="ls"
alias ls='ls -h --ignore=*.pyc --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -lh --time-style=long-iso'
alias la='ls -A'
alias lla='ls -lhA'
alias lal='lla'

alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias g='git'

function cpcd () { cp "$@" && eval cd "\"\$$#\""; }
function mvcd () { mv "$@" && eval cd "\"\$$#\""; }

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

if function_exists __git_complete; then
__git_complete g __git_main

for al in `__git_aliases`; do
    alias g$al="git $al"
    
    complete_func=_git_$(__git_aliased_command $al) 
    function_exists $complete_fnc && __git_complete g$al $complete_func
done

fi
