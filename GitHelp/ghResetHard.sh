#!/bin/bash
# Reset Hard
# alias = ghRH

printf "\nRESET HARD !!!\n"
printf "    All local changes will be lost.\n"
printf "    This is non-recoverable!\n"
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

git reset --hard
