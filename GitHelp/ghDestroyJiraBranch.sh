#!/bin/bash
# Destroy a JIRA branch from the Origin, and locally
# alias = ghDJB

if [ "$#" -lt 1 ]; then
  printf "\nUsage: ghDJB JIRA_number\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a JIRA number.\n\n"
    exit 1
fi

JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${1}"

$GITHELP_HOME/ghDestroyMiscBranch.sh $JIRA_BRANCH $2
