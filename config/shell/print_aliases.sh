#!/bin/bash

SCRIPTPATH=$(cd "$(dirname "$0")" ; pwd -P);
ALIASPATH=${SCRIPTPATH}/aliases;

CL_LIGHT_BLUE='\e[0;94m';
CL_CYAN='\e[0;36m';
CL_BLUE='\e[0;34m';
CL_PURP='\e[0;35m';
CL_RESET='\e[0m';
CL_UL='\e[4m'

CM_CYAN=`printf ${CL_CYAN}`;
CM_BLUE=`printf ${CL_BLUE}`;
CM_PURP=`printf ${CL_PURP}`;
CM_RESET=`printf ${CL_RESET}`;

SD_COLORIZE_ALIAS="s/alias \([^=]*\)=\(.*\)/$CM_CYAN\1$CM_RESET -> $CM_PURP\2$CM_RESET/g"
SD_COLORIZE_SECTION="s/#.*/$CM_BLUE\0/g"
SD_REMOVE_REDUNDANT="/^$/d; s/#/\n#/g"

if [ $# -eq 0 ]; then
    if [ `command -v bat` != "" ]; then
        cat ${ALIASPATH} | sed "${SD_COLORIZE_ALIAS}" | sed "${SD_COLORIZE_SECTION}" | sed "/pals/d" | sed "${SD_REMOVE_REDUNDANT}" | bat
    else
        cat ${ALIASPATH} | sed "${SD_COLORIZE_ALIAS}" | sed "${SD_COLORIZE_SECTION}" | sed "/pals/d" | sed "${SD_REMOVE_REDUNDANT}" | less
    fi
else
    if [ $1 == "sections" ]; then
        cat ${ALIASPATH} | sed "${SD_COLORIZE_SECTION}" | sed "${SD_REMOVE_REDUNDANT}" | sed "/#/!d"
        exit
    fi
    printf "\n${CL_LIGHT_BLUE}${CL_UL}Section matching \"$1\" for `whoami`\n"
    cat ${ALIASPATH} | sed -n -e "/# $1/,/#/ p" | sed -e '2d;$d' | sed "${SD_COLORIZE_ALIAS}" | sed "${SD_COLORIZE_SECTION}" | sed "${SD_REMOVE_LIGHT_BLUEUNDANT}" | sed "/pals/d"
    printf "\n${CL_LIGHT_BLUE}${CL_UL}Aliases containing \"$1\" for `whoami`\n"
    cat ${ALIASPATH} | sed "${SD_COLORIZE_ALIAS}" | sed "${SD_COLORIZE_SECTION}" | sed "/pals/d" | sed "/$1/!d" | sed "/#/d" | sed "${SD_REMOVE_REDUNDANT}"
fi
printf "\n"
