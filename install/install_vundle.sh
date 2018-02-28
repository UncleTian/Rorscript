#!/bin/bash
#
# install bundle on ubuntu.
cd ~

if [ -d ~/.vim ]
then
   dir="~/.vim/bundle"
   mkdir $dir
   echo "make dir $dir"
else
   mkdir -p ~/.vim/bundle
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

