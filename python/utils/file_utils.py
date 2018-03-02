import os


def remove(path):
    if os.path.isfile(path):
        os.remove(path)
        print("removed: %s" % path)
    else:  # Show an error ##
        print("Error: %s file not found" % path)


def rename(old, new):
    """
    @old origin file full path
    @new new file name or new directory name
    """
    if os.path.isfile(old) :
        dir = os.path.dirname(old)
        new_file = os.path.join(dir, new)
        os.renames(old, new_file)
    elif os.path.isdir(old):
        os.renames(old, new)
