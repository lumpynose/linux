# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#####################################################################

if [ "$LOGNAME" = root ] || [ "`id -u`" -eq 0 ] ; then
    PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;34m\]#\033[00m\] '
fi

set -o noclobber
shopt -s failglob

export PATH;		\
PATH=~/bin:\
/usr/local/java/graalvm-jdk-21.0.2+13.1/bin:\
~/.local/bin:\
/usr/bin:\
/bin:\
/usr/local/bin:

if [ "$LOGNAME" = root ] || [ "`id -u`" -eq 0 ] ; then
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    alias z=suspend
fi

export AMPY_PORT=/dev/ttyUSB0
export ESPTOOL_BAUD=921600
export ESPTOOL_PORT=/dev/ttyUSB0
export PAGER="less --quit-if-one-screen --ignore-case --no-init"
export SYSTEMD_PAGER=''
export VISUAL=emacs
#export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export JAVA_HOME=/usr/local/java/graalvm-jdk-21.0.2+13.1

alias blank='xset dpms force off'
alias clean='find . -name "*~" -a -print -a -exec rm {} \;'
alias cp='cp -i'
alias date='date --rfc-email'
alias grep='grep --color=auto'
alias h='history'
alias less='less --quit-if-one-screen --ignore-case --no-init'
alias localx='export DISPLAY; DISPLAY=:0'
alias ls='ls --classify --color=auto'
alias mv='mv -i'
alias noblank='xset s reset;xset s noblank;xset s off;xset dpms force on'
alias pav='source ~/.venv/bin/activate'
alias update='sudo sh -c "(echo update;apt-get update;echo upgrade;apt-get dist-upgrade;echo autoremove;apt-get autoremove)"'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

#alias blank='xset s reset;xset s blank;xset s on;xset s 1'

#if test -z "${DISPLAY}"
#then
#    export DISPLAY; DISPLAY=:0
#    echo -n "" ;
#fi

# python
# source ~/env/bin/activate

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
