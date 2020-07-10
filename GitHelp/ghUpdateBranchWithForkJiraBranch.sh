#!/bin/bash
# Update Branch with Fork JIRA Branch
# alias = ghUBFJB

if [ $# -ne 2 ]; then
    printf "\nUsage: ghUBFJB git_user_name JIRA_number\n"
    printf "    git_user_id = owner of the Fork\n"
    printf "    Update Branch with Fork JIRA Branch\n\n"
    exit 1
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $2 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Second argument is not a JIRA number.\n\n"
    exit 1
fi

FORK_OWNER=$1
JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${2}"

$GITHELP_HOME/ghUpdateBranchWithForkBranch.sh $1 $JIRA_BRANCH
