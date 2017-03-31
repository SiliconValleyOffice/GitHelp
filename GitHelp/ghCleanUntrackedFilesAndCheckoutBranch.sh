#!/bin/bash
# clean untracked files and checkout branch
# alias = ghCACB

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

if [ "$#" -ne 1 ]; then
  printf "\nUsage: BRANCH_NAME\n\n"
  exit
fi

BRANCH_NAME=$1
$GITHELP_HOME/ghLocalBranchExists.sh ${BRANCH_NAME}
if [[ $? -ne 0 ]] ; then
    printf "\nFatal Error:  The local branch named \"${BRANCH_NAME}\" does not exist.\n\n"
    exit 1;
fi

CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $BRANCH_NAME = $CURRENT_BRANCH ]]; then
    printf "\nAlready on branch $BRANCH_NAME\n\n"
    exit 1;
fi

printf "\nClean untracked files in current branch named \"$CURRENT_BRANCH\"\n"
printf "and checkout existing branch named \"$BRANCH_NAME\"?\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh
git checkout $BRANCH_NAME
