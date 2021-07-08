#!/bin/bash
# Pull updates of wiki from Gitlab Group
# alias = ghPWFGG
 

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghPWFGG gitlab_group_name\n\n"
  exit
fi

GITLAB_GROUP_NAME="$1" 
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}")
WIKI_NAME="${GITLAB_GROUP_NAME}.wiki" 
WIKI_ROOT="$LOCAL_PARENT_DIRECTORY/${GITLAB_GROUP_NAME}.wiki" 

if [ ! -d $WIKI_ROOT ]; then
    printf "\n$WIKI_ROOT does not exist.\nOperation canceled.\n\n"
    printf "Use ghCWFGG to clone the wiki for this Gitlab Group.\n\n"
    exit 1
fi 

printf "\nPull WIKI updates from upstream for $WIKI_NAME\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd "$WIKI_ROOT" 
git pull