#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true

for path in ${DOTFILES[@]}
do
	cp -R $path $HOME/$path
done

touch $HOME/.zsh_local
