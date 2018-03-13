#!/bin/bash 

sudo apt remove --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common

sudo apt install liblua5.1-dev luajit libluajit-5.1 python-dev libperl-dev libncurses5-dev ruby-dev

git clone https://github.com/vim/vim.git ~/vim/

cd ~/vim/
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "configure vim"
echo
./configure --with-features=huge \
			--enable-largefile \
			--enable-pythoninterp \
			--enable-rubyinterp \
			--enable-perlinterp \
			--with-luajit \
			--with-python-config-dir=/usr/lib/python2.7/config/ \
			--enable-gui=auto \
			--enable-cscope \
			--prefix=/usr \
			--with-x \

echo
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
sudo make
echo
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
