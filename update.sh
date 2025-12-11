#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

for path in ${DOTFILES[@]}
do
	cp -R $HOME/$path $path
done

cp ~/.config/i3/config i3/config
cp ~/.config/sway/config sway/config
cp ~/.config/foot/config foot/config
cp ~/.config/picom/picom.conf picom/picom.conf
cp ~/.config/ghostty/config ghostty/config
