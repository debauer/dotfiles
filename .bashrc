#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\w\[\033[0;32m\] [$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

export LS_OPTIONS='--color=auto -h'
export EDITOR='nano'
export PATH="$PATH:/home/bauer/toolchain/flutter/bin"
export PATH="$PATH:/home/bauer/bin"

unset use_color safe_term match_lhs sh

alias DISPLAY_INTERN="eDP1"
alias DISPLAY_EXTERNR="DP1"
alias DISPLAY_EXTERNL="DP2"
alias DISPLAY_HDMI="HDMI1"

alias cp="cp -i"                          # confirm before overwriting something
alias lsh='ls -lah'
alias dfc="df -h | grep -vwE '(overlay|shm|tmpfs)'" # df clean
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias grep='grep --color'
alias pacman='pacman --color=auto'
alias dmesg='dmesg -T --color'
alias setenv='~/setEnv.sh'
alias dotfiles='/usr/bin/git --git-dir=.dotfiles --work-tree=.'
alias dot='dotfiles'
alias dotac='dot add -u && dot commit -m '
alias gitk="gitk --all"
alias subl3="subl3 -a"
alias subl="subl3 -a"
alias yaoutSkipCheks='yaourt --m-arg "--skipchecksums --skippgpcheck'
alias set-git-github='git config user.email "debauer@users.noreply.github.com" && git config user.name "debauer"'

# SSH Connections
alias ssh-extern-herbert='ssh root@debauer.selfhost.co -p 8022'
alias ssh-extern-herbert-with-ports='ssh -g -L43000:localhost:3000 root@debauer.selfhost.co -p 8022'
  
alias ssh-home-herbert='ssh root@192.168.1.35'
alias ssh-fablab-felix='ssh root@192.168.1.6'
alias ssh-fablab-mail='ssh root@195.201.127.20'
alias ssh-fablab-cloud='ssh root@cloud.fablab-karlsruhe.de'
alias ssh-mail='ssh root@116.203.48.43'
alias ssh-web='ssh root@78.47.147.189'
alias ssh-fablab-www='ssh root@www.fablab-karlsruhe.de'
alias vdtproxy='cd ~/projects/rhmi-exchange-devbridge; nvm use v8; node proxy.js'

alias ssh-warden='ssh bauer@warden.synyx.net'
alias ssh-vdt='ssh root@160.48.199.99'
alias ssh-rack='ssh root@headunit-router.synyx.coffee -p 50022'
alias ssh-koffer='ssh root@headunit-router.synyx.coffee -p 40022'



alias showcores='watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""'
alias showfoldersize='du --max-depth=1 -h | sort -n -r'
alias showbiggestfiles="find / -type f -printf \"%k\t %p\n\" 2>/dev/null | sort -rn | awk '{printf(\"%7.1f GB\t%s\n\", ($1/1024)/1024,$0)}' | head -15"


xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases
# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
entpacken ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.xz)    tar xf $1    ;;
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
source /usr/share/nvm/init-nvm.sh

xset -b #disable terminal beep

export CUDA_INSTALL_DIR=/opt/cuda-10.1
