#!/bin/sh

DOT_FILES=(
 'asdfrc'
 'editrc'
 'ideavimrc'
 'inputrc'
 'myclirc'
 'tmux.conf'
 'vimrc'
 'vsvimrc'
 'zshrc'
 'zshenv'
 'zwslrc'
)

ln -s ~/dotfiles/claude/agents ~/.claude/agents
ln -s ~/dotfiles/claude/commands ~/.claude/commands
ln -s ~/dotfiles/claude/skills ~/.claude/skills
ln -s ~/dotfiles/claude/settings.json ~/.claude/settings.json

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

chsh -s $(which zsh)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=$HOME/dotfiles/Brewfile


mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/opt

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
