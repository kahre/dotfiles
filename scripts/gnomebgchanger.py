#!/usr/bin/python3
from background import FindImagePaths
from background import randomImagePath
import subprocess
try:
    import Image
except ImportError as e:
    print ("could not import Image \n error: %s " % (e, ))
    try:
        from PIL import Image
    except ImportError:
        print ('import error exiting')
import re

ls = FindImagePaths(True, False, False)

roof = len(ls)
path = randomImagePath(ls)
im = Image.open(path)
print(path)
command = "gsettings set org.gnome.desktop.background picture-uri " + str(path)
subprocess.call(command.split())
