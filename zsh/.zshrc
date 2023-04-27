source ~/.zprezto/init.zsh

source ~/.zpreztorc
# Setup path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.fzf/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/Downloads/nvim/bin/"

export BROWSER="firefox"
export EDITOR="nvr"



alias v="nvim"
alias ls="exa"
alias l="exa"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# Append to history as commands are run and share history between shells
setopt sharehistory

# Emacs keybindings so that ctrl+a and ctrl+e work
set -o emacs

# TODO remove?
source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh
