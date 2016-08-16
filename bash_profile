if [ `uname` = "Darwin" ]; then
  export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
  SHELL=/usr/local/bin/zsh
elif [ `uname` = "Linux" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

alias tmux='tmux -2' #bashrc使わないからここに書く

if [ -z "${BASHENV_LOADED+x}" -a -f ~/.bashenv ]; then
	. ~/.bashenv
fi
