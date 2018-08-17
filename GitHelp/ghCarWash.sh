#!/bin/bash
# Destroy all branches on Origin and Local, except development
# Reset all caches and etc to create a "clean" GitHelp baseline
# alias = ghCW

printf "\nGitHelp Car Wash\n"
printf "    Create a 'clean' GitHelp baseline environment\n\n"
printf "    !!!!!!!!! DANGER !!!!!!!!!\n"
printf "    * lose all local changes in the current branch\n"
printf "    * checkout and update the 'development' branch\n"
printf "    * Destroy all branches on Origin and Local, except 'development'\n"
printf "    * update cache\n"
printf "    \n"
printf "    This is non-recoverable !!!\n"
printf "    All work not in the Upstream repository will be lost !!!\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

read -p "Are you REALLY sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

