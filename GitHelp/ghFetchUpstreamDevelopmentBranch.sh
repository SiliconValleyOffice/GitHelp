#!/bin/bash
# fetch upstream development branch
# alias = ghFUDB

BRANCH_NAME=${DEVELOPMENT_BRANCH}

if [[ `git branch` == *"$BRANCH_NAME"* ]] ; then
    printf "\nFatal Error:  The branch named \"${BRANCH_NAME}\" already exists locally.\n"
    printf "Operation Canceled.\n\n"
    exit 1
fi

printf "\nFetch branch named \"${BRANCH_NAME}\" from upstream.\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh

git fetch upstream &> /dev/null
git branch -f $BRANCH_NAME upstream/$BRANCH_NAME
git checkout $BRANCH_NAME

printf "\nLocal branch state:\n"
git branch
printf "\n"
