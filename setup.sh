#!/bin/bash -e

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true

bold=$(tput bold)
normal=$(tput sgr0)

set -x

{
	echo "${bold}1.0 Basic setup${normal}"
	echo "${bold}1.1 Move files indicated in homedir-files into the home directory.${normal}"
} 2>/dev/null
for path in ${DOTFILES[@]}
do
	cp -R $path $HOME/$path
done
mkdir -p $HOME/tmp

{
	echo
	echo "${bold}1.2 If it doesn't already exist, make a file for local ZSH config.${normal}"
} 2>/dev/null
touch $HOME/.zsh_local

{
	echo
	echo "${bold}1.3 Install basic utilities needed for setup.${normal}"
} 2>/dev/null
sudo apt install curl vim

{
	echo; echo
	echo "${bold}2.0 Vim setup${normal}"
	echo "${bold}2.1 Install vim-plug.${normal}"
} 2>/dev/null
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]
then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

{
	echo
	echo "${bold}2.2 Install packages using vim-plug.${normal}"
} 2>/dev/null
vim +PlugInstall +qall


{
	echo; echo
	echo "${bold}3.0 ZSH setup${normal}"
	echo "${bold}3.1 Create directory for logs.${normal}"
} 2>/dev/null
mkdir -p $HOME/.logs

{
	echo
	echo "${bold}3.2 Install needed packages.${normal}"
} 2>/dev/null
sudo apt install python-is-python3 tmux gcc zsh

{
	echo
	echo "${bold}3.3 Set up zsh-git-prompt.${normal}"
} 2>/dev/null
mkdir -p $HOME/.zsh/
if [ ! -d $HOME/.zsh/zsh-git-prompt ]
then
	git clone http://github.com/zsh-git-prompt/zsh-git-prompt $HOME/.zsh/zsh-git-prompt
fi

{
	echo
	echo "${bold}3.4 Make ZSH the login shell.${normal}"
} 2>/dev/null
shell=$(getent passwd $LOGNAME | cut -d: -f7)
if [ "$shell" != "$(which zsh)" ]
then
	sudo chsh -s "$(which zsh)" $USER
fi


{
	echo; echo
	echo "${bold}4.0 Git stuff -- make sure we're on the newest version!${normal}"
} 2>/dev/null
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git


{
	echo; echo
	echo "${bold}5.0 Neovim setup${normal}";
	echo "${bold}5.1 Install Neovim.${normal}"
} 2>/dev/null
if [ ! -f $HOME/.local/bin/nvim ]
then
	wget -P $HOME/tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
	tar -C $HOME/tmp -zxvf $HOME/tmp/nvim-linux64.tar.gz
	mkdir -p $HOME/.local/bin
	mv $HOME/tmp/nvim-linux64 $HOME/.local/bin/
	ln -s $HOME/.local/bin/nvim-linux64/bin/nvim $HOME/.local/bin/nvim
	rm $HOME/tmp/nvim-linux64.tar.gz
fi

{
	echo
	echo "${bold}5.2 Set up nvim config.${normal}"
} 2>/dev/null
mkdir -p $HOME/.config
cp -R .config/nvim $HOME/.config

{
	echo
	echo "${bold}5.3 Install nvim plugins.${normal}"
} 2>/dev/null
$HOME/.local/bin/nvim +PlugInstall +qall


{
	echo
	echo "${bold}6.0 Install atuin.sh.${normal}"
} 2>/dev/null
if ! command -v atuin &> /dev/null
then
	curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

{
	echo
	echo "${bold}6.1 Install obsidian.md.${normal}"
} 2>/dev/null
sudo apt install flatpak
if ! flatpak info md.obsidian.Obsidian 2>/dev/null
then
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub md.obsidian.Obsidian
fi

## Todo Area
# This section is for stuff that I haven't done yet, but want to.
# TODO: Disable bell (https://linuxconfig.org/turn-off-beep-bell-on-linux-terminal)
# TODO: Install i3wm and apply my config.
# TODO: Swap capslock and escape.
# TODO: Set gnome-terminal color settings.
# TODO: Adjust screen magnification.
# TODO: Reverse trackpad direction.
# TODO: skip adding ppa:git-core/ppa if it's already there
