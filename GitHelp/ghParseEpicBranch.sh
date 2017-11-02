#!/bin/bash
# Parse a Release Branch named

if [ $# -ne 1 ]; then
    printf "\nERROR: ghParseEpicBranch.sh  JIRA_Number\n"
    printf "       Missing argument.\n\n"
    exit 1
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a JIRA number.\n\n"
    exit 1
fi

EPIC_BRANCH="${JIRA_TICKET_PREFIX}-${1}"

echo "epic/$EPIC_BRANCH"
