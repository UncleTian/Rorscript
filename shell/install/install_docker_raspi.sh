#!/bin/bash

echo 'Installing'

sudo apt-get install -y apt-transport-https

wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -

echo 'deb https://packagecloud.io/Hypriot/Schatzkiste/debian/ wheezy main' | sudo tee /etc/apt/sources.list.d/hypriot.list

sudo apt-get update

sudo apt-get install -y docker-hypriot

sudo systemctl enable docker

echo 'Verifying your docker installation'

docker version

sudo usermod -aG docker pi
