set -o noclobber

shopt -s failglob

export PAGER;   PAGER=more
export PATH;    PATH=~/bin:/usr/local/bin:/usr/bin:/bin:
export DISPLAY; DISPLAY=:0
export VISUAL;  VISUAL=emacs

alias less='echo "use more"'
alias h='history'

alias cp="cp -i"
alias mv="mv -i"

# python
source ~/env/bin/activate
