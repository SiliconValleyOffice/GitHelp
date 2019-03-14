#!/bin/bash
# list developer fork branches
# alias = ghLFB

if [ $# -ne 1 ]; then
    printf "\nUsage: ghLFB github_user_name\n"
    printf "    List Fork Branches\n\n"
    exit
fi

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi

GITHUB_USER_TO_LOWER=`echo $GITHUB_USER | tr '[:upper:]' '[:lower:]'`

FORK=`git config --get remote.origin.url | tr '[:upper:]' '[:lower:]' | sed "s/$GITHUB_USER_TO_LOWER/$1/"`
printf "\nFork = $FORK\n"
git ls-remote --exit-code $FORK &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:\n    Either a fork does not exist for \"$1\",\n    or you have not been granted permissions.\n\n"
    exit 1
fi

git ls-remote --exit-code $FORK | sed '/deleted/d' | sed '/refs\/heads/!d' | sed 's/.*heads\///' | sed 's/./    &/'

printf "\n"
