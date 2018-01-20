#!/bin/bash
# install ActiveMQ on linux.
# Download Apache ActiveMQ
wget http://www.apache.org/dist//activemq/apache-activemq/5.5.0/apache-activemq-5.5.0-bin.tar.gz
# Extract the Archive
tar -zxvf apache-activemq-5.5.0-bin.tar.gz
# Change it permission.
chmod 755 activemq

# Run Apache ActiveMQ
sudo sh activemq start
# Testing the Installation
netstat -an|grep 61616