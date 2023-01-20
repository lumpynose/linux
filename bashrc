# append this file to the given/original .bashrc and
# in that file set force_color_prompt to yes (uncomment that line).

if [ "$LOGNAME" = root ] || [ "`id -u`" -eq 0 ] ; then
    PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;34m\]#\033[00m\] '
fi

set -o noclobber
shopt -s failglob

export PATH;		PATH=~/bin:\
~/.local/bin/:\
/usr/bin/:\
/bin/:\
/usr/local/java/jdk-11.0.10/bin/:\
/usr/local/apache-maven-3.6.3/bin/:\
/usr/local/bin/:\
/usr/local/eclipse/\

if [ "$LOGNAME" = root ] || [ "`id -u`" -eq 0 ] ; then
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    alias z=suspend
fi

export AMPY_PORT;	AMPY_PORT=/dev/ttyUSB0
export ESPTOOL_BAUD;    ESPTOOL_BAUD=921600
export ESPTOOL_PORT;    ESPTOOL_PORT=/dev/ttyUSB0
export JAVA_HOME;	JAVA_HOME=/usr/local/java/jdk-11.0.10
export PAGER;		PAGER="less --quit-if-one-screen --ignore-case --no-init"
export SYSTEMD_PAGER;	SYSTEMD_PAGER=''
export VISUAL;		VISUAL=emacs

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
alias python='python3'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

#alias blank='xset s reset;xset s blank;xset s on;xset s 1'

#if test -z "${DISPLAY}"
#then
#    export DISPLAY; DISPLAY=:0
#    echo -n "" ;
#fi

# python
# source ~/env/bin/activate
