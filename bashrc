set -o noclobber

shopt -s failglob

export PATH;		PATH=~/bin:\
/usr/bin:\
/bin:\
/usr/local/java/jdk-11.0.10/bin:\
/usr/local/apache-maven-3.6.3/bin:\
/usr/local/bin:\
/usr/local/eclipse/\

export PAGER;		PAGER="less --quit-if-one-screen --ignore-case --no-init"
export JAVA_HOME;	JAVA_HOME=/usr/local/java/jdk-11.0.10
export VISUAL;		VISUAL=emacs
export SYSTEMD_PAGER;	SYSTEMD_PAGER=''

alias blank='xset dpms force off'
alias cp="cp -i"
alias grep='grep --color=auto'
alias h='history'
alias less="less --quit-if-one-screen --ignore-case --no-init"
alias localx='export DISPLAY; DISPLAY=:0'
alias ls='ls --classify --color=auto'
alias mv="mv -i"
alias noblank='xset s reset;xset s noblank;xset s off;xset dpms force on'
alias pav='source ~/env/bin/activate'

#alias blank='xset s reset;xset s blank;xset s on;xset s 1'

#export DISPLAY; DISPLAY=:0
# for remote x; e.g., MobaXterm
if test -z "${DISPLAY}"
then
    export DISPLAY; DISPLAY=:0
fi

# python
# source ~/env/bin/activate
