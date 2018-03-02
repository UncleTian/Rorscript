#!/usr/bin/env python3
import subprocess

hexo_clean = "cd /Users/Rorschach/OneDrive/Blog && hexo clean"
hexo_g = "cd /Users/Rorschach/OneDrive/Blog && hexo g"
hexo_d = "cd /Users/Rorschach/OneDrive/Blog && hexo d"


def check_errors(outs):
    if outs is None or outs[0] != 0:
        print(outs)
        return False
    return True


def main():
    outs = subprocess.getstatusoutput(hexo_clean)
    if check_errors(outs):
        print(outs[1], "\n")

    outs = subprocess.getstatusoutput(hexo_g)

    if check_errors(outs):
        print(outs[1], "\n")

    outs = subprocess.getstatusoutput(hexo_d)

    if check_errors(outs):
        print(outs[1], "\n")

    outs = subprocess.getstatusoutput(hexo_clean)
    if check_errors(outs):
        print(outs[1], "\n")


if __name__ == '__main__':
    main()
