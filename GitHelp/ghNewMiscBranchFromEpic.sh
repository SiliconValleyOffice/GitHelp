#!/bin/bash
# Create a New Misc branch from upstream epic branch
# alias = ghNMBE

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNMBE misc_branch_name epic_JIRA_number\n"
  printf "  create New Misc Branch from upstream epic.\n\n"
  exit
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $2 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Argument 2 (epic) is not a JIRA number.\n\n"
    exit 1
fi

MISC_BRANCH="${1}"
UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseEpicBranch.sh $2`

$GITHELP_HOME/ghOriginBranchExists.sh ${MISC_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${MISC_BRANCH}\" already exists.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewMiscBranch.sh $MISC_BRANCH $UPSTREAM_BRANCH
