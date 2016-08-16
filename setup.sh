#!/bin/sh

# bash と zsh のどちらでもディレクトリを取得する方法
# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
# script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

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
  fi
  ln -s $HOME/dotfiles/$file $HOME/.$file
done


# mkdir $HOME/.vim-backup
# mkdir $HOME/.vim-dir
# mkdir $HOME/.vim-undo

# mkdir -p $HOME/.local/bin
# mkdir -p $HOME/.local/opt
#
# cd $HOME/.local/opt
# git clone --depth 1 https://github.com/junegunn/fzf.git
# git clone --depth 1 https://github.com/junegunn/fzf.git
# git clone https://github.com/b4b4r07/enhancd

# これをbash_profileとbashrcに追加する処理を追加する
# if [ -z "${BASHENV_LOADED+x}" -a -f ~/.bashenv ]; then
# 	. ~/.bashenv
# fi
