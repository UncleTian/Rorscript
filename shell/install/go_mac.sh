#/bin/bash

brew upgrade

brew install go

# config go path
echo "config go path"

echo "export GOROOT=/usr/local/opt/go/libexec" >> ~/.bashrc
echo "export GOPATH=$HOME/.go" >> ~/.bashrc
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> ~/.bashrc

source ~/.bashrc

go version