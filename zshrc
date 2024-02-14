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


# https://blog.pokutuna.com/entry/gcloud-switch-configurations
### switching google project
function gcloud-switch() {
  local selected=$(
    gcloud config configurations list --format='table[no-heading](is_active.yesno(yes="[x]",no="[_]"), name, properties.core.account, properties.core.project.yesno(no="(unset)"))' \
      | fzf --select-1 --query="$1" \
      | awk '{print $2}'
  )
  if [ -n "$selected" ]; then
    gcloud config configurations activate $selected
  fi
}
zle -N gcloud-switch
bindkey '^g' gcloud-switch


### less
export LESSCHARSET=utf-8


### tmux
export TERM=xterm-256color


### MVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

