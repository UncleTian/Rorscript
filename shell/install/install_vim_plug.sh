#!/bin/bash


if -z which curl 
then``
	if cat /etc/*-release | grep debian
	then
		sudo apt update
		sudo apt install curl -y
	fi 
fi 


curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


