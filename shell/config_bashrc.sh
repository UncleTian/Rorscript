#!/bin/bash

# if [ $UID -ne 0 ]; 
# then
# 	echo "Not root user. Please run as root."
# 	exit
# else 
# 	echo "Root user."
# fi

echo "add backup dir for rm."
sudo mkdir -p ~/.trash
echo "\n" >> ~/.testfile

echo "alias rm=movetotrash" >> ~/.bashrc
echo "alias urm=unrmfile" >> ~/.bashrc
echo -e "alias cltrash=cleartrash\n" >> ~/.bashrc
echo -e "movetotrash() {\n\tmv \$@ ~/.trash/ \n}\n" >> ~/.bashrc
echo -e "unrmfile() {\n\tmv -i ~/.trash/\$@ ./ \n}\n" >> ~/.bashrc
echo -e "cleartrash() {\n\tread -p \"Clear trash?(Y/n)\" confirm\n\tconfirm=\${confirm,,}\n\t[ \$confirm == 'y' ] && /usr/bin/rm -rf ~/.trash/\*\n}\n" >> ~/.bashrc

echo -e "prepend() {\n\t [ -d \"\$2\"] && eval \$1=\\\"\$2':'\$\$1\\\" && export \$1; \n}\n" >> ~/.bashrc
