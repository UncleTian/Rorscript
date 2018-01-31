#!/bin/bash
# install sogou pinyin on debain.


sudo apt-get install python-software-properties -y

sudo apt-add-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install sogoupinyin -y

read -r -t 60 -p "Do you want to reboot to active sougou pinyin?(Y/n)" response
response=${response,,}
if [ $response == "y" ] 
then
    sudo reboot
fi

