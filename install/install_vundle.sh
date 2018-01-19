#!/bin/bash
#
# install bundle on ubuntu.
cd ~
if [ -d .vim ] then
   mkdir ~/.vim/bundle
else
   mkdir -p ~/.vim/bundle
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

