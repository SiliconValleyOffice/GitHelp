#!/bin/bash
# Commit modified tracked files in the current branch
# alias = ghCMTF

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

BRANCH_NAME=`~/gitHelp/gitCurrentBranchName.sh`

GIT_STATUS=`git status`
if [[ "$GIT_STATUS" == *"nothing to commit"* ]]; then
    printf "\nNothing to commit in the branch named \"$BRANCH_NAME\".\n\n"
    exit 0;
fi

NOT_JIRA_WWFT=`~/gitHelp/gitCurrentBranchIsJiraWwft.sh`
if [[ $# -ne 1 ]] && [[ $NOT_JIRA_WWFT -eq 1 ]]; then
# if [[ $# -ne 1 ]] ; then
  printf "\nUsage: $0 [commit_message]\n"
  printf "        Commit message required when not a Jira WWFT branch.\n\n"
  exit
fi

if [[ $NOT_JIRA_WWFT -eq 1 ]]; then
    COMMIT_MESSAGE=$1
elif [[ $# -eq 1 ]]; then
    COMMIT_MESSAGE="$BRANCH_NAME : $1"
else
    COMMIT_MESSAGE=$BRANCH_NAME    
fi 

printf "\nCommit all changes to tracked files in the branch named \"${BRANCH_NAME}\".\n"
printf "    Comment will be \"$COMMIT_MESSAGE\".\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

git add -u
git commit -m "${COMMIT_MESSAGE}"

git status -s
printf "\nDon't forget to push your changes.\n\n"
