#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true

bold=$(tput bold)
normal=$(tput sgr0)


echo "${bold}1.0 Basic setup${normal}"
echo "${bold}1.1 Move files indicated in homedir-files into the home directory.${normal}"
set -v
	for path in ${DOTFILES[@]}
	do
		cp -R $path $HOME/$path
	done
	mkdir -p $HOME/tmp
{ set +v; } &> /dev/null

echo "${bold}1.2 If it doesn't already exist, make a file for local ZSH config.${normal}"
set -v
	touch $HOME/.zsh_local
{ set +v; } &> /dev/null


echo "${bold}2.0 Vim setup${normal}"
echo "${bold}2.1 Install vim-plug.${normal}"
set -v
	if [ ! -f "$HOME/.vim/autoload/plug.vim" ]
	then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
{ set +v; } &> /dev/null

echo "${bold}2.2 Install packages using vim-plug.${normal}"
set -v
	vim +PlugInstall +qall
{ set +v; } &> /dev/null


echo "${bold}3.0 ZSH setup${normal}"
echo "${bold}3.1 Create directory for logs.${normal}"
set -v
	mkdir -p $HOME/.logs
{ set +v; } &> /dev/null

echo "${bold}3.2 Install needed packages.${normal}"
set -v
	sudo apt install python-is-python3 tmux
{ set +v; } &> /dev/null

echo "${bold}3.3 Set up zsh-git-prompt.${normal}"
set -v
	mkdir -p $HOME/.zsh/
	if [ ! -d $HOME/.zsh/zsh-git-prompt ]
	then
		git clone http://github.com/zsh-git-prompt/zsh-git-prompt $HOME/.zsh/zsh-git-prompt
	fi
{ set +v; } &> /dev/null


echo "${bold}4.0 Git stuff -- make sure we're on the newest version!${normal}"
set -v
	sudo add-apt-repository ppa:git-core/ppa
	sudo apt update
	sudo apt install git
{ set +v; } &> /dev/null


echo "${bold}5.0 Neovim setup${normal}"
echo "${bold}5.1 Install Neovim.${normal}"
set -v
	if [ ! -f $HOME/.local/bin/nvim ]
	then
		wget -P $HOME/tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
		tar -C $HOME/tmp -zxvf $HOME/tmp/nvim-linux64.tar.gz
		mkdir -p $HOME/.local/bin
		mv $HOME/tmp/nvim-linux64/bin/nvim $HOME/.local/bin/
		rm $HOME/tmp/nvim-linux64.tar.gz
	fi
{ set +v; } &> /dev/null

echo "${bold}5.2 Set up nvim config.${normal}"
set -v
	mkdir -p $HOME/.config
	cp -R .config/nvim $HOME/.config
{ set +v; } &> /dev/null

echo "${bold}5.3 Install nvim plugins.${normal}"
set -v
	$HOME/.local/bin/nvim +PluginInstall +qall
{ set +v; } &> /dev/null

