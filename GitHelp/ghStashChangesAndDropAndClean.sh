#!/bin/bash
# Stash Changes and Drop and Clean untracked files
# alias = ghSCDC

STATUS_RESULTS=`git status`
printf "\n$STATUS_RESULTS\n"
echo "$STATUS_RESULTS" | grep "working directory clean" &> /dev/null
if [[ $? -eq 0 ]] ; then
    exit
fi

printf "\nStash Changes and Drop them and Clean untracked files.\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf “\nOperation canceled.\n\n”
    exit 1
fi

git stash
git stash drop
$GITHELP_HOME/ghCleanUntrackedFiles.sh
