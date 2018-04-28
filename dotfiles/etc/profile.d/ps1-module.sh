# Escape Sequences (ES)
#
#
# An ES has a one or more <modifier>
# Here's the syntax :
#
#      \033[<modifier; ...>m
#  or  \e[<modifier; ...>m
#
# It will modify all the text on the right.
# To stop the modification, use the ES \e[0m
#
# Possible <modifier>
# ===================
#
# "38;5;<color>" (change the text to <color>*)
#   ex => \e[38;5;48m I'm very green
#
# "48;5;<color>" (change the background to <color>*)
#   ex => \e[48;5;48m I'm green background
#
# "1" (change the text to bold)
#   ex => \e[1m I am so bold
#
# "4" (underline the text)
#   ex => \e[4m I am underlined
#
# "0" (no text transform)
#
# * All possible colors can be checked using this function :
show255colors() {
    for C in {16..255}; do
	echo -en "\e[48;5;${C}m$C ";
    done
    echo -en "\e[0m";
}
#
#
# Combinaison
# ===========
# You can also combine the modifiers, for instance :
#
# \e[38;5;48;1m I am green and bold
# \e[38;5;124;48;5;211;4m I am underline, burgundy on pink background
# (the order doesn't matter)
#
#
# Placeholders
# ============
#
# \u : username
# \h : host
# \w : pwd
# \W : basedir(pwd)
# \d : date
# \n : newline
#
# When you define a PS1, you can use those, for instance :
#
#  PS1='\[\e[38;5;48m\]\w \[\e[1;38;5;211m\]\u $'
#
# This will define prompt a green path and a pink username
#
#
# Functions
# =========
# We can use function and stamp them inside the PS1, for instance :
#
# showBranch() {
#     git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p";
# }
# PS1="\u \$(showBranch) \n$"
# PS1='\u $(showBranch) \n$'
#


# this function to shorten the path
minimizePwd () {
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}


showBranch() {
    res="$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p")";
    if [ ${#res} -ne 0 ];then
	echo " ($res)";
    fi
}
showBranchNude() {
    res="$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p")";
    if [ ${#res} -ne 0 ];then
	echo " @$res";
    fi
}



if [ "`id -u`" -eq 0 ]; then
    prompt='#'
else
    prompt='$'
fi


# with user
# PS1="\[\e[38;5;227m\]\u \[\e[38;5;41m\]\$(minimizePwd \$(pwd) 3) \[\e[38;5;247m\][\$(showBranch)] \n\[\e[38;5;227m\]$PS1\[\e[0m\]"

# without user
# PS1="\n\[\e[0;38;5;49;48;5;232m\]\$(minimizePwd \$(pwd) 3)\[\e[0;38;5;240m\]\$(showBranch) \[\e[0;38;5;221m\]\n$prompt>\[\e[0m\] "
#PS1="\[\e[1;34m\]\w\[\e[38;5;227m\]\$(showBranchNude) \[\e[32m\]\$prompt\[\e[0m\] "
PS1="\u@\h:\[\e[0;34m\]\$(minimizePwd \$(pwd) 3)\[\e[38;5;227m\]\$(showBranchNude)\[\e[32m\] \$prompt\[\e[0m\] "
