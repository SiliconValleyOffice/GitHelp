#!/bin/bash
# Fetch a branch from Origin that does not exist locally
git remote update origin --prune

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 remote_branch_name"
  exit
fi

if [[ `git branch` == *"${1}"* ]] ; then
    printf "ERROR:  The branch named \"${1}\" already exists locally.\n"
    exit 1;
fi

printf "Fetch branch named \"${1}\" from Origin that does not exist locally.\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh

git branch -f ${1} origin/${1}
git checkout ${1}

printf "\n\nNew branch state:"
git branch -a
