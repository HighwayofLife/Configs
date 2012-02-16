#!/bin/bash

SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

read -p "Do you wish to backup your current configs? (They will be appended with .bak extension)" bk
case $bk in 
	y|Y) BACKUP_FILES='true';;
esac

linkfile() {
	FILE=$1
	if [ ! -h "~/$FILE" ]; then
		if [ -e "~/$FILE" && -n "$BACKUP_FILES" ]; then
			echo "Backing up ~/$FILE to ~/$FILE.bak"
			mv ~/$FILE ~/$FILE.bak
		else
			rm ~/$FILE
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

