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
wget "http://downloads.sourceforge.net/project/pyclewn/pyclewn-1.9/pyclewn-1.9.py2.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpyclewn%2Ffiles%2Flatest%2Fdownload%3Fsource%3Dfiles&ts=1342183882&use_mirror=switch" -O pyclewn-1.9.py2.tar.gz
tar -xvf pyclewn-1.9.py2.tar.gz
cd pyclewn-1.9.py2
vimdir=$f/.vim/bundle/pyclewn python setup.py install --force --home=$f/.vim/bundle/pyclewn-bin
cd ..
#setup vim plugins
vim +BundleInstall +qall
##setup YouCompleteMe
mkdir ycm_temp
cd ycm_temp
curl -O http://llvm.org/releases/3.2/clang+llvm-3.2-x86_64-linux-ubuntu-12.04.tar.gz
tar -zxvf clang+llvm-3.2-x86_64-linux-ubuntu-12.04.tar.gz
cp ycm_temp/clang+llvm-3.2-x86_64-linux-ubuntu-12.04/lib/libclang.so ~/.vim/bundle/clang_complete/bin
cp ycm_temp/clang+llvm-3.2-x86_64-linux-ubuntu-12.04/bin/clang ~/.vim/bundle/clang_complete/bin
#cp clang+llvm-3.2-x86_64-linux-ubuntu-12.04/lib/libclang.so ~/.vim/bundle/YouCompleteMe/python
cd ..
#mkdir ycm_build
#cd ycm_build
#cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=$f/ycm_temp/clang+llvm-3.2-x86_64-linux-ubuntu-12.04 . ~/.vim/bundle/YouCompleteMe/cpp
#make ycm_core

pushd .vim/bundle/snipmate.vim
patch -p1 -i ../../../snipmate.patch
popd
