#!/bin/bash
# create a New Derived Misc git Branch
# alias = ghNDMB

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNDMB branch_name\n"
  printf "Creates a new branch from the current branch.\n\n"
  exit
fi

DERIVED_BRANCH=${1}
BASE_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`

$GITHELP_HOME/ghOriginBranchExists.sh ${DERIVED_BRANCH}
if [[ $? -ne 1 ]] ; then
    printf "\nERROR:  The branch named \"${DERIVED_BRANCH}\" already exists.\n\n"
    exit 1;
fi

printf "\nCreate a new Derived branch named \"$DERIVED_BRANCH\"\n"
printf "from the current branch named \"${BASE_BRANCH}\".\n"
printf "    An origin tracking branch will be created.\n"
printf "    You will be working in the new branch after creation.\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh

git checkout -b ${DERIVED_BRANCH}
git fetch origin
git push origin ${DERIVED_BRANCH} &> /dev/null
git branch --set-upstream-to=origin/${DERIVED_BRANCH}

printf "\nLocal branch state:\n"
git branch
printf "\n"
