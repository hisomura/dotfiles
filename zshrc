### Prezto
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -v

FZF_CTRL_R_OPTS='-e'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^F' fzf-file-widget #tmuxでprefixを潰さないための設定


### enhancd config
ENHANCD_FILTER=fzf; export ENHANCD_FILTER
source "${ZDOTDIR:-$HOME}/.local/opt/enhancd/init.sh"
function __my-command::enhancd() {
  __enhancd::cd
  zle reset-prompt
}

zle -N __my-command::enhancd
bindkey '^J' __my-command::enhancd

### jump project directories
function __ghq-list::cd() {
  local project_dirs=$(find ~/projects -maxdepth 1 -mindepth 1 -type d)
  local ghq_dirs=$(ghq list -p)
  local target_dir="$(echo $project_dirs$ghq_dirs | sed -e "s#$(echo ~)##g"| fzf)"

  if [ -n ~/$target_dir ]; then
    builtin cd ~/$target_dir
  fi
  zle reset-prompt
}
zle -N __ghq-list::cd
bindkey '^o' __ghq-list::cd


### less
export LESSCHARSET=utf-8


### tmux
export TERM=xterm-256color


### MVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

