export EDITOR="vim"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

parse_git_branch() {
	BRANCH=$( git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' )
	if [ -n "$BRANCH" ]; then
		#echo "\e[1;33m[$BRANCH]\e[1;37m"
		echo "[$BRANCH]"
	fi
}

export PS1='\[\e[1;37m\][\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;36m\]\w\[\e[1;37m\]]$(parse_git_branch)$ \[\e[0m\]'

pgrep() {
	ps aux | grep $1 | grep -v grep
}

pkill() {
	local pid
	pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
	kill -9 $pid
	echo -n "Killed $1 (process $pid)"
}

set_screen_path() {
	screen -X chdir "`pwd`"
}

# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -lAhp'
alias la='ls -A'
alias l='ls -CF'

alias directory_tree="find . -type d -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"


# Short command vi will open macvim if it exists, else it will alias to vim
hash mvim 2>&- && { alias vi=mvim; } || { alias vi=vim; }

# mvim command will return to the Terminal upon exit
hash mvim 2>&- && { alias mvim='mvim --nomru -c "au VimLeave * !open -a Terminal"'; }

hash tree 2>&- || { alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"; }
hash hub 2>&- && { alias git=hub; }
hash brew 2>&- && { . `brew --prefix`/etc/bash_completion; }

case $TERM in
    screen*)
    PROMPT_COMMAND=$PROMPT_COMMAND;set_screen_path
   export GSTATUS=$(gitprompt.pl c=%[%e[38\;5\;10m u=%[%e[33m f=%[%e[38\;5\;15m statuscount=1)
    ;;  
esac

export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:~/bin:$PATH
export PATH=$PATH:/Users/dalewis/.drush/drush
