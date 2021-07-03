#!/bin/bash
# Update Branch with Fork Ticket Branch
# alias = ghUBFTB

if [ $# -ne 2 ]; then
    printf "\nUsage: ghUBFTB git_user_name ticket_id\n"
    printf "    git_user_id = owner of the Fork\n"
    printf "    Update Branch with Fork Ticket Branch\n\n"
    exit 1
fi

TICKET_ID=$2

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_TICKET_ID=$?

if ! [[ $IS_VALID_TICKET_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument 2 is not a valid $TICKET_SOURCE ticket ID.\n\n"
    exit 1
fi

FORK_OWNER=$1
TICKET_BRANCH="${TICKET_PREFIX}-${TICKET_ID}"

$GITHELP_HOME/ghUpdateBranchWithForkBranch.sh $FORK_OWNER $TICKET_BRANCH
