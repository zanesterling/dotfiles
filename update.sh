#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

for path in ${DOTFILES[@]}
do
	cp -R ../$path $path
done

cp ~/.config/i3/config i3/config
cp ~/.config/picom/picom.conf picom/picom.conf
