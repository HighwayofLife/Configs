export EDITOR="vim"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1='\[\e[1;37m\][\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;36m\]\w\[\e[1;37m\]][\[\e[1;33m\]$(parse_git_branch)\[\e[1;37m\]]$ \[\e[0m\]'

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

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

alias ll='ls -lAhp'
alias directory_tree="find . -type d -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias vi=vim

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
