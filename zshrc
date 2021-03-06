# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -v

FZF_CTRL_R_OPTS='-e'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^F' fzf-file-widget #tmuxでprefixを潰さないための設定

# enhancd config
ENHANCD_FILTER=fzf; export ENHANCD_FILTER

source "${ZDOTDIR:-$HOME}/.local/opt/enhancd/init.sh"
zle -N __enhancd::cd
bindkey '^J' __enhancd::cd

# less
export LESSCHARSET=utf-8

# tmux
export TERM=xterm-256color

# wsltty
# https://github.com/mintty/wsltty/issues/136
[ -z "$ZSH_VERSION" ] || export SHELL=$(which zsh)
