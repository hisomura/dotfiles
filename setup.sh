#!/bin/sh

DOT_FILES=(
 'bash_profile'
 'bashenv'
 'editrc'
 'inputrc'
 'tmux.conf'
 'vimrc'
 'zlogin'
 'zlogout'
 'zpreztorc'
 'zprofile'
 'zshenv'
 'zshrc'
)

for file in ${DOT_FILES[@]}
do
  if [ -h $HOME/.$file ]
  then
    rm $HOME/.$file
  elif [ -e $HOME/.$file ]
  then
    mv $HOME/.$file $HOME/.$file'_org'
    echo old $file to .$file'_org'
  fi
  ln -s $HOME/dotfiles/$file $HOME/.$file
done

git clone --recursive https://github.com/sorin-ionescu/prezto.git "~/.zprezto"

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/opt
cd $HOME/.local/opt
git clone --depth 1 https://github.com/junegunn/fzf.git
fzf/install
git clone https://github.com/b4b4r07/enhancd

# これをbash_profileとbashrcに追加する処理を追加する
# if [ -z "${BASHENV_LOADED+x}" -a -f ~/.bashenv ]; then
# ^ . ~/.bashenv
# fi
