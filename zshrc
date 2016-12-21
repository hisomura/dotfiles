# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -v

FZF_CTRL_R_OPTS='-e'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enhancd config
ENHANCD_FILTER=fzf; export ENHANCD_FILTER

# tmux version < 1.8 なら下記を.bashrcに追加
# export FZF_TMUX=0;

source "${ZDOTDIR:-$HOME}/.local/opt/enhancd/init.sh"
zle -N __enhancd::cd
bindkey '^J' __enhancd::cd
