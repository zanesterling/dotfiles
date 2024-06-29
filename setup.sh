#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true


echo 1.0 Basic setup
echo 1.1 Move files indicated in homedir-files into the home directory.
for path in ${DOTFILES[@]}
do
	cp -R $path $HOME/$path
done
mkdir $HOME/tmp

echo "1.2 If it doesn't already exist, make a file for local ZSH config."
touch $HOME/.zsh_local


echo 2.0 Vim setup
echo 2.1 Install Vundle.
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo 2.2 Install packages using Vundle.
vim +PluginInstall +qall


echo 3.0 ZSH setup
echo 3.1 Create directory for logs.
mkdir -p ~/.logs

echo 3.2 Install needed packages.
sudo apt install python tmux

echo 3.3 Set up zsh-git-prompt.
mkdir -p ~/.zsh/
if [ ! -d ~/.zsh/zsh-git-prompt ]
then
	git clone http://github.com/zsh-git-prompt/zsh-git-prompt ~/.zsh/zsh-git-prompt
fi

echo "4.0 Git stuff -- make sure we're on the newest version!"
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

echo 5.0 Neovim setup
echo Install Neovim.
wget -P $HOME/tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -C $HOME/tmp -zxvf $HOME/tmp/nvim-linux64.tar.gz
mkdir -p $HOME/.local/bin
mv $HOME/tmp/nvim-linux64 $HOME/.local/bin/
rm $HOME/tmp/nvim-linux64.tar.gz

echo Set up nvim config.
mkdir -p $HOME/.config
cp -R .config/nvim $HOME/.config

echo Install nvim plugins.
nvim +PluginInstall +qall

