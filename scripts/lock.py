#!/usr/bin/python3
from background import FindImagePaths
from background import randomImagePath
import subprocess

ls = FindImagePaths(True, False, False)

path = randomImagePath(ls)
found = True
# Black and White
command = "i3lock --textcolor=ffffff00 --insidecolor=ffffff1c --ringcolor=ffffff3e --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 --insidevercolor=0000001c --ringwrongcolor=00000055 --insidewrongcolor=0000001c -i " + str(path)
# With colour
#command = "i3lock --insidevercolor=00000000 --insidewrongcolor=00000000 --insidecolor=00000000 --ringvercolor=faf611ff --ringwrongcolor=ff0000ff --ringcolor=40409000 --textcolor=ffffff00 --linecolor=aaaaaaff --keyhlcolor=009dffff --bshlcolor=ff8000ff -i " + str(path)
subprocess.call(command.split())
