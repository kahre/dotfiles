#!/bin/bash

PID=`xprop | grep WM_PID | sed 's/.*= \([0-9]*\)/\1/g'`

kill $PID
