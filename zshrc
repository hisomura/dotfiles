### Prezto
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### Ignore 
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

### Vim mode
bindkey -v

### fzf
source <(fzf --zsh)
FZF_CTRL_R_OPTS='-e'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^F' fzf-file-widget #tmuxでprefixを潰さないための設定

### zoxide
if [[ -z "$VSCODE_GIT_ASKPASS_NODE" && -z "$CLAUDECODE" && -z "$MARKER_JUNIE_TERMINAL" ]]; then
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

### asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

### Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
GOOGLE_CLOUD_SDK_PATH="${HOME}/.local/opt/google-cloud-sdk"
if [ -f "${GOOGLE_CLOUD_SDK_PATH}/path.zsh.inc" ]; then . "${GOOGLE_CLOUD_SDK_PATH}/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${GOOGLE_CLOUD_SDK_PATH}/completion.zsh.inc" ]; then . "${GOOGLE_CLOUD_SDK_PATH}/completion.zsh.inc"; fi
