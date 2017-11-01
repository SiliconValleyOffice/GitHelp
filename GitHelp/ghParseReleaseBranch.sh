#!/bin/bash
# Parse a Release Branch named

if [ ${#1} -lt 3 ]; then
    printf "\n    Parse Release Number:\n        ERROR_1: Argument \"$1\" is not a Release number.\n" >&2
    printf "        Too short.\n" >&2
    printf "        Examples: \"4.0\" or \"4.0.1\"\n\n" >&2
    exit 1
fi

REGULAR_EXPRESSION='^[0-9.]+$'
if ! [[ "$1" =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    Parse Release Number:\n        ERROR_2: Argument \"$1\" is not a Release number.\n" >&2
    printf "        Invalid characters.\n" >&2
    printf "        Examples: \"4.0\" or \"4.0.1\"\n\n" >&2
    exit 1
fi

REGULAR_EXPRESSION='[.]'
if ! [[ "$1" =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    Parse Release Number:\n        ERROR_3: Argument \"$1\" is not a Release number.\n" >&2
    printf "        Minor version number required.\n" >&2
    printf "        Examples: \"4.0\" or \"4.0.1\"\n\n" >&2
    exit 1
fi

if [ ${1:0:1} = "." ] ; then
    printf "\n    Parse Release Number:\n        ERROR_4: Argument \"$1\" is not a Release number.\n" >&2
    printf "        Cannot start with a \".\".\n" >&2
    printf "        Examples: \"4.0\" or \"4.0.1\"\n\n" >&2
    exit 1
fi

if [ "${1: -1}" = "." ] ; then
    printf "\n    Parse Release Number:\n        ERROR_5: Argument \"$1\" is not a Release number.\n" >&2
    printf "        Cannot end with a \".\".\n" >&2
    printf "        Examples: \"4.0\" or \"4.0.1\"\n\n" >&2
    exit 1
fi

OCCURRENCES=`echo "$1" | awk -F. '{ print NF - 1 }'`
if [ "$OCCURRENCES" -gt 2 ] ; then
    printf "\n    Parse Release Number:\n        ERROR_6: Argument \"$1\" is not a Release number.\n" >&2
    printf "        Too many \".\" characters.\n" >&2
    printf "        Examples: \"4.0\" or \"4.0.1\"\n\n" >&2
    exit 1
fi

echo "release/$1"
