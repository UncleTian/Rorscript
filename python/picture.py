#!/usr/bin/env python3
import os
import urllib
from urllib.error import HTTPError
from urllib.error import URLError
from urllib.request import urlopen
from bs4 import BeautifulSoup
import re
import asyncio
import platform


def which_platform():
    sysstr = platform.system()
    if sysstr == "Windows":
        return os.path.join(os.path.abspath('.'), "Pictures")
    elif sysstr == "Linux":
        return '/Users/Rorschach' + "/Pictures/haixiuzu"
    else:
        return '/Users/Rorschach' + "/Pictures/haixiuzu"


async def download(link):

    path = which_platform()
    if not os.path.exists(path):
        os.makedirs(path)
    filename = str.split(link, "/")[-1]
    file = os.path.join(path, filename)
    print(link)
    if not os.path.exists(file):
        urllib.request.urlretrieve(link, file)
        print('downloaded: %s' % filename)
    else:
        print('file exist!')


def get_topic(bs):
    links = bs.findAll("a", {'href': re.compile("^.*(/topic/).*")})
    return links


async def get_image(link):
    try:
        html1 = urlopen(link['href'], timeout=60)
        print(link['href'])
        try:
            bs = BeautifulSoup(html1, "html.parser")
            images = bs.findAll("img",
                                {"src": re.compile("^.*(topic).*\.(jpg|png)")})

            tasks = [download(image["src"]) for image in images]
            await asyncio.gather(*tasks)

        except AttributeError as e:
            print(e)
    except (HTTPError, URLError) as e:
        print(e)


url = "https://www.douban.com/group/haixiuzu/"


async def find_topic(loop, html):
    bsObj = BeautifulSoup(html, "html.parser")
    tasks = [get_image(link) for link in get_topic(bsObj)]
    await asyncio.gather(*tasks)


def main(loop):
    try:
        html = urlopen(url, timeout=30)
        loop.run_until_complete(find_topic(loop, html))
        print('fetch done!')
    except (HTTPError, URLError) as e:
        print(e)
    finally:
        loop.close()


if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    main(loop)
