#!/bin/sh

export CONFIGDIR=`pwd`

if [ -e "~/.bashrc" ]; then
	echo "Backing up ~/.bashrc to ~/.bashrc.bak"
	mv ~/.bashrc ~/.bashrc.bak
fi

ln -s "$CONFIGDIR/.bashrc" ~/.bashrc
echo "~/.bashrc linked"

if [ -e "~/.vimrc" ]; then
	echo "Backing up ~/vimrc to ~/.vimrc.bak"
	mv ~/.vimrc ~/.vimrc.bak
fi

ln -s "$CONFIGDIR/.vimrc" ~/.vimrc
echo "~/.vimrc linked"

if [ -e "~/.gitconfig" ]; then
	read -p "Do you wish to backup your ~/.gitconfig file and copy over a new one? [y/n]: " gc
	case $gc in 
		y|Y) mv ~/.gitconfig ~/.gitconfig.bak
			cp "$CONFIGDIR/.gitconfig" ~/.gitconfig ;;
	esac
fi

