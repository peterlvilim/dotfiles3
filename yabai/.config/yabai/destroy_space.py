#!/usr/bin/env python3
import subprocess
import query
for window in query.get_windows_current_space():
    query.close_window(window['pid'])
query.close_space(query.current_space()['index'])
