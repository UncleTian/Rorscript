#!/bin/bash

if [ $UID -ne 0 ]; 
then
	echo "Not root user. Please run as root."
	exit
else 
	echo "Root user."
fi

echo "add backup dir for rm."
mkdir -p ~/.trash
echo "\n" >> ~/.bashrc
echo "alias rm=movetotrash" >> ~/.bashrc
echo "alias urm=unrmfile" >> ~/.bashrc
echo "alias cltrash=cleartrash" >> ~/.bashrc
echo "movetotrash() {\n\tmv \$@ ~/.trash/ \n}" >> ~/.bashrc
echo "unrmfile() {\n\tmv -i ~/.trash/\$@ ./ \n}" >> ~/.bashrc
echo "cleartrash() {\n\tread -p \"Clear trash?(Y/n)\" confirm\n\tconfirm=\${confirm,,}\n\t[ \$confirm == 'y' ] && /usr/bin/rm -rf ~/.trash/\*\n}" >> ~/.bashrc

echo "prepend() {\n\t [ -d \"\$2\"] && eval \$1=\\\"\$2':'\$\$1\\\" && export \$1; \n}" >> ~/.bashrc
