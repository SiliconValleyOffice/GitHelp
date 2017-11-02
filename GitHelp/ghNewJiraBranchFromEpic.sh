#!/bin/bash
# Create a New JIRA branch from upstream epic branch
# alias = ghNJBFE

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNJBFE JIRA_number epic_JIRA_number\n"
  printf "  create New JIRA Branch from upstream epic.\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument 1 is not a JIRA number.\n\n"
    exit 1
fi

if ! [[ $2 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument 2 is not a JIRA number.\n\n"
    exit 1
fi

JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${1}"
UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseEpicBranch.sh $2`

$GITHELP_HOME/ghOriginBranchExists.sh ${JIRA_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${JIRA_BRANCH}\" already exists.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewMiscBranch.sh $JIRA_BRANCH $UPSTREAM_BRANCH
