#!/bin/bash
# install jdk on ubuntu.
sudo add-apt-repository ppa:webupd8team/java

sudo apt update

read -r -t 60 -p "install Java 8 or 9? [8/9] " response
if [[ $response == 8]]
then
    sudo apt install oracle-java8-set-default
elif [[ $response == 9 ]];
then
    sudo apt install oracle-java9-set-default
fi


