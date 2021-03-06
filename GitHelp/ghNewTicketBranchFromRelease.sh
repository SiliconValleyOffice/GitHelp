#!/bin/bash
# Create a New ticket branch from upstream release branch
# alias = ghNTBR

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNTBR ticket_id release_number\n"
  printf "  create New ticket Branch from upstream release.\n\n"
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
UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseReleaseBranch.sh $2`

$GITHELP_HOME/ghOriginBranchExists.sh ${TICKET_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${TICKET_BRANCH}\" already exists.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewMiscBranch.sh $TICKET_BRANCH $UPSTREAM_BRANCH
