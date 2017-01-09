#!/bin/bash
# Pull latest changes from upstream wiki
# alias = ghPW

# SPECIFIC TO BreakthroughBehavioralInc FOR NOW !!!
# Should be entirely driven by current githelp_profile

# Assumption - we are working with the wiki for the current githelp repo


if [ "$#" -ne 0 ]; then
  printf "\nUsage: ghPW\n\n"
  exit
fi

GITHUB_URL="github.com"
UPSTREAM_OWNER="BreakthroughBehavioralInc"
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}")
REPO_NAME="${GIT_ROOT##*/}.wiki"
REPO_ROOT=${GIT_ROOT}.wiki

if [ ! -d $REPO_ROOT ]; then
    printf "\n$REPO_ROOT does not exist.\nOperation canceled.\n\n"
    printf "Use gitCW to clone the wiki for the current GitHelp repo.\n\n"
    exit 1
fi

printf "\nPull WIKI updates from upstream for $REPO_NAME\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd "$REPO_ROOT"
git pull
