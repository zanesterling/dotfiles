#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true

bold=$(tput bold)
normal=$(tput sgr0)


echo "${bold}1.0 Basic setup${normal}"
echo "${bold}1.1 Move files indicated in homedir-files into the home directory.${normal}"
for path in ${DOTFILES[@]}
do
	cp -R $path $HOME/$path
done
mkdir $HOME/tmp

echo "${bold}1.2 If it doesn't already exist, make a file for local ZSH config.${normal}"
touch $HOME/.zsh_local


echo "${bold}2.0 Vim setup${normal}"
echo "${bold}2.1 Install Vundle.${normal}"
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "${bold}2.2 Install packages using Vundle.${normal}"
vim +PluginInstall +qall


echo "${bold}3.0 ZSH setup${normal}"
echo "${bold}3.1 Create directory for logs.${normal}"
mkdir -p ~/.logs

echo "${bold}3.2 Install needed packages.${normal}"
sudo apt install python tmux

echo "${bold}3.3 Set up zsh-git-prompt.${normal}"
mkdir -p ~/.zsh/
if [ ! -d ~/.zsh/zsh-git-prompt ]
then
	git clone http://github.com/zsh-git-prompt/zsh-git-prompt ~/.zsh/zsh-git-prompt
fi

echo "${bold}4.0 Git stuff -- make sure we're on the newest version!${normal}"
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

echo "${bold}5.0 Neovim setup${normal}"
echo "${bold}Install Neovim.${normal}"
wget -P $HOME/tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -C $HOME/tmp -zxvf $HOME/tmp/nvim-linux64.tar.gz
mkdir -p $HOME/.local/bin
mv $HOME/tmp/nvim-linux64 $HOME/.local/bin/
rm $HOME/tmp/nvim-linux64.tar.gz

echo "${bold}Set up nvim config.${normal}"
mkdir -p $HOME/.config
cp -R .config/nvim $HOME/.config

echo "${bold}Install nvim plugins.${normal}"
nvim +PluginInstall +qall

