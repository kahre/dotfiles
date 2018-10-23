#!/bin/bash

SCRIPTPATH=$(cd "$(dirname "$0")" ; pwd -P);
ALIASPATH=${SCRIPTPATH}/aliases;

CL_RED='\033[0;31m';
CL_CYAN='\033[0;36m';
CL_BLUE='\033[0;34m';
CL_PURP='\033[0;35m';
CL_RESET='\033[0m';

CM_CYAN='printf '${CL_CYAN};
CM_BLUE='printf '${CL_BLUE};
CM_PURP='printf '${CL_PURP};
CM_RESET='printf '${CL_RESET};

SD_COLORIZE_ALIAS="s/alias \([^=]*\)=\(.*\)/`$CM_CYAN`\1`$CM_RESET` -> `$CM_PURP`\2`$CM_RESET`/g"
SD_COLORIZE_SECTION="s/#.*/`$CM_BLUE`\0/g"
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
    printf "\n${CL_RED}Section matching \"$1\" for `whoami`\n"
    cat ${ALIASPATH} | sed -n -e "/# $1/,/#/ p" | sed -e '2d;$d' | sed "${SD_COLORIZE_ALIAS}" | sed "${SD_COLORIZE_SECTION}" | sed "${SD_REMOVE_REDUNDANT}" | sed "/pals/d"
    printf "\n${CL_RED}Aliases containing \"$1\" for `whoami`\n"
    cat ${ALIASPATH} | sed "${SD_COLORIZE_ALIAS}" | sed "${SD_COLORIZE_SECTION}" | sed "/pals/d" | sed "/$1/!d" | sed "/#/d" | sed "${SD_REMOVE_REDUNDANT}"
fi
printf "\n"
