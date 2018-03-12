#!/bin/bash
# install vim8 on ubuntu.

sudo apt install software-properties-common

sudo apt-add-repository ppa:jonathonf/vim

sudo apt update
sudo apt install vim -y

