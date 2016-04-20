#!/bin/bash

f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#setup vim
pushd ${HOME}
rm -rf .vim
rm -f .vimrc
ln -s $f/.vimrc
ln -s $f/.vim

#setup zsh
ln -s $f/.vimrc
ln -s $f/.vim

#setup zsh
rm -f .zshrc
ln -s $f/.zshrc

#setup xresources for urxvt
rm -f .Xresources
ln -s $f/.Xresources

#setup remapping for caps-lock
rm -f .Xmodmaprc
ln -s $f/.Xmodmaprc

#setup xmonad
rm -rf .xmonad
mkdir -p .xmonad
pushd .xmonad
ln -s $f/.xmonad/xmonad.hs
ln -s $f/.xmonad/xmonad.startup
popd
xmonad --recompile

#setup vimperator
rm -rf .vimperator
rm -rf .vimperatorrc
ln -s $f/.vimperatorrc
mkdir -p .vimperator/plugin
mkdir -p .vimperator/colors
pushd .vimperator/plugin
ln -s $f/noscript.js
popd
pushd .vimperator/colors
ln -s $f/molokai.vimp
ln -s $f/solarized_dark.vimp
popd

actions='#urxvt\nxrdb -merge ~/.Xresources\n#us intl kb\nsetxkbmap -layout us -variant altgr-intl\n#caps_lock remap\nxmodmap ~/.Xmodmaprc' 
echo -e $actions >> .xprofile
echo -e $actions >> .xinitrc

popd

#setup vim plugins
vim +BundleInstall +qall

