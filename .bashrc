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

shorten_dir() {
  echo $(perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD})
}

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
export PS1='$(kube_ps1)\[\e[1;37m\][\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;36m\]$(shorten_dir)\[\e[1;37m\]]$(parse_git_branch)\n$ \[\e[0m\]'

set_kube_prompt() {
  # source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  # PS1="$(kube_ps1):\[\e[1;36m\]$(shorten_dir)\[\e[1;37m\]$(parse_git_branch)\[\e[0m\]$ "
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  PS1='$(kube_ps1)'$PS1
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

notify() {
  osascript -e "display notification \"$2\" with title \"$1\""
}

fin() {
  notify "Finished" "Whatever it was doing"
}

# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups
PROMPT_COMMAND='history -a'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=100000
HISTSIZE=100000

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -lAhp'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'

alias directory_tree="find . -type d -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias sed="/usr/local/bin/gsed"
alias ku="kubectl"
alias ctx="kubectx"
alias git=hub

push() {
  GIT_BRANCH=$(git branch | grep "*" | awk '{print $2}')
  git push -u origin ${GIT_BRANCH}
}

pr() {
  push
  hub pull-request
}

# Short command vi will open macvim if it exists, else it will alias to vim
#hash mvim 2>&- && { alias vi=mvim; } || { alias vi=vim; }

# mvim command will return to the Terminal upon exit
#hash mvim 2>&- && { alias mvim='mvim --nomru -c "au VimLeave * !open -a Terminal"'; }

hash tree 2>&- || { alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"; }
# hash hub 2>&- && { alias git=hub; }
# hash brew 2>&- && { . `brew --prefix`/etc/bash_completion; }

export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

case $TERM in
    screen*)
    PROMPT_COMMAND=$PROMPT_COMMAND;set_screen_path
   export GSTATUS=$(gitprompt.pl c=%[%e[38\;5\;10m u=%[%e[33m f=%[%e[38\;5\;15m statuscount=1)
    ;;
esac

export VIMRUNTIME=/usr/local/share/vim/vim81
#export VIMRUNTIME=~/.vim/

# export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:~/bin:$PATH
# export PATH=$PATH:$HOME/.drush/drush
# export PATH=$PATH:/usr/local/share/npm/bin

export GROOVY_HOME=/usr/local/opt/groovy/libexec
export GOPATH=$(go env GOPATH)

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# With Keystone you pass the keystone password.
# echo "Please enter your OpenStack Password: "
# read -s OS_PASSWORD_INPUT
# export OS_PASSWORD=$OS_PASSWORD_INPUT

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=$(brew --prefix ruby)/bin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/$HOME/bin

source "$HOME/lib/azure-cli/az.completion"

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh
