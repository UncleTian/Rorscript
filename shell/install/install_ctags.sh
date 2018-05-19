#!/bin/bash

git clone https://github.com/universal-ctags/ctags.git ~/ctags
cd ~/ctags
if type autoreconf | grep 'not found' 
then
	sudo apt -y install autoreconf
fi

if type pkg-config | grep 'not found'
then
	sudo apt -y install pkg-config
fi

./autogen.sh 
./configure
make
sudo make install
