alias e='$EDITOR'

alias l='ls -lhG'
alias la='l -a'
alias ll='la'
alias lt='l -t'

alias grep='grep --color'
alias grepc='grep --color=always'
alias grepn='grep --color=never'

alias rld='source ~/.zshrc'
alias fix='vim ~/dotfiles/aliases.sh'
alias zfix='vim ~/.zshrc'
alias vfix='vim ~/.vimrc'
alias vwfix='vim ~/.vim/ftplugin/vimwiki.vim'
alias tfix='vim ~/.tmux.conf'
alias sfix='vim ~/.ssh/config'

alias dev='cd ~/dev'
alias hk='dev; cd projects'
alias school='dev; cd school'
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
alias pupstrm='p -u origin $(git rev-parse --abbrev-ref HEAD)'
alias drop='git checkout --'

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

alias twa='task'
alias twl='task -must -should ready'
alias tw_most='task -private'
alias twd='task add'
alias tws='task sync'

alias next='task list +next'
alias nx='next'
alias goals='task +goal'
alias cal='task calendar'

tw() {
	if [ $# -eq 0 ]
		then tw_most list
	else
		tw_most $@
	fi
}

proj() {
	if [ $# -eq 0 ]
		then task summary
	else
		tw_most project:$@
	fi
}

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

note() {
	vim -c 'silent call vimwiki#diary#make_note(v:count1)' + -c 'r !date "+\%n== \%H:\%M ==\%n"'
}
alias jrnl='vim -c "silent call vimwiki#diary#make_note(v:count1)"'
alias diary='jrnl'
alias wiki='vim -c "silent call vimwiki#base#goto_index(v:count1)"'
alias learn='vim ~/vimwiki/Learn.wiki' # TODO(): Find the vimwiki command to open a page.

alias rustdoc='open /usr/local/share/doc/rust/html/index.html'

alias hub=git

alias agc='ag --color'

# Python stuff
alias ipy2='ipython2'
alias ipy3='ipython3'
alias venv2='~/Library/Python/2.7/bin/virtualenv'
alias venv3='~/Library/Python/3.6/bin/virtualenv'
alias py2='python2'
alias py3='python3'
