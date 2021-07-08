#!/bin/bash
# Clone wiki from Gitlab Group
# alias = ghCWFGG
 

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghCWFGG gitlab_group_name\n\n"
  exit
fi

GITLAB_GROUP_NAME="$1"
GITLAB_URL="https://gitlab.com"
LOCAL_PARENT_DIRECTORY=$(dirname "${GIT_ROOT}")
WIKI_NAME="${GITLAB_GROUP_NAME}.wiki" 
WIKI_ROOT="$LOCAL_PARENT_DIRECTORY/${GITLAB_GROUP_NAME}.wiki" 

if [ -d $WIKI_ROOT ]; then
    printf "\n$WIKI_ROOT already exists.\nOperation canceled.\n\n"
    printf "Use gitPWFGG to get the latest wiki files.\n\n"
    exit 1
fi

eval UPSTREAM="$GITLAB_URL/$WIKI_NAME"

printf "\nClone WIKI from $UPSTREAM\n    into $WIKI_ROOT\n"
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
    cd $WIKI_NAME
    git config --global push.default simple
    git remote add upstream $UPSTREAM
fi
