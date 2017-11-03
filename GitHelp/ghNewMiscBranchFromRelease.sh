#!/bin/bash
# Create a New Misc branch from upstream release branch
# alias = ghNMBFR

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNMBFR misc_branch_name release_number\n"
  printf "  create New Misc Branch from upstream release.\n\n"
  exit
fi

MISC_BRANCH="${1}"
UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseReleaseBranch.sh $2`

$GITHELP_HOME/ghOriginBranchExists.sh ${MISC_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${MISC_BRANCH}\" already exists.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewMiscBranch.sh $MISC_BRANCH $UPSTREAM_BRANCH
