#!/bin/bash

f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#setup vim
cd $HOME
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
ln -s $f/.vimrc
ln -s $f/.vim

#setup zsh
ln -s $f/.vimrc
ln -s $f/.vim

#setup zsh
rm -f $HOME/.zshrc
ln -s $f/.zshrc

#setup xresources for urxvt
rm -f $HOME/.Xresources
ln -s $f/.Xresources

#setup remapping for caps-lock
rm -f $HOME/.Xmodmaprc
ln -s $f/.Xmodmaprc

#setup xmonad
rm -rf $HOME/.xmonad
mkdir -p $HOME/.xmonad
pushd $HOME/.xmonad
ln -s $f/.xmonad/xmonad.hs
ln -s $f/.xmonad/xmonad.startup
popd
xmonad --recompile

#setup vimperator
rm -rf $HOME/.vimperator
rm -rf $HOME/.vimperatorrc
ln -s $f/.vimperatorrc
mkdir -p .vimperator/plugin
mkdir -p .vimperator/colors
pushd .vimperator/plugin
ln -s $f/noscript.js
popd
pushd .vimperator/color
ln -s $f/molokai.vimp
popd

actions='#urxvt\nxrdb -merge ~/.Xresources\n#us intl kb\nsetxkbmap -layout us -variant altgr-intl\n#caps_lock remap\nxmodmap ~/.Xmodmaprc' 
echo -e $actions >> $HOME/.xprofile
echo -e $actions >> $HOME/.xinitrc

cd $f

#setup vim plugins
vim +BundleInstall +qall

