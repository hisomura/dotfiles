# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enhancd config
ENHANCD_FILTER=peco; export ENHANCD_FILTER
source "${ZDOTDIR:-$HOME}/.local/opt/enhancd/init.sh"
zle -N __enhancd::cd
bindkey '^J' __enhancd::cd
