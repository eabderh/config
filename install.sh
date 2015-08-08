#!/bin/bash

regex_esc () {
	echo "$1" | sed -e 's/[]\/$*.^|[]/\\&/g'
}



instpath="$HOME/dev/config_files/"
homepath=$PWD/

mkdir -p "$instpath"
cd "$instpath"

git clone https://github.com/eabderh/config_files.git

homepath_regex=$(regex_esc "$homepath")
instpath_regex=$(regex_esc "$instpath")
sedcom="s/^\(.*\)$/$instpath_regex\1 $homepath_regex\1/"

git ls-tree -r -d  HEAD --name-only --full-tree \
 	| sed -e "s/^/$homepath_regex/" \
	| xargs -n 1 mkdir -p
git ls-tree -r HEAD --name-only --full-tree \
	| sed -e "$sedcom" \
	| xargs -t -n 2 sh -c 'ln -s "$1" "$2"' argv0
exit 0


