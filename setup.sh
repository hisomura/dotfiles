#!/bin/sh

# vim だけ設定する場合のスクリプト

# bash と zsh のどちらでもディレクトリを取得する方法
# http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# .vimrc
if [ -h $HOME/.vimrc ]
then
    rm $HOME/.vimrc
elif [ -e $HOME/.vimrc ]
then
    mv $HOME/.vimrc .vimrc_org
fi
ln -s "$script_dir/files/vimrc" "$HOME/.vimrc"


# filetype plugin 
ftplugin_dir=$HOME/.vim/after/ftplugin
if [ -d $ftpplugin_dir ]
then
    mkdir -p $ftplugin_dir
fi
ftplugin_source_dir=$script_dir/files/vim-ftplugin
for ftplugin in `ls $ftplugin_source_dir`
do
    ln -s "$ftplugin_source_dir/$ftplugin" "$ftplugin_dir/$ftplugin"
done

# neobundle
neobundle_dir=$HOME/.vim/bundle
if [ -d $neobundle_dir ]
then
    mkdir -p $neobundle_dir
fi
git clone https://github.com/Shougo/neobundle.vim $neobundle_dir/neobundle.vim

function update_peco(){
  mkdir $HOME/tmp
  cd $HOME/tmp
  curl -LO https://github.com/peco/peco/releases/download/v0.3.3/peco_linux_amd64.tar.gz
  tar xfvz peco_linux_amd64.tar.gz
  mkdir -p $HOME/.local/bin
  mv $HOME/tmp/peco_linux_amd64/peco $HOME/.local/bin
}

function update_pt(){
  mkdir $HOME/tmp
  cd $HOME/tmp
  curl -LO https://github.com/monochromegane/the_platinum_searcher/releases/download/v1.7.8/pt_linux_amd64.tar.gz
  tar xfvz pt_linux_amd64.tar.gz
  mkdir -p $HOME/.local/bin
  mv $HOME/tmp/pt_linux_amd64/pt $HOME/.local/bin
}

# ここからスタート
setopt EXTENDED_GLOB
for rcfile in `pwd`/files/*(.N); do;
  ln -s "$rcfile" "$HOME/.${rcfile:t}"
done;

mkdir -p "$HOME/.vim/after/ftplugin"
for rcfile in `pwd`/files/vim-ftplugin/*(.N); do;
  ln -s "$rcfile" "$HOME/.vim/after/ftplugin/${rcfile:t}"
done;

mkdir -p $HOME/.vim/bundle
mkdir $HOME/.vim-backup
mkdir $HOME/.vim-dir
mkdir $HOME/.vim-undo
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim

touch $HOME/.cd_history_file

mkdir -p $HOME/.local/bin
mkdir $HOME/tmp

update_peco
update_pt

cd $HOME
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

