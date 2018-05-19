#!/bin/bash

if [[ "OSTYPE" == "linux-gnu" ]]; then
  sudo apt update
	if java -version | grep "not found" then
		sudo apt install -y default-jdk
	fi
	sudo apt install -y scala sbt
elif [[ "OSTYPE" == "darwin"* ]]; then
	brew update
  brew install scala
  brew install sbt
	echo '-J-XX:+CMSClassUnloadingEnabled' >> /usr/local/etc/sbtopts
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi
