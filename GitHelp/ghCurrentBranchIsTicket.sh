#!/bin/bash
# Current branch is ticket

BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

if [[ $BRANCH_NAME != *"$TICKET_PREFIX-"* ]]; then
    printf "\nThis is not a ticket branch.\n\n"
    exit 1;
fi

ID=`cut -d "-" -f 2 <<< "$BRANCH_NAME"`
REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $ID =~ $REGULAR_EXPRESSION ]] ; then
    printf "\nThis is not a valid ticket ID.\n\n"
    exit 1;
fi
