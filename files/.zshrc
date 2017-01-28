export ZSH=/root/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

alias cdgit='cd $(git rev-parse --show-toplevel)'

if [ -z "$TMUX" ]; then
  exec tmux
fi
