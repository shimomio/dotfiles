
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias 'll'='ls -l'
set -o vi

if [ -f ~/.bashrc ] ; then
	. ~/.bashrc
fi

if [[ -s /Users/a12213/.nvm/nvm.sh ]] ; then
	source /Users/a12213/.nvm/nvm.sh
fi
