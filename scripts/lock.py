#!/usr/bin/python3
import subprocess
import os, random

directory = os.environ["HOME"] + "Pictures/Lockscreen"

image = random.choice(os.listdir(directory))
path = directory + "/" + image

print("Loading image: " + path)

# Colours 
insidecolor = "ffffff1c"
ringcolor = "ffffff3e"
linecolor = "ffffff00"
keyhlcolor = "00000080"
ringvercolor = "00000000"
insidevercolor = "0000001c"
ringwrongcolor = "00000055"
insidewrongcolor = "0000001c"
timecolor = "afafafff"
datecolor = "a5a5a5ff"

command = ["i3lock"]

command.append("--screen=1")
command.append("--ignore-empty-password")
command.append("--insidecolor=" + insidecolor)
command.append("--ringcolor=" + ringcolor)
command.append("--linecolor=" + linecolor)
command.append("--keyhlcolor=" + keyhlcolor)
command.append("--ringvercolor=" + ringvercolor)
command.append("--insidevercolor=" + insidevercolor)
command.append("--ringwrongcolor=" + ringwrongcolor)
command.append("--insidewrongcolor=" + insidewrongcolor)
command.append("--blur=4")
command.append("--clock")
command.append("--timecolor=" + timecolor)
command.append("--timepos=3000:150")
command.append("--timesize=50")
command.append("--datecolor=" + datecolor)
command.append("--verifcolor=" + timecolor)
command.append("--wrongcolor=" + timecolor)
command.append("--verif-font=fontawesome")
command.append("--wrong-font=fontawesome")
command.append("--verifsize=50")
command.append("--wrongsize=50")
command.append("--veriftext=")
command.append("--wrongtext=")
command.append("--noinputtext=")

#command.append("--image=" + str(path))

if(subprocess.call(command)):
    backup = ["i3lock", "--image="+path]
    subprocess.call(["notify-send", "-t 100000", str(backup)])
    subprocess.call(backup)
