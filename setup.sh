#!/bin/sh

DOT_FILES=(
 'editrc'
 'inputrc'
 'tmux.conf'
 'vimrc'
 'zlogin'
 'zlogout'
 'zpreztorc'
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

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
cp $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
cp $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/opt
cd $HOME/.local/opt
git clone --depth 1 https://github.com/junegunn/fzf.git
fzf/install
git clone https://github.com/b4b4r07/enhancd

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

chsh -s $(which zsh)
