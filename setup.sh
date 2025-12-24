#!/bin/sh

DOT_FILES=(
 'asdfrc'
 'editrc'
 'gvimrc'
 'ideavimrc'
 'inputrc'
 'myclirc'
 'tmux.conf'
 'vimrc'
 'vsvimrc'
 'zlogin'
 'zlogout'
 'zpreztorc'
 'zshrc'
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

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
cp $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv
cp $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile

chsh -s $(which zsh)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install \
    tmux \
    fzf \
    zoxide \
    fd \
    rg \
    jq \
    asdf \
    git \
    gh \
    curl \
    python \
    mycli \
    neovim \
    lazygit \
    luarocks 
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/opt

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
