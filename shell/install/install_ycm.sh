#!/bin/bash

sudo apt update

sudo apt install build-essential cmake

sudo apt install python-dev python3-dev

cd ~/.vim/bundle/

git clone https://github.com/Valloric/YouCompleteMe.git

cd ~/.vim/bundle/YouCompleteMe

git submodule update --init --recursive

./install.py --clang-completer
./install.py --go-completer
