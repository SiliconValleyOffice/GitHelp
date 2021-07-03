#!/bin/bash
# Current branch is ticket

BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

if [[ $BRANCH_NAME != *"$TICKET_PREFIX-"* ]]; then
    printf "\nThis is not a ticket branch.\n\n"
    exit 1;
fi

ID=`cut -d "-" -f 2 <<< "$BRANCH_NAME"`
$GITHELP_HOME/ghValidateTicketId.sh $ID
IS_VALID_ID=$?
if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\nThis is not a valid ticket ID.\n\n"
    exit 1
fi