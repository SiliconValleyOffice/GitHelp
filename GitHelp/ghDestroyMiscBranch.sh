#!/bin/bash
# Destroy a miscellaneous branch from the Origin, and locally
# alias = ghDMB

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghDMB branch_name\n\n"
  exit
fi

BRANCH_NAME="$1"
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $BRANCH_NAME = "${DEVELOPMENT_BRANCH}" ]]; then
  printf "\nCannot destroy your \"development\" branch.\n\n"
  exit 1
fi

if [[ $BRANCH_NAME = $CURRENT_BRANCH ]]; then
    SWITCH_TO_DEV_BRANCH=TRUE
else
    SWITCH_TO_DEV_BRANCH=FALSE
fi

$GITHELP_HOME/ghOriginBranchExists.sh ${BRANCH_NAME}  &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "ERROR:  The branch named \"${BRANCH_NAME}\" does not exist on origin.\n\n"
    exit 1;
fi

printf "\nDESTROY the branch named \"$BRANCH_NAME\" from origin?\n    Branch $BRANCH_NAME will also be deleted locally (if it exists).\n"
if [[ $SWITCH_TO_DEV_BRANCH = TRUE ]]; then
    printf "    You will be in the local \"development\" branch after the delete is finished.\n"
fi
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

if [[ $SWITCH_TO_DEV_BRANCH = TRUE ]]; then
    git stash &> /dev/null
    $GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh
    if [[ $? -ne 0 ]] ; then
        printf "FATAL ERROR:  Could not check out development branch.\n    Operation candeled.\n\n"
        exit 1;
    fi
fi

git fetch origin &> /dev/null
git branch -D $BRANCH_NAME  &> /dev/null
git push origin --delete $BRANCH_NAME
printf "\nOrigin branch state:\n"
$GITHELP_HOME/ghListOriginBranches.sh
printf "\nLocal branch state:\n"
git branch
printf "\n"
