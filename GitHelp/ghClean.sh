#!/bin/bash
# Clean
# alias = ghClean

RESULTS=`git clean -d -n`
if [ -z "$RESULTS" ] ; then
    printf "\n No \"Untracked\" files to CLEAN.\n"
    exit 0
fi

printf "\nCLEAN !!!\n"
printf "    All \"Untracked\" files will be deleted.\n"
printf "    This is non-recoverable!\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "\nThe following \"Untracked\" files will be deleted:\n"
git clean -d -n | sed 's/Would remove /    /g'

read -p "\nAre you REALLY sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

git clean -d -f
