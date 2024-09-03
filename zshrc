### Prezto
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### Vim mode
bindkey -v

FZF_CTRL_R_OPTS='-e'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^F' fzf-file-widget #tmuxでprefixを潰さないための設定

### zoxide
if [[ -z "$VSCODE_GIT_ASKPASS_NODE" ]]; then
  eval "$(zoxide init zsh --cmd cd)"
  zle -N __zoxide_zi
  bindkey '^J' __zoxide_zi
fi

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
