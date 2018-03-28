#!/bin/bash
# install and config git on ubuntu.
sudo apt update

sudo apt install -y git

read -r -t 60 -p "do you want to set git config[Y/n]:" response
response=${response,,}
if [[ $response == "y" ]] 
then
    echo "all configuration will be set as global"
    read -r -t 60 -p "enter your user name: " username
    git config --global user.name $username
    read -r -t 60 -p "enter your email: " email
    git config --global user.email $email
    read -r -t 60 -p "enter your core editor: " editor
    git config --global core.editor $editor
		git config --global core.autocrlf auto
    git config -l
fi

version=`git --version`    
echo "installed $version"
