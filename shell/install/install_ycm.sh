#!/bin/bash

sudo apt update

sudo apt install build-essential cmake

sudo apt install python-dev python3-dev

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
./install.py --go-completer
