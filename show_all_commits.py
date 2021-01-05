#!/bin/python3.8

import re
import subprocess

# Get the stdout of this git log command to get all the commit IDs
gitout = subprocess.Popen(['git', 'log', '--pretty=oneline'], stdout=subprocess.PIPE)

output = bytes.decode(gitout.stdout.read())

for line in output.split('\n'):
    try:
        commitID = re.match(r'[a-f0-9]+', line).group(0)
        print()
        subprocess.run(['git', 'show', commitID])
    except AttributeError:
        pass
