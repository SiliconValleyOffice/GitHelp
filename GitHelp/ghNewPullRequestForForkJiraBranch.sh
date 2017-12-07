#!/bin/bash
# New Pull Request for Fork JIRA Branch
# alias = ghNPRFJB

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNPRFJB fork_owner JIRA_number\n"
  printf "  New Pull Request for Fork JIRA Branch.\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $2 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a JIRA number.\n\n"
    exit 1
fi

FORK_OWNER=$1
JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${2}"

$GITHELP_HOME/ghNewPullRequestForFork.sh $FORK_OWNER $JIRA_BRANCH
