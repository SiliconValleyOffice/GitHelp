#!/bin/bash
# Fetch a branch from UPSTREAM that does not exist locally
git remote update upstream --prune

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 remote_branch_name"
  exit
fi

if [[ `git branch` == *"${1}"* ]] ; then
    printf "ERROR:  The branch named \"${1}\" already exists locally.\n"
    exit 1;
fi

BRANCH_NAME=$1

printf "Fetch branch named \"$BRANCH_NAME\" from Upstream that does not exist locally.\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh

git branch -f $BRANCH_NAME upstream/$BRANCH_NAME
git checkout $BRANCH_NAME
git submodule update --init --recursive

printf "\n\nNew branch state:"
git branch -a
