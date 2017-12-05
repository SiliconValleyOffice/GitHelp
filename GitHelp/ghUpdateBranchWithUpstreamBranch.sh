#!/bin/bash
# update current branch with an upstream branch
# alias = ghUBUB

if [[ $# -gt 2 ]]; then
  printf "\nUsage: ghUBUB branch_name [-push]\n"
  exit
fi

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

UPSTREAM_BRANCH=$1
PUSH_OPTION=$2
STRATEGY_OPTION=""

$GITHELP_HOME/ghUpstreamBranchExists.sh ${UPSTREAM_BRANCH}  &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${UPSTREAM_BRANCH}\" does not exist on upstream\n\n"
    exit 1;
fi

BRANCH_NAME=`$GITHELP_HOME/ghCurrentBranchName.sh`

printf "\nUpdate the branch named \"${BRANCH_NAME}\" with upstream/${UPSTREAM_BRANCH}\n"
if [[ "$STRATEGY_OPTION" != "" ]]; then
    printf "STRATEGY_OPTION = $STRATEGY_OPTION\n"
fi
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi


git fetch upstream

MERGE_RESULTS="$(git merge $STRATEGY_OPTION upstream/${UPSTREAM_BRANCH})"
MERGE_EXIT=$?
if [[ $MERGE_EXIT -eq 128 ]]; then
    printf "Operation canceled.\n"
    printf "Fix merge errors and try again.\n\n"
    exit 1;
fi

if [[ "$MERGE_RESULTS" != *"Already"* ]] && [[ "$MERGE_RESULTS" != *"Automatic merge failed"* ]]; then
    if [ "$PUSH_OPTION" == "-push" ]; then
      git push;
    else
      printf "\n\nDon't forget to push these changes.\n\n"
    fi
    exit
fi

if [[ "$MERGE_RESULTS" == *"Merge made by the"* ]]; then
    if [ "$PUSH_OPTION" == "-push" ]; then
      git push;
    else
      printf "\n\nDon't forget to push these changes.\n\n"
    fi
    exit
fi

if [[ "$MERGE_RESULTS" = *"Already"* ]] ; then
    printf "\n\nAlready up-to-date.\n\n"
    exit
fi

printf "Operation canceled.\n"
printf "Fix merge errors and add/commit/push to origin.\n\n"
printf "$MERGE_RESULTS \n\n"
exit 1;
