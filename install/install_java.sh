#!/bin/bash
# install jdk on ubuntu.
sudo mkdir /usr/lib/jvm

wget -O http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz?AuthParam=1516608341_3343898786f6f1b4fa420f46ce81b023

sudo tar -zxvf jdk-9.0.4_linux-x64_bin.tar.gz -C /usr/lib/jvm

# set oracle jdk environment
echo "export JAVA_HOME=/usr/lib/jvm/jdk-9.0.4" >> ~/.bashrc
echo "export JRE_HOME=${JAVA_HOME}/jre" >> ~/.bashrc
echo "export CLASSPAHT=.:${JAVA_HOME}/lib:${JRE_HOME}/lib" >> ~/.bashrc
echo "export PATH=${JAVA_HOME}/bin:$PATH" >> ~/.bashrc

source ~/.bashrc

java --version



