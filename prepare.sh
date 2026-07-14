#!/bin/bash

f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG=${HOME}/.config

pushd ${CONFIG}
#setup neovim
rm -rf nvim
ln -s $f/nvim
#setup alacritty
rm -rf alacritty
ln -s $f/alacritty
popd

pushd ${HOME}
#setup zsh
rm -f .zshrc
ln -s $f/.zshrc



popd
