#!/bin/bash
# Current branch is JIRA

BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

if [[ $BRANCH_NAME != *"$JIRA_TICKET_PREFIX-"* ]]; then
    printf "\nThis is not a JIRA branch.\n\n"
    exit 1;
fi

NUMBER=`cut -d "-" -f 2 <<< "$BRANCH_NAME"`
REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $NUMBER =~ $REGULAR_EXPRESSION ]] ; then
    printf "\nThis is not a valid JIRA number.\n\n"
    exit 1;
fi
