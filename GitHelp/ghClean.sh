#!/bin/bash
# Clean
# alias = ghClean

printf "\nCLEAN !!!\n"
printf "    All changes that have not been \"Added\" will be lost.\n"
printf "    This is non-recoverable!\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "\nThe following changes will be lost:\n"
git clean -d -n | sed 's/Would remove /    /g'

read -p "\nAre you REALLY sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

git clean -d -f
