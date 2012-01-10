#!/bin/bash

SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

if [ -e ~/.bashrc ]; then
	echo "Backing up ~/.bashrc to ~/.bashrc.bak"
	mv ~/.bashrc ~/.bashrc.bak
fi

if [ ! -h ~/.bashrc ]; then
	ln -s "$SELF_PATH/.bashrc" ~/.bashrc
	echo "~/.bashrc linked"
else
	echo "~/.bashrc is already linked"
fi

if [ -e ~/.vimrc ]; then
	echo "Backing up ~/vimrc to ~/.vimrc.bak"
	mv ~/.vimrc ~/.vimrc.bak
fi

if [ ! -h ~/.vimrc ]; then
	ln -s "$SELF_PATH/.vimrc" ~/.vimrc
	echo "~/.vimrc linked"
else
	echo "~/.vimrc is already linked"
fi

if [ -e ~/.gitconfig ]; then
	read -p "Do you wish to backup your ~/.gitconfig file and copy over a new one? [y/n]: " gc
	case $gc in 
		y|Y) mv ~/.gitconfig ~/.gitconfig.bak
			cp "$SELF_PATH/.gitconfig" ~/.gitconfig ;;
	esac
fi

