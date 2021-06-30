#!/bin/bash
# create a New Derived Ticket Branch
# alias = ghNDMB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNDTB ticket_id\n"
  printf "Creates a new ticket branch from the current branch.\n\n"
  exit
fi

TICKET_ID=$1

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_ID=$?

if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument is not a valid $TICKET_SOURCE ticket ID.\n\n"
    exit 1
fi

TICKET_BRANCH="${TICKET_PREFIX}-${TICKET_ID}"

$GITHELP_HOME/ghNewDerivedMiscBranch.sh $TICKET_BRANCH
