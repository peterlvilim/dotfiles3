import json
import subprocess
import plistlib

def current_space():
    return json.loads(subprocess.check_output("/usr/local/bin/yabai -m query --spaces --space", shell=True))

def get_all_spaces():
    return json.loads(subprocess.check_output("/usr/local/bin/yabai -m query --spaces", shell=True))

def get_all_windows():
    return json.loads(subprocess.check_output("/usr/local/bin/yabai -m query --windows", shell=True))

def get_windows_current_space():
    return json.loads(subprocess.check_output("/usr/local/bin/yabai -m query --windows --space", shell=True))

def get_current_window():
    return json.loads(subprocess.check_output("/usr/local/bin/yabai -m query --windows --window", shell=True))

def kill_process(pid):
    subprocess.check_output("kill -9 {}".format(pid), shell=True)

def close_space(index):
    subprocess.check_output("/usr/local/bin/yabai -m space --destroy {}".format(index), shell=True)

def focus_space(index):
    subprocess.check_output("/usr/local/bin/yabai -m space --focus {}".format(index), shell=True)

def create_space():
    subprocess.check_output("/usr/local/bin/yabai -m space --create", shell=True)

def testing():
    return plistlib.loads(subprocess.check_output("defaults read com.apple.spaces", shell=True))
