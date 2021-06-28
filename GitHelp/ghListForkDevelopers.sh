#!/bin/bash
# list fork developers
# alias = ghLFD

if [ $# -ne 0 ]; then
    printf "\nUsage: ghLFD\n"
    printf "    List Fork Developers\n\n"
    exit
fi

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi

DEV_LIST=$GIT_ROOT/.gitHelp/forkDevelopers.ini

# Verify dev list file exists and contains more than whitespace
if [[ -f $DEV_LIST ]] && grep -q '[^[:space:]]' $DEV_LIST; then
    printf "\nDevelopers with a Fork:\n\n"
    cut -d ' ' -f1 $DEV_LIST
else
    printf "\nNo fork developers configured.\n"
    printf "\nTo configure, add developers' usernames to $DEV_LIST.\n"
fi