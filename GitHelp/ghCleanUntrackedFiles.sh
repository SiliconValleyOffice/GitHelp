#!/bin/bash
# clean untracked files
# alias = ghCUF

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

CLEAN_LIST=`git clean -d -n`
if [[ -z "$CLEAN_LIST" ]]; then
    printf "\nNo untracked files.\n\n"
else
    printf "\nClean untracked files.\n"
    printf "$CLEAN_LIST\n"
    read -p "Are you sure?  (y/n)   " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        printf "\nUntracked files will not be deleted.\n\n"
        exit 1
    fi
    git clean -d -f
fi

