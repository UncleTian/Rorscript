#!/usr/bin/env python3
# -*- coding=utf-8 -*-
import os
import platform

import re

import time

start_time = time.time()
path = os.path.abspath('.')
print(path)

template_result_dict = {}
pks_result_dict = {}
java_result_dict = {}


def result_is_not_none(matcher):
    return matcher is not None and matcher.groups()


def is_xml(file):
    rex = re.compile(r'(\w+-context\.xml)')
    result = rex.match(str(file))
    return result_is_not_none(result)


def is_pks(file):
    rex = re.compile(r'(DCL_\w+\.pks)')
    result = rex.match(str(file))
    return result_is_not_none(result)


def is_java(file):
    rex = re.compile(r'(\w+[^Test]\.java)')
    result = rex.match(str(file))
    return result_is_not_none(result)


def find_sort_by(buffer_set, content):
    rex = re.compile(r'<\w*if\((\w+sort\w*|sort[\w]+)\)>', re.IGNORECASE)
    result = rex.search(content)
    if result_is_not_none(result):
        buffer = result.group(1)
        buffer_set.add(buffer)
        # keyword_buffer = re.search(r'(\(\w+\))', buffer)
        # if result_is_not_none(keyword_buffer):
        #     keyword = keyword_buffer.group(0)
        #     buffer_set.add(keyword[1:-1])


def find_sort_by_pks(buffer_dict, content):
    rex = re.compile(r'((\w+sort\w*|sort\w+)\s+IN (\w+))', re.IGNORECASE)
    result = rex.search(content)
    if result_is_not_none(result):
        parameter = result.group(2)
        data_type = result.group(3)
        buffer_dict[parameter] = data_type


def find_sort_by_java(buffer_dict, content):
    rex = re.compile(
        r'("(\w+sort\w*|sort\w+)",\s*("?\w+"?))',
        re.IGNORECASE)
    result = rex.search(content)
    if result_is_not_none(result):
        parameter = result.group(2)
        data_type = result.group(3)
        if data_type not in 'required':
            buffer_dict[parameter] = data_type


def get_template_name(content):
    template = re.search(r'(id="(\w+)")', content)
    if result_is_not_none(template):
        return template.group(0)[4:-1]
    else:
        return None


def get_procedure_name(content):
    rex = re.compile(r'PROCEDURE (\w+)\(', re.IGNORECASE)
    procedure = rex.search(content)
    if result_is_not_none(procedure):
        return procedure.group(1)
    else:
        return None


def distinct_method(name):
    temp = name.group(1)[:1]
    if temp.islower() and temp != 'i':
        return True
    return False


def get_method_name(content):
    rex = re.compile(r'((public|private).+(\w+)\s?\()', re.IGNORECASE)
    method = rex.search(content)
    if result_is_not_none(method) and distinct_method(method):
        return method.group(1)
    else:
        return None


def find_sort_by_from_template(file_path):
    with open(file_path, 'r') as f:
        all_content = f.readlines()
        xml_name = os.path.basename(file_path)
        template_dict = {}
        result_set = set([])
        for content in all_content:
            template_name = get_template_name(content)
            find_sort_by(buffer_set=result_set, content=content)
            if result_set and template_name is not None:
                template_dict[template_name] = result_set
                template_result_dict[xml_name] = template_dict
                result_set = set([])


def find_sort_by_from_pks(file_path):
    with open(file_path, 'r') as f:
        all_content = f.readlines()
        pks_name = os.path.basename(file_path)
        procedure_dict = {}
        parameter_dict = {}
        for content in all_content:
            procedure_name = get_procedure_name(content)
            find_sort_by_pks(parameter_dict, content=content)
            if parameter_dict and procedure_name is not None:
                procedure_dict[procedure_name] = parameter_dict
                pks_result_dict[pks_name] = procedure_dict
                parameter_dict = {}


def find_sort_by_from_java(file_path):
    with open(file_path, 'r') as f:
        all_content = f.readlines()
        java_name = os.path.basename(file_path)
        method_dict = {}
        parameter_dict = {}
        for content in all_content:
            method_name = get_method_name(content)
            find_sort_by_java(parameter_dict, content=content)
            if parameter_dict and method_name is not None:
                method_dict[method_name] = parameter_dict
                java_result_dict[java_name] = method_dict
                parameter_dict = {}


def explore_dir(dir_name):
    dir_list = os.listdir(dir_name)
    for target_name in dir_list:
        if target_name == 'db-scripts':
            explore_pks(target_name)
        elif target_name == 'dcl-app':
            explore_xml(target_name)
            explore_java(target_name)


def explore_xml(dir_name):
    if is_windows():
        dir_name = os.path.join(dir_name, 'dcl-app\\src\\resources\\META-INF')
    else:
        dir_name = os.path.join(dir_name, 'dcl-app/src/resources/META-INF')
    for root, dirs, files in os.walk(dir_name):
        for file in files:
            file_path = os.path.join(root, os.path.basename(file))
            if os.path.isfile(file_path) and is_xml(file):
                find_sort_by_from_template(file_path=file_path)


def explore_pks(dir_name):
    if is_windows():
        dir_name = os.path.join(dir_name, 'db-scripts\\SLM_Install\\packages')
    else:
        dir_name = os.path.join(dir_name, 'db-scripts/SLM_Install/packages')
    for root, dirs, files in os.walk(dir_name):
        for file in files:
            file_path = os.path.join(root, os.path.basename(file))
            if os.path.isfile(file_path) and is_pks(file):
                find_sort_by_from_pks(file_path=file_path)


def explore_java(dir_name):
    if is_windows():
        dir_name = os.path.join(dir_name, 'dcl-app\\src\\java')
    else:
        dir_name = os.path.join(dir_name, 'dcl-app/src/java')
    for root, dirs, files in os.walk(dir_name):
        for file in files:
            file_path = os.path.join(root, os.path.basename(file))
            if os.path.isfile(file_path) and is_java(file):
                find_sort_by_from_java(file_path=file_path)


def analyse_xml():
    for xml_name, value in template_result_dict.items():
        print('%s :\r' % xml_name)
        count = 0
        for template_name, keyword in value.items():
            print('\t%s contains: %d\r' % (template_name, len(keyword)))
            for sort_by in keyword:
                print('\t\t%s' % sort_by)
                count = count + 1
        print('total count: %d\n' % count)


def analyse_pks():
    for package_name, value in pks_result_dict.items():
        print('%s :\r' % package_name)
        count = 0
        for procedure_name, keyword in value.items():
            print('\t%s contains:\r' % procedure_name)
            for parameter_name, data_type in keyword.items():
                print('\t\t%s type: %s\r' % (parameter_name, data_type))
                count = count + 1
        print('total count: %d\n' % count)


def analyse_java():
    for java_name, value in java_result_dict.items():
        print('%s :\r' % java_name)
        count = 0
        for method_name, keyword in value.items():
            print('\t%s contains:\r' % method_name)
            for parameter_name, data_type in keyword.items():
                print('\t\t%s type: %s\r' % (parameter_name, data_type))
                count = count + 1
        print('total count: %d\n' % count)


def is_windows():
    os_name = platform.system().lower()
    if os_name == 'windows':
        return True
    return False


def main(dir_name):
    if os.path.isfile(dir_name):
        pass
    elif os.path.isdir(dir_name):
        # explore_dir(dir_name)
        explore_xml(dir_name)
        explore_java(dir_name)
        explore_pks(dir_name)
    analyse_xml()
    analyse_pks()
    analyse_java()
    end_time = time.time()
    print(end_time - start_time)


if __name__ == "__main__":
    main(path)
