#!/bin/bash

#setup vim
f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HOME
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
ln -s $f/.vimrc
ln -s $f/.vim

#setup xmonad
rm -rf $HOME/.xmonad
mkdir -p $HOME/.xmonad
pushd $HOME/.xmonad
ln -s $f/.xmonad/xmonad.hs
ln -s $f/.xmonad/xmonad.startup
popd
xmonad --recompile

cd $f

#setup pyclewn
wget
"http://switch.dl.sourceforge.net/project/pyclewn/pyclewn-1.10/pyclewn-
1.10.py2.tar.gz" -O pyclewn-1.10.py2.tar.gz
tar -zxvf pyclewn-1.10.py2.tar.gz
cd pyclewn-1.10.py2
vimdir=$f/.vim/bundle/pyclewn python setup.py install --force --home=$f/.vim/bundle/pyclewn-bin
cd ..
#setup vim plugins
vim +BundleInstall +qall

pushd .vim/bundle/snipmate.vim
patch -p1 -i ../../../snipmate.patch
popd
