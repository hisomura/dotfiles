# ~/.zshrc

# ──────────────── History ────────────────
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ──────────────── Completion ────────────────
autoload -Uz compinit
# Run full check only once per day; use cache otherwise
if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${HOME}/.zcompdump"
fi
if [[ "$ZSH_COMPDUMP"(#qNmh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # Case-insensitive match
zstyle ':completion:*' menu select                      # Arrow-key selection

# ──────────────── Key Bindings (Vim mode) ────────────────
bindkey -v

# ──────────────── Alias ────────────────
alias ll='ls -al'
alias tf='terraform'

# ──────────────── Functions ────────────────
function tmpdir() {
  mkdir -p tmp
  echo '*' > tmp/.gitignore
  touch tmp/memo.md
}

# ──────────────── fzf ────────────────
source <(fzf --zsh)
export FZF_CTRL_R_OPTS='-e'
bindkey '^F' fzf-file-widget  # Avoid collision with tmux prefix

# ──────────────── zoxide ────────────────
if [[ -z "$VSCODE_GIT_ASKPASS_NODE" && -z "$CLAUDECODE" && -z "$MARKER_JUNIE_TERMINAL" ]]; then
  eval "$(zoxide init zsh --cmd cd)"
  zle -N __zoxide_zi
  bindkey '^J' __zoxide_zi
fi

# ──────────────── Google Cloud SDK ────────────────
GOOGLE_CLOUD_SDK_PATH="${HOME}/.local/opt/google-cloud-sdk"
[[ -f "${GOOGLE_CLOUD_SDK_PATH}/path.zsh.inc" ]]       && source "${GOOGLE_CLOUD_SDK_PATH}/path.zsh.inc"
[[ -f "${GOOGLE_CLOUD_SDK_PATH}/completion.zsh.inc" ]]  && source "${GOOGLE_CLOUD_SDK_PATH}/completion.zsh.inc"

# Switch gcloud configuration interactively via fzf
function gcloud-switch() {
  local selected=$(
    gcloud config configurations list \
      --format='table[no-heading](is_active.yesno(yes="[x]",no="[_]"), name, properties.core.account, properties.core.project.yesno(no="(unset)"))' \
      | fzf --select-1 --query="$1" \
      | awk '{print $2}'
  )
  [[ -n "$selected" ]] && gcloud config configurations activate "$selected"
}
zle -N gcloud-switch
bindkey '^g' gcloud-switch

# ──────────────── TERM ────────────────
export TERM=xterm-256color

# ──────────────── Plugins (Homebrew) ────────────────
# NOTE: autosuggestions must be sourced before syntax-highlighting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ──────────────── Prompt (Starship) ────────────────
eval "$(starship init zsh)" 
 
 
