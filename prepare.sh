#!/bin/bash

#setup vim
f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HOME
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
ln -s $f/.vimrc
ln -s $f/.vim
#setup zsh
ln -s $f/.zshrc

#setup xmonad
rm -rf $HOME/.xmonad
mkdir -p $HOME/.xmonad
pushd $HOME/.xmonad
ln -s $f/.xmonad/xmonad.hs
ln -s $f/.xmonad/xmonad.startup
popd
xmonad --recompile

cd $f

#setup vim plugins
vim +BundleInstall +qall
