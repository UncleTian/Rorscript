#!/bin/bash

# if [ $UID -ne 0 ]; 
# then
# 	echo "Not root user. Please run as root."
# 	exit
# else 
# 	echo "Root user."
# fi

if [ "$(uname)" == "Darwin" ]; then
	brew install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	sudo apt update
	sudo apt install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

bash -c zsh
echo "Install zsh-syntax-hightlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Add backup dir for rm."
mkdir -p ~/.mytrash

echo "alias rm=movetotrash" >> ~/.zshrc
echo "alias urm=unrmfile" >> ~/.zshrc
echo -e "alias cltrash=cleartrash\n" >> ~/.zshrc
echo -e "movetotrash() {\n\tmv \$@ ~/.mytrash/ \n}\n" >> ~/.zshrc
echo -e "unrmfile() {\n\tmv -i ~/.mytrash/\$@ ./ \n}\n" >> ~/.zshrc
echo -e "cleartrash() {\n\tread -p \"Clear trash?(Y/n)\" confirm\n\tconfirm=\${confirm,,}\n\t[ \$confirm == 'y' ] && /usr/bin/rm -rf ~/.trash/\*\n}\n" >> ~/.zshrc

echo -e "prepend() {\n\t [ -d \"\$2\"] && eval \$1=\\\"\$2':'\$\$1\\\" && export \$1; \n}\n" >> ~/.zshrc

echo -e "export PATH=/usr/local/go/bin:$PATH" >> ~/.zshrc
echo -e "export GOPATH=$HOME/go" >> ~/.zshrc
echo -e "QT_HOMEBREW=true" >> ~/.zshrc

echo -e "alias go='http_proxy=http://127.0.0.1:3213/ https_proxy=http://127.0.0.1:3213/ no_proxy=localhost,127.0.0.0/8,::1 go'" >> ~/.zshrc

