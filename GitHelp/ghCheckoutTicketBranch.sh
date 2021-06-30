#!/bin/bash
# Checkout Ticket branch
# alias = ghCTB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghCTB ticket_id\n"
  printf "    Checkout Ticket Branch\n\n"
  exit
fi

TICKET_ID=$1

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_ID=$?

if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument is not a valid $TICKET_TYPE ticket ID.\n\n"
    exit 1
fi

BRANCH_NAME="${TICKET_PREFIX}-${TICKET_ID}"
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $BRANCH_NAME = $CURRENT_BRANCH ]]; then
    printf "WARNING:  Already on the branch named \"${BRANCH_NAME}\".\n\n"
    git branch
    exit 1;
fi

$GITHELP_HOME/ghOriginBranchExists.sh ${BRANCH_NAME}
if [[ $? -ne 0 ]] ; then
    printf "ERROR:  The branch named \"${BRANCH_NAME}\" does not exist on origin.\n\n"
    exit 1;
fi

git checkout $BRANCH_NAME
git branch
