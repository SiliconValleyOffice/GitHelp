#!/bin/bash
# Destroy a ticket branch from the Origin, and locally
# alias = ghDTB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghDTB ticket_id\n\n"
  exit
fi

TICKET_ID=$1

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_ID=$?

if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument is not a valid $TICKET_TYPE ticket ID.\n\n"
    exit 1
fi

TICKET_BRANCH="${TICKET_PREFIX}-${TICKET_ID}"

$GITHELP_HOME/ghDestroyMiscBranch.sh $TICKET_BRANCH
