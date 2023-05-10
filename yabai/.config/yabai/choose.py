#!/usr/bin/env python3
import subprocess
import query

spaces = query.get_all_spaces()

input = ""
input = input + 'create new\n'
for space in spaces:
    input = input + "{} - {}\\n".format(space['index'], space['label'])

result = subprocess.check_output('echo "{}" | fzf'.format(input), shell=True).decode('utf-8')
if result == 'create new\n':
    query.create_space()
else:
    index = result.split('-')[0].strip(' ')
    query.close_space(index)
