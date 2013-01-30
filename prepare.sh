#!/bin/bash

f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HOME
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
ln -s $f/.vimrc
ln -s $f/.vim

rm -rf $HOME/.xmonad
mkdir -p $HOME/.xmonad
pushd $HOME/.xmonad
ln -s $f/.xmonad/xmonad.hs
ln -s $f/.xmonad/xmonad.startup
popd
xmonad --recompile

cd $f

wget "http://downloads.sourceforge.net/project/pyclewn/pyclewn-1.9/pyclewn-1.9.py2.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpyclewn%2Ffiles%2Flatest%2Fdownload%3Fsource%3Dfiles&ts=1342183882&use_mirror=switch" -O pyclewn-1.9.py2.tar.gz
tar -xvf pyclewn-1.9.py2.tar.gz
cd pyclewn-1.9.py2
vimdir=$f/.vim/bundle/pyclewn python setup.py install --force --home=$f/.vim/bundle/pyclewn-bin
cd ..
vim +BundleInstall +qall
pushd .vim/bundle/snipmate.vim
patch -p1 -i ../../../snipmate.patch
popd
