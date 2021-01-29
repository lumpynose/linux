set -o noclobber

shopt -s failglob

export PAGER;   PAGER=more
export PATH;    PATH=~/bin:/usr/local/bin:/usr/bin:/bin:
export DISPLAY; DISPLAY=:0
export VISUAL;  VISUAL=emacs

alias less='echo "use more"'
alias h='history'
alias ls='ls --classify'
alias pav='source ~/env/bin/activate'
alias blank='xset s reset;xset s blank;xset s on;xset s 1'
alias noblank='xset s reset;xset s noblank;xset s off'

alias cp="cp -i"
alias mv="mv -i"

# python
# source ~/env/bin/activate
