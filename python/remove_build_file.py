#!/usr/bin/env python3

import os


def remove_file(path):
    if os.path.isfile(path):
        os.remove(path)
        print("removed: %s" % path)
    else:  # Show an error ##
        print("Error: %s file not found" % path)


def explore(dir_path):
    for root, dirs, files in os.walk(dir_path):
        for file in files:
            path = os.path.join(root, os.path.basename(file))
            if '.exe' in file or '.c.o' in file or '.' not in file or '.out' in file:
                remove_file(path)


def main(dir):
    if os.path.isfile(dir):
        # remove_file(dir)
        pass
    elif os.path.isdir(dir):
        explore(dir)


if __name__ == "__main__":
    dir = os.path.abspath(".")
    print(dir)
    main(dir)
    print("pass")
