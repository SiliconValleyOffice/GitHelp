#!/bin/bash
# Fetch origin branch


if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghFOB origin_branch_name\n"
  printf "  Fetch origin branch\n\n"
  exit
fi

ORIGIN_BRANCH=${1}

git fetch
git checkout -b $ORIGIN_BRANCH origin/$ORIGIN_BRANCH
RESULT=$?

$GITHELP_HOME/ghCleanUntrackedFiles.sh

exit $RESULT
