#!/usr/bin/env python3
import subprocess
import query
window = query.get_current_window()
if window['app'] == 'Firefox':
    subprocess.check_output("osascript -e 'tell application \"System Events\" to keystroke \"w\" using {shift down, command down}'", shell=True)
else:
    query.kill_process(window['pid'])
