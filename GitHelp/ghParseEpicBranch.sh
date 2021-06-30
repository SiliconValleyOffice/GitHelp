#!/bin/bash
# Parse a Epic Branch Name

if [ $# -ne 1 ]; then
    printf "\nERROR: ghParseEpicBranch.sh  epic_id\n"
    printf "       Missing argument.\n\n"
    exit 1
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a valid epic ID.\n\n"
    exit 1
fi

EPIC_BRANCH="${TICKET_PREFIX}-${1}"

echo "epic/$EPIC_BRANCH"
