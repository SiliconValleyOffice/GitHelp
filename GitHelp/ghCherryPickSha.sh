#!/bin/bash
# cherry pick SHA into branche
# ghCPSHA

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghCPSHA [sha]\n"
  printf "    Cherry Pick SHA into branch\n\n"
  exit
fi

SHA=${1}
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`

printf "\nCherry pick SHA \"$SHA\"\n"
printf "into the current branch named \"${CURRENT_BRANCH}\".\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

git cherry-pick -x $SHA

printf "\n"
