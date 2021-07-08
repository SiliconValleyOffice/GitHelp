#!/bin/bash
# Push latest changes to Gitlab group wiki
# alias = ghUWFGG
 

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghUW gitlab_group_name\n\n"
  exit
fi

GITLAB_GROUP_NAME="$1"
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}") 
WIKI_NAME="${GITLAB_GROUP_NAME}.wiki"  
WIKI_ROOT="$LOCAL_PARENT_DIRECTORY/${GITLAB_GROUP_NAME}.wiki" 

if [ ! -d "$WIKI_ROOT" ]; then
    printf "\n$WIKI_ROOT does not exist.\nOperation canceled.\n\n"
    printf "Use ghCWFGG to clone the wiki for this Gitlab Group.\n\n"
    exit 1
fi 

printf "\nUpdate WIKI for Gitlab group ${GITLAB_GROUP_NAME}\n"
printf "    with local updates?\n\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo 
cd "$WIKI_ROOT"
git add -A
LINES=`git status | grep "nothing to commit" | wc -l`
if [ $LINES != "0" ]; then
  printf "\nNo local changes to push\n\n"
  exit
fi
git commit
git pull
git push
