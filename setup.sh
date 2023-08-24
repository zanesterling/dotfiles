#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true

# Move files indicated in homedir-files into the home directory.
for path in ${DOTFILES[@]}
do
	cp -R $path $HOME/$path
done

# If it doesn't already exist, make a file for local ZSH config.
touch $HOME/.zsh_local
