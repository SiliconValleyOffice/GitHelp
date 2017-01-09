#!/bin/bash
# Checkout JIRA branch
# alias = ghCJB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghCJB JIRA_number\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: First argument is not a JIRA number.\n\n"
    exit 1
fi

BRANCH_NAME="${JIRA_TICKET_PREFIX}-${1}"
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
