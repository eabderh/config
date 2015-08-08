#!/bin/bash

inst_path="$HOME/dev/config_files/"

#mkdir $inst_path
#cd ~/dev/config_files
cd "$inst_path"

#git clone http://github.com/eabderh/config_files.git

find $inst_path -maxdepth 1 -type f -name ".*" -print \
	| awk -vi="$inst_path" '$0=i$0' \
	| xargs echo
#	| awk '{ print $inst_path $0 }' \


find $inst_path -maxdepth 1 -type f -name ".*" -print \
	| awk -vi="$inst_path" '$0=i$0'

find $inst_path -maxdepth 1 -type f -name ".*"
