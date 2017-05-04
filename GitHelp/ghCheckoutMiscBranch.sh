#!/bin/bash
# Checkout Misc branch
# alias = ghCMB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghCMB branch_name\n\n"
  exit
fi

BRANCH_NAME="${1}"
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
