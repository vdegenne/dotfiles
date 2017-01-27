#!/usr/bin/bash
# this script is used to gather all the files
# defined in the array 'files' into the directory
# where the script got fired from

shopt -s extglob

# in case of a directory you should always
# notify the script using an ending slash
files=(
    '/[etc/bashrc]'
    '/[usr/share/fonts/Monaco/Monaco.ttf]'
    '/home/valentin/[.config/i3/config]'
    '/home/valentin/[.irssi/]'
    '/home/valentin/[.Xresources]'
    '/root/[.emacs]'
    '/root/[.emacs.d/]'
)


for f in "${files[@]}"; do
    # relative : '/.config' in '/home/valentin[/.config]'
    relative="${f#*[}"
    relative="${relative%]*}" # relative="${relative%%?(/)]}"
    # basedirpath : '/home/valentin' in '/home/valentin[/.config]'
    basedirpath="${f%[*}"

    # is it a directory ?
    if [[ "${relative: -1}" = / ]]; then
	isdir=1
	relative="${relative:0: -1}"
    else
	isdir=0
    fi
    
    # creating the directories structures
    while IFS=/ read -a dirs; do

	# delete the file or leading directory
	rm -rf "${dirs[0]}"
	
	[[ "${#dirs[@]}" > 1 ]] && {
	    IFS='/'
	    mkdir -p "${dirs[*]:0:${#dirs[@]}-1}"
	}
	
    done <<< "$relative"

    # copy the content from remote to local
    if [[ $isdir = 1 ]]; then
	cp -r "$basedirpath$relative" .
    else
	cp -r "$basedirpath$relative" "$relative"
    fi
    
done
exit 1
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
