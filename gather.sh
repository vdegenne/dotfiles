#!/usr/bin/bash

files=(
    '/etc/bashrc'
    '/home/valentin/.config/i3/config'
    '/home/valentin/.irssi/'
    '/home/valentin/.Xresources'
    '/root/.emacs.d/'
)

for f in "${files[@]}"
do
    # in case of a directory
    [[ -d "$f" ]] && {
	cp -i -r "$f" .
    }
    # in case of a file
    [[ -f "$f" ]] && {
	cp -i "$f" .
    }
    
done

     
