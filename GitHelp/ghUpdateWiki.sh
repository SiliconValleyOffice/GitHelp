#!/bin/bash
# Push latest changes to upstream wiki
# alias = ghUW

# Assumption - we are working with the wiki for the current githelp repo

 
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}")
BASE_REPO=${GIT_ROOT##*/}
REPO_NAME="${BASE_REPO}.wiki"
REPO_ROOT=${GIT_ROOT}.wiki

if [ ! -d $REPO_ROOT ]; then
    printf "\n$REPO_ROOT does not exist.\nOperation canceled.\n\n"
    printf "Use ghCW to clone the wiki for the current GitHelp repo.\n\n"
    exit 1
fi

printf "\nUpdate upstream WIKI for $BASE_REPO\n"
printf "    with local updates?\n\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd "$REPO_ROOT"
git add -A
LINES=`git status | grep "nothing to commit" | wc -l | cut -f1 -d' '`
if [ $LINES != "0" ]; then
  printf "\nNo local changes to push\n\n"
  exit
fi
git commit
git pull
git push
