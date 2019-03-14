#!/bin/bash
# update current branch with a fork branch
# alias = ghUBFB

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghUBFB github_user_id branch_name\n"
  printf "    github_user_id = owner of the Fork\n"
  printf "    Update Branch with Fork Branch\n\n"
  exit
fi

GITHUB_USER_TO_LOWER=`echo $GITHUB_USER | tr '[:upper:]' '[:lower:]'`

DEV_FORK=`git config --get remote.origin.url | tr '[:upper:]' '[:lower:]' | sed "s/$GITHUB_USER_TO_LOWER/$1/"`

git ls-remote --exit-code $DEV_FORK &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  A fork does not exist for \"$1\".\n\n"
    exit 1
fi


DEVELOPER_LOGIN_ID=$1
DEV_BRANCH_NAME=$2

$GITHELP_HOME/ghForkBranchExists.sh ${DEVELOPER_LOGIN_ID} ${DEV_BRANCH_NAME}

if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${DEV_BRANCH_NAME}\" does not exist on the fork owned by \"${DEVELOPER_LOGIN_ID}\".\n\n"
    exit 1;
fi

BRANCH_NAME=`$GITHELP_HOME/ghCurrentBranchName.sh`

printf "\nUpdate the branch named \"${BRANCH_NAME}\" \nwith the \"${DEV_BRANCH_NAME}\" branch from the fork owned by \"${DEVELOPER_LOGIN_ID}\".\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

if [[ `git remote` != *"$DEVELOPER_LOGIN_ID"* ]] ; then
    printf "\nCreating a remote for \"$1\"\n"
    git remote add $1 $DEV_FORK
fi

git fetch $DEVELOPER_LOGIN_ID &> /dev/null

MERGE_RESULTS="$(git merge $DEVELOPER_LOGIN_ID/$DEV_BRANCH_NAME)"
MERGE_EXIT=$?
if [[ $MERGE_EXIT -eq 128 ]]; then
    printf "Operation canceled.\n"
    printf "Fix merge errors and try again.\n\n"
    exit 1;
fi

if [[ "$MERGE_RESULTS" != *"Already"* ]] && [[ "$MERGE_RESULTS" != *"Automatic merge failed"* ]]; then
    printf "\n\nDon't forget to push these changes.\n\n"
    exit
fi

if [[ "$MERGE_RESULTS" == *"Merge made by the"* ]]; then
    printf "\n\nDon't forget to push these changes.\n\n"
    exit
fi

if [[ "$MERGE_RESULTS" = *"Already"* ]] ; then
    printf "\n\nAlready up-to-date.\n\n"
    exit
fi

printf "Operation canceled.\n"
printf "Fix merge errors and \"git commit\".\n\n"
printf "$MERGE_RESULTS \n\n"

git status
exit 1;
