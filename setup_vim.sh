#!/usr/bin/env bash
# -*- coding: utf-8 -*-

VIM_DIR=${HOME}/.vim
VIM_BUNDLE=${VIM_DIR}/bundle
VIM_UNDO=${VIM_DIR}/vim_undo #persistent file undo
VUNDLE_GIT="https://github.com/VundleVim/Vundle.vim.git"

[[ -d "$VIM_DIR" ]] && \
    { echo "$VIM_DIR already exists. Please move it first"; exit 1; }

[[ -e "${VIM_DIR}/.vimrc" ]] && \
    { echo "$VIM_DIR/.vimrc already exists. Please move it first"; exit 1; }

if ! [[ -d "$VIM_DIR" ]]; then
    mkdir -p $VIM_DIR
    mkdir -p $VIM_UNDO
    echo "$VIM_DIR created"
fi

if ! [[ -e ${VIM_BUNDLE}/Vundle.vim ]]; then
    mkdir -p ${VIM_BUNDLE}
    git clone $VUNDLE_GIT ${VIM_BUNDLE}/Vundle.vim
    echo "$VUNDLE_GIT cloned"
fi

rsync ./vimrc $VIM_DIR
ln ${PWD}/vimrc ${HOME}/.vimrc
vim +PluginInstall +qall
pip install flake8

echo "setup vim-config: done"
