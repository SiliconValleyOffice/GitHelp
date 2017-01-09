#!/bin/bash
# create a New Derived Misc git Branch
# alias = ghNDMB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNDJB JIRA_number\n"
  printf "Creates a new JIRA branch from the current branch.\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a JIRA Jira number.\n\n"
    exit 1
fi

JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${1}"

$GITHELP_HOME/ghNewDerivedMiscBranch.sh $JIRA_BRANCH
