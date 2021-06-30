#!/bin/bash
# Create a new ticket branch from a SHA
# alias = ghNTBS

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNTBS ticket_id SHA\n"
  printf "  create New ticket Branch from SHA.\n\n"
  exit
fi

TICKET_ID=$1

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_ID=$?

if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument 1 is not a valid $TICKET_SOURCE ticket ID.\n\n"
    exit 1
fi

TICKET_BRANCH="${TICKET_PREFIX}-${TICKET_ID}"
SHA=$2

$GITHELP_HOME/ghOriginBranchExists.sh ${TICKET_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${TICKET_BRANCH}\" already exists.\n\n"
    exit 1;
fi

git checkout -b $TICKET_BRANCH $SHA
