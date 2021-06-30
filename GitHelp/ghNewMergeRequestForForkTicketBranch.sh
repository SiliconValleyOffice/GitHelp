#!/bin/bash
# New Merge Request for Fork Ticket Branch
# alias = ghNMRFTB

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNMRFTB fork_owner ticket_id\n"
  printf "  New Merge Request for Fork ticket Branch.\n\n"
  exit
fi

TICKET_ID=$2

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_ID=$?

if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument is not a valid $TICKET_TYPE ticket ID.\n\n"
    exit 1
fi

FORK_OWNER=$1
TICKET_BRANCH="${TICKET_PREFIX}-${TICKET_ID}"

$GITHELP_HOME/ghNewPullRequestForFork.sh $FORK_OWNER $TICKET_BRANCH
