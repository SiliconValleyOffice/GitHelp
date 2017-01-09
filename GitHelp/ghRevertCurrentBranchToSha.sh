#!/bin/bash
# Destroy current branch from the Origin, and locally
# alias = ghRSHA

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghRSHA SHA_number\n"
  printf "  Revert current branch to SHA.\n\n"
  exit
fi

SHA=$1

CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh 2>/dev/null`

SHA_DETAILS=`git show --no-patch --oneline $SHA`
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  SHA \"${SHA}\" does not exist.\n\n"
    exit 1;
fi

printf "\nREVERT the current branch named \"$CURRENT_BRANCH\"\n    to SHA = \"$SHA\" ?\n\n"
printf "    Origin will also be reverted.\n\n"
printf "    SHA Details:\n    $SHA_DETAILS\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

git reset --hard $SHA
git push --force origin
