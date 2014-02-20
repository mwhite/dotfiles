alias c='cd ~/hq/cchq'
alias hq='workon hq'
alias runserver='./manage.py runserver 8001 --werkzeug'
alias run_gunicorn='./manage.py run_gunicorn 0.0.0.0:8001 -w 3'
alias couchlog='tail -f /usr/local/var/log/couchdb/couch.log'

alias gvim='UBUNTU_MENUPROXY= gvim'
alias viml='vim -V9vimlog'

alias ack='ack-grep'
alias l="ls"
alias ls='ls -h --ignore=*.pyc --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias gr='grep -r'

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lhA'
alias lal='lla'

alias sai='sudo apt-get install'

alias g='git'
__git_complete g __git_main

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"
    
    complete_func=_git_$(__git_aliased_command $al) 
    function_exists $complete_fnc && __git_complete g$al $complete_func
done
