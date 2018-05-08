#!/bin/bash

git clone https://github.com/universal-ctags/ctags.git ~/ctags
cd ~/ctags
./autogen.sh 
./configure
make
sudo make install
