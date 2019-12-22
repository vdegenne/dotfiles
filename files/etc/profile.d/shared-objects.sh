#!/usr/bin/bash

# variables #
export ghub='https://github.com'
export mghub='https://github.com/vdegenne'
export mserver='5.39.79.61'


# alias #
alias ls='ls --color'
alias ll='ls -l --color'
alias lla='ls -la --color'
alias grep='grep --color'
alias emacs='emacs -nw -u vdegenne'

alias mkddir='. mkddir $*'
alias gitclone='. gitclone $*'
alias pg-rest-starter='. pg-rest-starter'

# location tracing #
spot () {
    if [[ "$1" =~ ^/ ]]; then
	SPOT="$1"
    elif [[ "$1" =~ ^~ ]]; then
	SPOT="$(echo $1)"
    else
	SPOT="$PWD/$1"
    fi
}
cdspot () {
    PSPOT="$SPOT" # previous spot
    cd "$PSPOT"
}
spotcd () {
    spot .
    cd "$1"
}
spotcdspot () {
    spot .
    cd "$SPOT"
}



nodelog () {
    node -e "console.log($1)"
}
