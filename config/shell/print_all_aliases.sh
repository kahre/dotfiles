#!/bin/bash

SCRIPTPATH=$(cd "$(dirname "$0")" ; pwd -P);

CL_RED='\033[0;31m';
CL_CYAN='\033[0;36m';
CL_BLUE='\033[0;34m';
CL_PURP='\033[0;35m';
CL_RESET='\033[0m';

CM_CYAN=`printf ${CL_CYAN}`;
CM_BLUE=`printf ${CL_BLUE}`;
CM_PURP=`printf ${CL_PURP}`;
CM_RESET=`printf ${CL_RESET}`;

SD_COLORIZE_ALIAS="s/\([^=]*\)=\(.*\)/$CM_CYAN\1$CM_RESET -> $CM_PURP\2$CM_RESET/g"

if [ $# -eq 0 ]; then
    alias | sed "${SD_COLORIZE_ALIAS}" | less
else
    TITLE=`printf "\n${CL_RED}Aliases containing \"$1\" in current env${CL_RESET}\n"`
    CONTENT=`alias | sed "${SD_COLORIZE_ALIAS}" | sed "/$1/!d" | sed "/#/d"`
    echo $TITLE"\n"$CONTENT | less
fi
printf "\n"

