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



popd
