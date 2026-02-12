#!/bin/bash

f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#setup neovim
pushd ${HOME}/.config
rm -rf nvim
ln -s $f/nvim
popd

pushd ${HOME}
#setup zsh
rm -f .zshrc
ln -s $f/.zshrc

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

actions='#us intl kb\nsetxkbmap -layout us -variant altgr-intl\n#caps_lock remap\nxmodmap ~/.Xmodmaprc' 
echo -e $actions >> .xprofile
echo -e $actions >> .xinitrc

popd
