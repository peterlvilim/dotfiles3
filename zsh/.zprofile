export EDITOR="nvim"
export BROWSER="firefox"
if [[ $(tty) = /dev/tty1 ]]; then exec startx; fi