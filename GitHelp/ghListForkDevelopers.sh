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

$GITHELP_HOME/ghProjectConfigExists.sh $DEV_LIST
DEV_LIST_EXISTS=$?

if [ $DEV_LIST_EXISTS -eq 0 ]; then
    printf "\nDevelopers with a Fork:\n\n"
    cut -d ' ' -f1 $DEV_LIST
else
    printf "\nNo fork developers configured."
    printf "\nTo configure, add developers' usernames to $DEV_LIST.\n"
fi