source ~/.zprezto/init.zsh
source ~/.zpreztorc
source ~/.secrets

# Setup path
export PATH="/opt/homebrew/bin/:$PATH"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.fzf/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/Downloads/nvim/bin/"

export BROWSER="/Applications/Firefox.app/Contents/MacOS/firefox"
export EDITOR="nvr"

alias v="nvim"
alias ls="exa"
alias l="exa"

# TODO prezto sharing
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# Append to history as commands are run and share history between shells

# Emacs keybindings so that ctrl+a and ctrl+e work
set -o emacs
