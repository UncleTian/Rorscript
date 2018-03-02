#!/usr/bin/env python3
# -*- coding=utf-8 -*-
import os

import chardet

path = os.path.abspath('.')
print(path)

dirs = os.listdir()

print(dirs)

first = os.path.join(path, dirs[8])
print(first)

path1 = os.path.join(path, 'test.sql')



def convert(filepath):
    print("convert ", filepath)
    with open(filepath, 'rb') as f:
        data = f.read()
        print(data)
        print(chardet.detect(data))
        if chardet.detect(data)['encoding'] == 'GB18030':
            data2 = data.decode('GB18030').encode('utf-8')
            print(data2)
            with open(filepath, 'wb') as f2:
                f2.write(data2)
                print('convert finished!')




def explore(dir):
    for root, dirs, files in os.walk(dir):
        for file in files:
            path = os.path.join(root, os.path.basename(file))
            if '.sql' in file:
                convert(path)


def main(dir):
    if os.path.isfile(dir):
        convert(dir)
    elif os.path.isdir(dir):
        explore(dir)


if __name__ == "__main__":
    main(path)
    # explore(dirs)
