#!/bin/bash
# Clone wiki for current upstream repo
# alias = ghCW

# Assumption - we are cloning the wiki for the current githelp repo

 
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}")
REPO_NAME="${GIT_ROOT##*/}.wiki"
REPO_ROOT=${GIT_ROOT}.wiki

if [ -d $REPO_ROOT ]; then
    printf "\n$REPO_ROOT already exists.\nOperation canceled.\n\n"
    printf "Use ghPW to get the latest wiki files.\n\n"
    exit 1
fi

UPSTREAM_PROJECT=`git config --get remote.upstream.url | sed 's/\.git//'`
eval UPSTREAM="${UPSTREAM_PROJECT}.wiki.git"

printf "\nClone WIKI from $UPSTREAM\n    into $REPO_ROOT\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd "$LOCAL_PARENT_DIRECTORY"
git clone "$UPSTREAM"
if [ $? -eq 0 ]; then
    cd $REPO_NAME
    git config --global push.default simple
    git remote add upstream $UPSTREAM
fi
