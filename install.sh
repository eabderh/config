#!/bin/bash

regex_esc () {
	echo "$1" | sed -e 's/[]\/$*.^|[]/\\&/g'
}


homepath=$PWD
instpath="$homepath/dev/config_files"

homepath_regex=$(regex_esc "$homepath/")
instpath_regex=$(regex_esc "$instpath/")
sedcom="s/^\(.*\)$/$instpath_regex\1 $homepath_regex\1/"


mkdir -p "$instpath"
cd "$instpath"

git clone -b dev --recursive \
	https://github.com/eabderh/config_files.git "$instpath"

#ln -s "$instpath/.vim" "$HOME/.vim"

git ls-tree -r -d  HEAD --name-only --full-tree \
 	| sed -e "s/^/$homepath_regex/" \
	| xargs -n 1 mkdir -p
#	| sed -e "/\/\.vim$/d" \

rm -rf "$homepath/.vim/bundle/Vundle.vim"
ln -s "$instpath/.vim/bundle/Vundle.vim" "$homepath/.vim/bundle/Vundle.vim"

git ls-tree -r HEAD --name-only --full-tree \
	| sed -e "$sedcom" \
	| xargs -t -n 2 sh -c 'ln -s "$1" "$2"' argv0
#	| sed -e "/\/\.vim\//d" \
exit 0

vim -c '+PluginInstall'


