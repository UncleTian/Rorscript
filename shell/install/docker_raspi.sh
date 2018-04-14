#!/bin/bash

echo 'Installing'

sudo apt-get update

sudo apt-get install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	lsb-release \
	software-properties-common -y

curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/raspbian/gpg | sudo apt-key add -

echo "deb [arch=armhf] https://mirrors.ustc.edu.cn/docker-ce/linux/raspbian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/hypriot.list

sudo apt-get update

sudo apt-get install docker-ce -y

sudo systemctl enable docker
sudo systemctl start docker

echo 'Verifying your docker installation'

docker version

sudo groupadd docker

sh -c "sudo usermod -aG docker $USER"

docker run arm32v7/hello-world


