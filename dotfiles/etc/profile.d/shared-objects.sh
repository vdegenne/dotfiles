#!/usr/bin/bash

# variables #
ghub='https://github.com'
mghub='https://github.com/vdegenne'
kmsufi='5.39.79.61'


# mkdir and go #
mkddir () {
    mkdir "$1" && cd "$1"
}

# alias #
alias ls='ls --color'
alias ll='ls -l --color'
alias lla='ls -la --color'
alias grep='grep --color'
alias emacs='emacs -nw'



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

grab-a-clang () {
    echo "BasedOnStyle: Google
AlignAfterOpenBracket: AlwaysBreak
AllowAllParametersOfDeclarationOnNextLine: false
AllowShortBlocksOnASingleLine: false
AllowShortCaseLabelsOnASingleLine: false
AllowShortFunctionsOnASingleLine: None
AllowShortIfStatementsOnASingleLine: false
AllowShortLoopsOnASingleLine: false
BinPackArguments: false
BinPackParameters: false
" > '.clang-format'
}
