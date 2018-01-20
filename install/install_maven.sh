#!/bin/bash
# install maven on ubuntu.
wget http://www.eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
tar -xvzf apache-maven-3.5.2-bin.tar.gz
sudo mkdir /usr/local/maven
mv apache-maven-3.5.2/ /usr/local/maven/
alternatives --install /usr/bin/mvn mvn /usr/local/maven/apache-maven-3.5.2/bin/mvn 1
alternatives --config mvn