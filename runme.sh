mkdir ~/dev

sudo apt install tmux
brew install tmux

# Set up Vundle et al for Vim.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
