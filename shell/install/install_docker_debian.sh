#!/bin/bash

sudo apt update

sudo apt install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	lsb-release \
	software-properties-common -y

# Use USTC mirrors
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"

sudo apt update

sudo apt install docker-ce -y

sudo systemctl enable docker
sudo systemctl start docker 

sudo groupadd docker

sh -c "sudo usermod -aG docker $USER"

docker run hello-world


