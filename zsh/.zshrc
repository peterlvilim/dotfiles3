# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zprezto/init.zsh
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.fzf/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/Downloads/nvim/bin/"
export BROWSER="firefox"
export EDITOR="nvr"


source ~/.zpreztorc
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -Uz promptinit
promptinit
prompt powerlevel10k

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

#source ~/.fzf/shell/key-bindings.zsh
#source ~/.fzf/shell/completion.zsh
