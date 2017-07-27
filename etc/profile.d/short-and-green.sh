source /usr/share/git-core/contrib/completion/git-prompt.sh

_dir_chomp () {
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s > $2 && c < ${#p[*]} - 1))
    do
	d=${p[c]}
	n=1; [[ $d = .* ]] && n=2
	((s -= ${#d} - n))
	p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}

PS1='\[\033[01;32m\]\u[$(_dir_chomp "$(pwd)" 3)]\[\033[36m\]`__git_ps1`\[\033[00m\] \$ '
