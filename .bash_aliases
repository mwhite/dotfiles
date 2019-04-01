alias ack='ack-grep'
alias l="ls"
alias ls='ls -h --ignore=*.pyc --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias g='git'

function cpcd () { cp "$@" && eval cd "\"\$$#\""; }
function mvcd () { mv "$@" && eval cd "\"\$$#\""; }

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

if function_exists __git_complete; then
    __git_complete g __git_main
fi
