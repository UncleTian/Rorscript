#!/usr/bin/env python3
# -*- coding=utf-8 -*-
import re
from datetime import datetime
from pathlib import Path
from xml.dom import minidom
from xml.etree import ElementTree
from xml.etree.ElementTree import Element, SubElement, Comment


class MapEntry(object):

    def __init__(self, entry_key, entry_value):
        self.entry_key = entry_key
        self.entry_value = entry_value


def prettify(elem):
    """
    Return a pretty-printed XML string for the Element.
    """
    rough_string = ElementTree.tostring(elem, "utf-8")
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="    ")


def first_lower(string):
    if string:
        return string[0].lower() + string[1:]
    else:
        return string


def get_map_entry_set(source_dir):
    filepath = source_dir.glob("*.java")
    map_entry_set = set([])
    for path in filepath:

        re_map = re.compile(
            r"^[\s]+addHandler\((\w+)[\.\w\(\)\s,]{1,18}new[\s]+(\w+)\(\)")
        with path.open(mode="r") as f:
            all_line = f.readlines()
            for line in all_line:
                result = re_map.search(line)
                if result is not None and result.groups():
                    entry = MapEntry(result.group(1),
                                     first_lower(result.group(2)))
                    map_entry_set.add(entry)
    return map_entry_set


def generate_map_entry_xml(map_entry_set):
    # Configure one attribute with set()
    beans = Element("beans")

    comment = Comment("Generated for Python")
    beans.append(comment)

    bean = SubElement(beans, "map")
    for i in map_entry_set:
        entry = SubElement(bean, "entry")
        entry.set("key", i.entry_key)
        entry.set("value-ref", i.entry_value)

    print(prettify(beans))
    return prettify(beans)


def main():
    current_path = Path.cwd()
    target_file = current_path / "map_entry.xml"
    with target_file.open(mode="w") as f:
        f.write(generate_map_entry_xml(get_map_entry_set(current_path)))


if __name__ == "__main__":
    start_time = datetime.now()
    main()
    print("done")
    end_time = datetime.now()
    total = end_time - start_time
    print("used time: " + str(total))
