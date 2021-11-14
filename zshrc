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

### ghq + fzf
function __ghq-list::cd() {
  local destination_dir="$(ghq list -p | fzf)"
  if [ -n "$destination_dir" ]; then
    builtin cd $destination_dir
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


### GCP
# The next line updates PATH for the Google Cloud SDK.
if [ -f "${ZDOTDIR:-$HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${ZDOTDIR:-$HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${ZDOTDIR:-$HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${ZDOTDIR:-$HOME}/google-cloud-sdk/completion.zsh.inc"; fi

