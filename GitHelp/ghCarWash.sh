#!/bin/bash
# Clean up the current workspace

cd $GIT_ROOT
git status

printf "Clean git workspace.  All changes will be lost in the current branch.\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

# rm -rf .gradle
# rm -rf .idea
git clean -d -x -f
git reset --hard
git submodule update --init --recursive

printf "\n\nNew branch state:"
git branch -a
