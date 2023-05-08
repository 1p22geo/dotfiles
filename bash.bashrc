#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

# PS1='[\u@\h \W]\$ '

# [\033[01;31m\]
#[\033[01;31m\]
#  [\033[01;31m\]
#
# [\033[01;31m\]

alias lsa='ls -la'

if [ $UID -eq 0 ] ; then
	PS1='\[\033[01;31m\]+--\[\033[01;32m\][\u@\h]\[\033[01;31m\]--\[\033[01;36m\](\w)\[\033[01;31m\]--\[\033[01;33m\](\s)\n\[\033[01;31m\]+--\$ \[\033[00m\]'
#	PS1='[\033[01;31m\]+--\e[32m[\u@\h]\e[31m--\e[36m(\W)\e[31m--\e[35m(\s)\n\e[31m+-\$ \e[0m'
else
	#PS1='[\u@\h \W]\$ '	
	PS1='\[\033[01;00m\]+--\[\033[01;32m\][\u@\h]\[\033[01;00m\]--\[\033[01;36m\](\w)\[\033[01;00m\]--\[\033[01;33m\](\s)\n\[\033[01;00m\]+--\$ \[\033[00m\]'
#	PS1='\e[0m+--\e[32m[\u@\h]\e[0m--\e[36m(\W)\e[0m--\e[35m(\s)\n\e[0m+-\$ \e[0m'
fi
# \e[31m--\e[33m(\W)\

case ${TERM} in
  Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')

    ;;
  screen*)
    PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
esac

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi
