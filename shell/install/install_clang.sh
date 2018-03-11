#!/bin/bash

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - # Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421
sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main"

sudo apt update

sudo apt install clang-5.0 lldb-5.0 clang-format-5.0 -y

update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-5.0 1000
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-5.0 1000
update-alternatives --config clang
update-alternatives --config clang++

echo "configure clang-format"
sudo cp /usr/bin/clang-format-5.0 /usr/bin/clang-format
