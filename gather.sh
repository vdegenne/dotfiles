#!/usr/bin/bash
# this script is used to gather all the files
# defined in the array 'files' into the directory
# where the script got fired from

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

     
