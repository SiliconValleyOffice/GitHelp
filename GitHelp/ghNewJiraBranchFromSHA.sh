#!/bin/bash
# Create a new JIRA branch from a SHA
# alias = ghNJBFSHA

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNJBFSHA JIRA_number SHA\n"
  printf "  create New JIRA Branch from SHA.\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a JIRA number.\n\n"
    exit 1
fi

JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${1}"
SHA=$2

$GITHELP_HOME/ghOriginBranchExists.sh ${JIRA_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${ORIGIN_BRANCH}\" already exists.\n\n"
    exit 1;
fi

git checkout -b $JIRA_BRANCH $SHA
