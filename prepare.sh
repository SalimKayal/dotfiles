#!/bin/bash

f="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG="${HOME}/.config"

pushd "${CONFIG}"
    #setup neovim
    rm -rf nvim
    ln -s "$f/nvim"
    #setup alacritty
    rm -rf alacritty
    ln -s "$f/alacritty"
    #setup foot
    rm -rf foot
    ln -s "$f/foot"
    #setup hyprstuff
    rm -rf hypr
    ln -s "$f/hypr"
    #setup waybar
    rm -rf waybar
    ln -s "$f/waybar"
    #setup wofi
    rm -rf wofi
    ln -s "$f/wofi"
    mkdir -p systemd/user
    pushd systemd/user
        for s in $(ls systemd_user/);do
            rm -f $s
            ln -s "systemd_user/$s" .
        done
    popd
popd

pushd "${HOME}"
    #setup zsh
    rm -f .zshrc
    ln -s "$f/.zshrc"
popd
