#!/bin/bash 

git clone git@github.com:vim/vim.git ~/

cd ~/vim/

./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --with-python-config-dir=/usr/lib/python2.7/config/ --enable-gui=gtk2 --enable-cscope --prefix=/usr 

make

make install
