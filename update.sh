#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

for path in ${DOTFILES[@]}
do
	cp -R ../$path $path
done
