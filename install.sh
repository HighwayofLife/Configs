#!/bin/bash

SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

linkfile() {
	FILE=$1
	if [ ! -h "~/$FILE" ]; then
		if [ -e "~/$FILE" ]; then
			echo "Backing up ~/$FILE to ~/$FILE.bak"
			mv ~/$FILE ~/$FILE.bak
		fi

		ln -s "$SELF_PATH/$FILE" ~/$FILE
		echo "ln -s $SELF_PATH/$FILE ~/$FILE"
	else
		echo "~/$FILE is already linked"
	fi
}

linkfile ".bashrc"
linkfile ".vimrc"
linkfile ".screenrc"
linkfile ".gvimrc"

if [ -e ~/.gitconfig ]; then
	read -p "Do you wish to backup your ~/.gitconfig file and copy over a new one? [y/n]: " gc
	case $gc in 
		y|Y) echo "Backing up .gitconfig to .gitconfig.bak"
			mv ~/.gitconfig ~/.gitconfig.bak
			cp "$SELF_PATH/.gitconfig" ~/.gitconfig
			echo "New .gitconfig file created";;
	esac
else
	cp "$SELF_PATH/.gitconfig" ~/.gitconfig
	echo "New .gitconfig file created"
fi

