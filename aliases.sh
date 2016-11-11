alias e='$EDITOR'

alias l='ls -lhG'
alias la='l -a'
alias ll='la'

alias grep='grep --color'
alias grepc='grep --color=always'
alias grepn='grep --color=never'

alias rld='source ~/.zshrc'
alias fix='vim ~/config/aliases.sh'
alias zfix='vim ~/.zshrc'
alias vfix='vim ~/.vimrc'
alias vwfix='vim ~/.vim/ftplugin/vimwiki.vim'
alias tfix='vim ~/.tmux.conf'
alias sfix='vim ~/.ssh/config'

alias hk='cd ~/hacking'
alias tmp='cd ~/tmp'
alias gzdir='cd /usr/local/Cellar/gazebo7/7.0.0/share/gazebo-7'

alias gp='git push'
alias gl='git pull'
alias ga='git add'
alias gc='git commit -v'
alias gs='git status -s'
alias gst='git status'
alias gd='git diff --color'
alias gr='git rm'
alias gb='git branch --color'
alias gm='git merge'
alias gcl='git clone'
alias gch='git checkout'
alias glg='git log --color'
alias grb='git rebase'
alias gsh='git stash'
alias gra='git remote add'

alias s='gs'
alias d='gd'
alias c='gc'
alias a='ga'
alias p='gp'
alias b='gb'
alias ca='c -a'
alias sd='s;echo;d'
alias st='gst'
alias pupstm='p -u origin $(git rev-parse --abbrev-ref HEAD)'

alias tmux='tmux -2'
alias ta='tmux attach'
alias td='tmux detach'

alias antb='ant build'
alias antr='ant run'
alias bar='ant bar'

alias homer='ssh -x zane.sterling@homer.stuy.edu'
alias rando='ssh rando'

alias cdiff='colordiff'
alias mongboot='mongod --fork --logpath ~/tmp/mongod.log'
alias clean='make clean'
alias dubdc='dub --compiler=ldc2'

alias od='objdump -x86-asm-syntax=intel'
alias i386-gcc='gcc-5'
alias tw='task -low'
alias twa='task'
alias twl='task +low'
alias tws='task sync'

check_in() {
	touch ~/config/checked-in
}

check_out() {
	~/config/open-journal.sh
	rm -f ~/config/checked-in
}

is_checked_in() {
	if [ -f ~/config/checked-in ]; then
		echo checked in
	else
		echo checked out
	fi
}

alias ci='check_in'
alias co='check_out'
alias ici='is_checked_in'
alias note='vim -C "call vimwiki#diary#make_note(v:count1)" + -c "r \!date \"+\\%n= \\%H:\\%M=\\%n\""'
