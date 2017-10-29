#!/bin/bash
# Add, Commit and Push

if [ "$#" -ne 1  -o  -z "$1" ]; then
  printf "\nUsage: ghACP commit_message\n"
  printf "  Add, Commit (with message) and Push\n\n"
  exit 0
fi

COMMIT_MESSAGE=${1}

STATUS_RESULTS=`git status`
if [[ "$STATUS_RESULTS"  == *"nothing to commit"* ]] ; then
  printf "    There is nothing to commit.\n\n"
  exit 0
fi

printf "\nChanges:\n"
git status --porcelain

printf "\nAdd all changes, Commit with message, and Push to origin\n"
printf "    with message \"${COMMIT_MESSAGE}\"\n\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "\n"

git add -A
git commit -m "$COMMIT_MESSAGE"
git push origin

printf "\n"
