#!/usr/bin/env python3
# -*- coding=utf-8 -*-
import os
import re
from datetime import datetime
from xml.dom import minidom
from xml.etree import ElementTree
from xml.etree.ElementTree import Element, SubElement, Comment


class JavaBean(object):

    def __init__(self, bean_name, ref_class, parent_bean, properties):
        self.bean_name = bean_name
        self.ref_class = ref_class
        self.parent_bean = parent_bean
        self.properties = properties


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


def get_java_bean_set(source_dir):
    java_files = [file for file in os.listdir(source_dir)
                  if "Serializer.java" in file]
    java_bean_set = set([])
    re_prop = re.compile(
        r"[\(\s]*([\w]+)[\)\s]+BeanUtils[\s\.]+"
        r"getBean[\(\s]+\"(.+)\"[\s]*\)")
    re_package = re.compile(r"package\s(.+);")
    re_parent = re.compile(r"\w\sextends\s?(\w+)")
    for file_name in java_files:
        properties = {}
        file_path = os.path.join(source_dir, file_name)
        bean_name = first_lower(file_name)[:-5]
        ref_class = ""
        parent = ""
        java_bean = JavaBean(bean_name, ref_class, parent, properties)

        with open(file_path, "r") as f:
            content = f.read()
            result = re_package.search(content)
            if result is not None and result.groups():
                ref_class = result.group(1)
            result = re_prop.search(content, re.MULTILINE)
            if result is not None and result.groups():
                properties[result.group(1)] = result.group(2)
            result = re_parent.search(content)
            if result is not None and result.groups():
                parent = result.group(1)
            java_bean.ref_class = ref_class + "." + file_name[:-5]
            java_bean.properties = properties
            java_bean.parent_bean = parent
        java_bean_set.add(java_bean)
    return java_bean_set


def generate_bean_xml(java_bean_set):
    # Configure one attribute with set()
    beans = Element("beans")

    comment = Comment("Generated for Python")
    beans.append(comment)
    for i in java_bean_set:

        bean = SubElement(beans, "bean")
        bean.set("aid", i.bean_name)
        bean.set("class", i.ref_class)
        if i.parent_bean != "":
            bean.set("parent", first_lower(i.parent_bean))
        if len(i.properties) != 0:
            for key, value in i.properties.items():
                property = SubElement(bean, "property")
                property.set("name", first_lower(key))
                property.set("ref", value)

    print(prettify(beans))
    return prettify(beans)


def main():
    current_dir = os.path.abspath(".")
    java_bean_set = get_java_bean_set(current_dir)
    with open(os.path.join(current_dir, "spring.xml"), "w") as f:
        f.write(generate_bean_xml(java_bean_set))



if __name__ == "__main__":
    start_time = datetime.now()
    main()
    print("done")
    end_time = datetime.now()
    total = end_time - start_time
    print("used time: " + str(total))
