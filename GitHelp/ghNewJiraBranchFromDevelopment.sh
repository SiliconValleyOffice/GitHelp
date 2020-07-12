#!/bin/bash
# Create a new git branch to work on a JIRA feature/bug
# alias = ghNJBD

if [ "$#" -lt 1 ]; then
  printf "\nUsage: ghNJBD JIRA_number [upstream_release_branch_number]\n"
  printf "  default upstream_branch = '${DEVELOPMENT_BRANCH}'\n"
  printf "  Create new origin branch from upstream branch.\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument is not a JIRA number.\n\n"
    exit 1
fi

JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${1}"

$GITHELP_HOME/ghNewMiscBranch.sh $JIRA_BRANCH $2
