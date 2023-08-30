#!/usr/bin/env python3
import time
import traceback
import subprocess
import query
import sys

try:
    spaces = query.get_all_spaces()
    windows = query.get_all_windows()
    current_space_index = query.current_space()['index']

    user_options = ""

    user_options = user_options + "create space\\n"

    for window in windows:
        space_index = window['space']
        space_label = spaces[space_index - 1]['label']
        user_options = user_options + "jump to window - {} - {} - {} - {} - {}\\n".format(space_index, space_label, window['id'], window['app'], window['title'])

    for space in spaces:
        user_options = user_options + "rename space - {} - {}\\n".format(space['index'], space['label'])

    apps = subprocess.check_output("/bin/ls /Applications", shell=True).decode('utf-8').split('\n')[:-1]
    for app in apps:
        user_options = user_options + "open app - {}\n".format(app)


    for window in windows:
        space_index = window['space']
        space_label = spaces[space_index - 1]['label']
        user_options = user_options + "grab window - {} - {} - {} - {} - {}\\n".format(space_index, space_label, window['id'], window['app'], window['title'])

    for window in windows:
        space_index = window['space']
        space_label = spaces[space_index - 1]['label']
        user_options = user_options + "move window - {} - {} - {} - {} - {}\\n".format(space_index, space_label, window['id'], window['app'], window['title'])

    result = subprocess.check_output('echo "{}" | fzf'.format(user_options), shell=True).decode('utf-8').strip(' ')
    command = result.split('-')[0].strip(' ')
    if command == "rename space":
        index = result.split('-')[1].strip(' ')
        new_name = input("New name for space: ")
        query.set_space_name(index, new_name)
    elif "create space" in command:
        new_name = input("New name for space: ")
        index = len(spaces)+1
        query.create_space()
        query.set_space_name(index, new_name)
    elif "open app" in command:
        app = result.split('-')[1].strip(' ')
        subprocess.check_output("open -n /Applications/{}".format(app), shell=True).decode('utf-8').split('\n')[:-1]
    elif "grab window" in command:
        window_id = result.split('-')[3].strip(' ')
        subprocess.check_output("/usr/local/bin/yabai -m window {} --space {}".format(window_id, current_space_index), shell=True)
    elif "move window" in command:
        window_id = result.split('-')[3].strip(' ')
        more_options = ""
        for space in spaces:
            more_options = more_options + "move to space - {} - {}\\n".format(space['index'], space['label'])
        result = subprocess.check_output('echo "{}" | fzf'.format(more_options), shell=True).decode('utf-8').strip(' ')
        index = result.split('-')[1].strip(' ')
        subprocess.check_output("/usr/local/bin/yabai -m window {} --space {}".format(window_id, index), shell=True)
    elif "jump to window" in command:
        window_id = result.split('-')[3].strip(' ')
        subprocess.check_output("/usr/local/bin/yabai -m window --focus {}".format(window_id), shell=True)
    else:
        print(command)
except subprocess.CalledProcessError as e:
    if e.returncode == 130:
        # handle ctrl-c
        pass
    else:
        while True:
            print(e)
            time.sleep(1)
except subprocess.Exception as e:
    while True:
        print(e)
        time.sleep(1)
