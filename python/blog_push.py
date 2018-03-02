#!/usr/bin/env python3
import subprocess

hexo_clean = "cd /Users/Rorschach/OneDrive/Blog && hexo clean"
hexo_g = "cd /Users/Rorschach/OneDrive/Blog && hexo g"
hexo_d = "cd /Users/Rorschach/OneDrive/Blog && hexo d"

outs = subprocess.getstatusoutput(hexo_clean)
if outs is None or outs[0] != 0:
    print(outs)
    raise outs[1]

print(outs[1], "\n")
outs = subprocess.getstatusoutput(hexo_g)

if outs is None or outs[0] != 0:
    print(outs)
    raise outs[1]
print(outs[1], "\n")
outs1 = subprocess.getstatusoutput(hexo_d)

if outs1 is None or outs1[0] != 0:
    print(outs1)
    raise outs1[1]
print(outs1[1])
