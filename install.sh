#!/bin/bash

instpath="$HOME/dev/config_files/"
homepath=$PWD/

#mkdir $instpath

#git clone http://github.com/eabderh/config_files.git

regex_esc () {
	echo "$1" | sed -e 's/[]\/$*.^|[]/\\&/g'
}

homepath_regex=$(regex_esc "$homepath")
instpath_regex=$(regex_esc "$instpath")
sedcom="s/^\(.*\)$/$instpath_regex\1 $homepath_regex\1/"

cd "$instpath"
git ls-tree -r -d  HEAD --name-only --full-tree \
 	| sed -e "s/^/$homepath_regex/" \
	| xargs -n 1 mkdir
git ls-tree -r HEAD --name-only --full-tree \
	| sed -e "$sedcom" \
	| xargs -t -n 2 sh -c 'ln -s "$1" "$2"' argv0
exit 0


