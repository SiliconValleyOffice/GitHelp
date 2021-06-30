#!/bin/bash
# Fetch Fork Ticket Branch
# alias = ghFFTB

if [ $# -ne 2 ]; then
    printf "\nUsage: ghFFTB git_user_name ticket_id\n"
    printf "    git_user_id = owner of the Fork\n"
    printf "    Fetch Fork Ticket Branch\n\n"
    exit 1
fi

TICKET_ID=$2

$GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
IS_VALID_ID=$?

if ! [[ $IS_VALID_ID -eq 0 ]] ; then
    printf "\n    ERROR: Argument is not a valid $TICKET_TYPE ticket ID.\n\n"
    exit 1
fi

DEVELOPER_LOGIN_ID=$1
TICKET_BRANCH="${TICKET_PREFIX}-${TICKET_ID}"
LOCAL_DF_BRANCH="DF-$DEVELOPER_LOGIN_ID/$BRANCH_NAME"
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $LOCAL_DF_BRANCH = $CURRENT_BRANCH ]]; then
    printf "WARNING:  Already on the branch named \"${TICKET_BRANCH}\".\n\n"
    git branch
    exit 1;
fi


$GITHELP_HOME/ghFetchForkMiscBranch.sh $1 $TICKET_BRANCH
