import os
import re
import shutil
from datetime import datetime


def result_is_not_none(matcher):
    return matcher is not None and matcher.groups()


def merge_buffers(buffer_dir, combined_file_path):
    buffer_files = os.listdir(buffer_dir)
    buffer_files.sort(key=natural_keys)
    size = len(buffer_files)
    print("buffer files size: " + str(size))
    with open(combined_file_path, "w") as file:
        for buffer_file in buffer_files:
            with open(os.path.join(buffer_dir, buffer_file), "r") as buffer:
                shutil.copyfileobj(buffer, file)


def atoi(text):
    return int(text) if text.isdigit() else text


def natural_keys(text):
    '''
    alist.sort(key=natural_keys) sorts in human order
    http://nedbatchelder.com/blog/200712/human_sorting.html
    (See Toothy's implementation in the comments)
    '''
    return [atoi(c) for c in re.split(r'(\d+)', text)]


def save_to_buffer(buffer_file_path, content):
    if os.path.exists(buffer_file_path):
        append_write = "a"
    else:
        append_write = "w"
    with open(buffer_file_path, append_write) as buffer_file:
        buffer_file.write(content)


def make_buffer_by_thread_name(buffer_dir, file_path):
    thread_buffer_dict = get_thread_names(file_path)
    not_match = False
    with open(file_path, "r") as log_file:
        lines = log_file.readlines()
        for line in lines:
            for key, value in thread_buffer_dict.items():
                print(key)
                buffer_file_name = value
                rex_pattern = "(\["+key+"\])"
                tmp_rex = re.compile(rex_pattern)
                buffer_file_path = os.path.join(
                    buffer_dir, buffer_file_name)
                matcher = tmp_rex.search(line)
                if result_is_not_none(matcher):
                    save_to_buffer(buffer_file_path, line)
                    not_match = False
                    break
                else:
                    not_match = True
            if not_match:
                file_path = os.path.join(buffer_dir, "buffer"
                                         + str(len(thread_buffer_dict)))
                save_to_buffer(file_path, line)


def get_thread_names(file_path):
    thread_name_rex = re.compile(r"([\d:.]+)\s\[([\w\d\-/\s]+)\]")
    tmp_list = {}
    offset = 1
    with open(file_path, "r") as log_file:
        for line in log_file:
            matcher = thread_name_rex.search(line)
            if result_is_not_none(matcher):
                thread_name = matcher.group(2)
                if thread_name not in tmp_list:
                    buffer_name = "buffer" + str(offset)
                    tmp_list[thread_name] = buffer_name
                    offset += 1
    return tmp_list


def make_buffer_dir(buffer_dir):
    if os.path.exists(buffer_dir):
        remove_buffer_dir(buffer_dir)
    os.mkdir(buffer_dir)


def remove_buffer_dir(buffer_dir):
    if os.path.exists(buffer_dir):
        shutil.rmtree(buffer_dir)


def rearrange(current_dir):
    log_files = [file for file in os.listdir(current_dir) if ".log" in file
                 and "arranged" not in file]
    for file_name in log_files:
        print("rearrange log file: " + file_name)
        buffer_dir = os.path.join(current_dir, "buffer")
        make_buffer_dir(buffer_dir)
        combined_file_path = os.path.join(
            os.path.abspath("."), "arranged_" + file_name)
        if os.path.exists(combined_file_path):
            os.remove(combined_file_path)
        file_path = os.path.join(current_dir, file_name)
        make_buffer_by_thread_name(buffer_dir, file_path)
        merge_buffers(buffer_dir, combined_file_path)
        # remove_buffer_dir(buffer_dir)


def main():
    current_dir = os.path.abspath(".")
    rearrange(current_dir)


if __name__ == "__main__":
    start_time = datetime.now()
    main()
    print("done")
    end_time = datetime.now()
    total = end_time - start_time
    print("used time: " + str(total))
