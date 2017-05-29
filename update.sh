#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

for df in ${DOTFILES[@]}
do
	cp -R ../$df .
done
