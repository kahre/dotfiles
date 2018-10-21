#!/bin/bash
IFS=$'\n'       # make newlines the only separator
for f in `find . -name '*' -printf "%h/%f\n"`

do
mv "$f" "${f// /_}"

done
