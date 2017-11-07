#!/bin/bash
# Create a new Misc branch from a SHA
# alias = ghNMBS

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNMBS misc_branch SHA\n"
  printf "  create New Misc Branch From SHA.\n\n"
  exit
fi

MISC_BRANCH="${1}"
SHA=$2

$GITHELP_HOME/ghOriginBranchExists.sh ${MISC_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${MISC_BRANCH}\" already exists.\n\n"
    exit 1;
fi

git checkout -b $MISC_BRANCH $SHA
