import json
import subprocess
def current_space():
    return json.loads(subprocess.check_output("yabai -m query --spaces --space", shell=True))

def get_all_spaces():
    return json.loads(subprocess.check_output("yabai -m query --spaces", shell=True))

def get_all_windows():
    return json.loads(subprocess.check_output("yabai -m query --windows", shell=True))

def get_windows_current_space():
    return json.loads(subprocess.check_output("yabai -m query --windows --space", shell=True))

def get_current_window():
    return json.loads(subprocess.check_output("yabai -m query --windows --window", shell=True))

def kill_process(pid):
    subprocess.check_output("kill -9 {}".format(pid), shell=True)

def close_space(id):
    subprocess.check_output("yabai -m space --destroy {}".format(id), shell=True)

def create_space():
    subprocess.check_output("yabai -m space --create", shell=True)