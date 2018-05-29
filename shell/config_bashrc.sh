#!/bin/bash

if [ $UID -ne 0 ]; 
then
	echo "Not root user. Please run as root."
	exit
else 
	echo "Root user."
fi

echo "add backup dir for rm."
mkdir ~/.backup
echo "alias rm='cp \$@ ~/.backup && rm \$@'" >> ~/.bashrc

echo "prepend() { [ -d \"\$2\"] && eval \$1=\\\"\$2':'\$\$1\\\" && export \$1; }" >> ~/.bashrc
