#!/bin/bash -e

read -a DOTFILES <<< $(cat homedir-files)

dryrun=true

bold=$(tput bold)
normal=$(tput sgr0)

apt_packages=(curl vim python-is-python3 tmux gcc zsh flatpak ripgrep picom hsetroot)

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
mkdir -p $HOME/.zane

{
	echo
	echo "${bold}1.2 If it doesn't already exist, make a file for local ZSH config.${normal}"
} 2>/dev/null
touch $HOME/.zsh_local

{
	echo
	echo "${bold}1.3 Install needed packages.${normal}"
} 2>/dev/null
sudo apt install "${apt_packages[@]}"

{
	echo
	echo "${bold}1.4 Set up i3 config.${normal}"
} 2>/dev/null
mkdir -p ~/.config/i3/
cp i3/config ~/.config/i3/config

{
	echo
	echo "${bold}1.5 Set up picom config.${normal}"
} 2>/dev/null
mkdir -p ~/.config/picom/
cp i3/config ~/.config/picom/picom.conf

{
	echo
	echo "${bold}1.6 Set up swaywm config.${normal}"
} 2>/dev/null
mkdir -p ~/.config/sway/
cp sway/config ~/.config/sway/config

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
	echo "${bold}3.2 Set up zsh-git-prompt.${normal}"
} 2>/dev/null
mkdir -p $HOME/.zsh/
if [ ! -d $HOME/.zsh/zsh-git-prompt ]
then
	git clone http://github.com/zsh-git-prompt/zsh-git-prompt $HOME/.zsh/zsh-git-prompt
fi

{
	echo
	echo "${bold}3.3 Make ZSH the login shell.${normal}"
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
# Add git apt repo if it's not already added.
grep -h "^deb.*git-core/ppa" /etc/apt/sources.list.d/* > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
	echo "adding git apt repo" 2> /dev/null
	sudo add-apt-repository ppa:git-core/ppa
	sudo apt update
else
	echo "git apt repo already added" 2> /dev/null
fi
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
if ! flatpak info md.obsidian.Obsidian 2>/dev/null
then
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub md.obsidian.Obsidian
fi

{
	echo
	echo "${bold}6.2 Install i3wm.${normal}"
}
if ! command -v i3
then
	# This is the setup for Ubuntu.
	# TODO: When setting up a non-Ubuntu machine, add a check for OS.
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
	sudo apt install ./keyring.deb
	echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt update
	sudo apt install i3wm
fi

{
	echo
	echo "${bold}6.3 Install Rust and WASM.${normal}"
} 2>/dev/null
if ! command -v rustup
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if ! command -v wasm-pack
then
	curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
fi

{
	echo
	echo "${bold}6.4 Set up color scheme.${normal}"
} 2>/dev/null
if [ ! -f ~/.zane/colorscheme ]
then
	sudo apt install dconf-cli
	rm -rf ~/tmp/gnome-terminal
	git clone https://github.com/dracula/gnome-terminal ~/tmp/gnome-terminal
	pushd ~/tmp/gnome-terminal
	./install.sh
	popd
	rm -rf ~/tmp/gnome-terminal
	echo darcula > ~/.zane/colorscheme
fi

{
	echo
	echo "${bold}6.5 Install hexyl, bat, and friends.${normal}"
} 2>/dev/null
if [ ! -f ~/.local/bin/hexyl ]
then
	if [[ "$OSTYPE" == "darwin"* ]] ; then
		brew install hexyl bat fd numbat ijq bufbuild/buf/buf
	elif [[ "$OSTYPE" == "darwin"* ]] ; then
		sudo apt install hexyl bat fd numbat ijq
		BIN="$HOME/.local/bin/" && \
		VERSION="1.50.1" && \
		curl -sSL \
		"https://github.com/bufbuild/buf/releases/download/v${VERSION}/buf-$(uname -s)-$(uname -m)" \
		-o "${BIN}/buf" && \
		chmod +x "${BIN}/buf"
	fi
fi

{
	echo; echo
	echo "${bold}7.0 Ghostty setup${normal}";
	echo "${bold}7.1 Install Ghostty.${normal}"
} 2>/dev/null
if [ ! -f $HOME/.local/bin/ghostty ]
then
	if [[ "$OSTYPE" == "darwin"* ]] ; then # macos
		brew install --cask ghostty
		ln -s $(which ghostty) $HOME/.local/bin/ghostty
	elif [[ "$OSTYPE" = "linux-gnu"* ]] ; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
		ln -s $(which ghostty) $HOME/.local/bin/ghostty
	fi
fi

{
	echo "${bold}7.2 Set up Ghostty config.${normal}";
} 2>/dev/null
cp -R .config/ghostty $HOME/.config/

## Todo Area
# This section is for stuff that I haven't done yet, but want to.
#
# TODO: Disable bell (https://linuxconfig.org/turn-off-beep-bell-on-linux-terminal)
# TODO: Separate out linux vs mac packages.
