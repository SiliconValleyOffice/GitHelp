#!/bin/bash
# Create a new git branch to work on a ticket
# alias = ghNTBD

if [ "$#" -lt 1 ]; then
  printf "\nUsage: ghNTBD ticket_id [upstream_release_branch_number]\n"
  printf "  default upstream_branch = '${DEVELOPMENT_BRANCH}'\n"
  printf "  Create new origin branch from upstream branch.\n\n"
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

$GITHELP_HOME/ghNewMiscBranch.sh $TICKET_BRANCH $2
