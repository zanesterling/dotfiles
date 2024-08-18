# Set up the prompt
source ~/.zsh/zsh-git-prompt/zshrc.sh
export PROMPT=' $(hostname) %F{blue}%#%f '
export RPROMPT='$(git_super_status) %~'

setopt histignorealldups sharehistory

export EDITOR=nvim
set -o vi
bindkey -M vicmd '?' history-incremental-search-backward
bindkey '' history-incremental-search-backward

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source ~/dotfiles/aliases.sh

# 256color support for tmux
export CLICOLOR=1
[ -n "$TMUX" ] && export TERM='screen-256color'

export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'

# For sdl2 in rust
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

unset PYTHONPATH

# Prompt command
export HISTORY_PATH=$HOME/.logs
precmd() {
	if [ "$(id -u)" -ne 0 ]
	then
		echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history -1)" >> $HISTORY_PATH/bash-history-$(date "+%Y-%m-%d").log
	fi
}

export PATH=$PATH:$HOME/.local/bin/


# Run any local-specific customizations.
source ~/.zsh_local

# Setup for atuin.sh.
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

# Swap capslock and escape.
/usr/bin/setxkbmap -option caps:swapescape
