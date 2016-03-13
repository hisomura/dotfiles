if [ `uname` = "Darwin" ]; then
  export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
  SHELL=/usr/local/bin/zsh
elif [ `uname` = "Linux" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi

  if [ -f ~/.local/bin/zsh ]; then
      SHELL=~/.local/bin/zsh
  fi

  if [ -f /bin/zsh ]; then
      SHELL=/bin/zsh
  fi

  if [ -e "${HOME}/.pyenv" ]; then
      export PYENV_ROOT="${HOME}/.pyenv"
      export PATH="${PYENV_ROOT}/bin:$PATH"
      eval "$(pyenv init -)"
  fi

  if [ -e "${HOME}/.rbenv" ]; then
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init -)"
  fi

  if [ -e "$HOME/.composer/vendor/bin" ]; then
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init -)"
  fi

  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="$HOME/.local/bin:$HOME/local/bin:$PATH"

fi

alias tmux='tmux -2' #bashrc使わないからここに書く
