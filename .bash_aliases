alias hq='cd ~/hq/cchq && workon hq && ./manage.py runserver --werkzeug'
alias hqg='cd ~/hq/cchq && workon hq && ./manage.py run_gunicorn -w 3'

alias gvim='UBUNTU_MENUPROXY= gvim'

alias ls='ls -h --ignore=*.pyc --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lhA'
alias lal='lla'

if [[ -f "$HOME/.gitaliases" ]]; then
    aliases=$(grep "=" $HOME/.gitaliases | grep -v "#" | awk '{print $1}')
    for cmd in $aliases; do
        alias g$cmd="git $cmd"
        
        if [[ ${cmd:0:1} = 'l' ]]; then
            alias "g${cmd}g"="git $cmd --graph"
        fi
    done
fi
