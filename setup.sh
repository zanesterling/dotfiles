#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true


## 1.0 Basic setup
# 1.1 Move files indicated in homedir-files into the home directory.
for path in ${DOTFILES[@]}
do
	cp -R $path $HOME/$path
done

# 1.2 If it doesn't already exist, make a file for local ZSH config.
touch $HOME/.zsh_local


## 2.0 Vim setup
# 2.1 Install Vundle.
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# 2.2 Install packages using Vundle.
vim +PluginInstall +qall


## 3.0 ZSH setup
# 3.1 Create directory for logs.
mkdir -p ~/.logs

# 3.2 Install needed packages.
sudo apt install python tmux
