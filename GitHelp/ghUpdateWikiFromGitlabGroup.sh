#!/bin/bash
# Push latest changes to upstream wiki
# alias = ghUW

# Assumption - we are working with the wiki for the current githelp repo


if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghUW gitlab_group_name\n\n"
  exit
fi

GITLAB_GROUP_NAME="$1"
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}")
BASE_REPO=${GIT_ROOT##*/}
REPO_NAME="${BASE_REPO}.wiki"
REPO_ROOT=${GIT_ROOT}.wiki
WIKI_NAME="${GITLAB_GROUP_NAME}.wiki" 

if [ ! -d $REPO_ROOT ]; then
    printf "\n$REPO_ROOT does not exist.\nOperation canceled.\n\n"
    printf "Use ghCW to clone the wiki for the current repo.\n\n"
    exit 1
fi

if [ ! -d "$LOCAL_PARENT_DIRECTORY/$WIKI_NAME" ]; then
    printf "\n$LOCAL_PARENT_DIRECTORY/$WIKI_NAMEWIKI_NAME does not exist.\nOperation canceled.\n\n"
    printf "Use ghCWFGG to clone the wiki for this Gitlab Group.\n\n"
    exit 1
fi 

printf "\nUpdate upstream WIKI for $BASE_REPO\n"
printf "    with WIKI from Gitlab group ${GITLAB_GROUP_NAME} ?\n\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd $LOCAL_PARENT_DIRECTORY 
cp -rf $WIKI_NAME/* $REPO_ROOT
cd "$REPO_ROOT"
git add -A
LINES=`git status | grep "nothing to commit" | wc -l | cut -f1 -d' '`
if [ $LINES != "0" ]; then
  printf "\nNo local changes to push\n\n"
  exit
fi
git commit
git pull
git push
