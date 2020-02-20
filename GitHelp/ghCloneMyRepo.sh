#!/bin/bash
# Clone my upstream repo
# alias = ghCMR


if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghCMR git_clone_string\n"
  printf "    Clone My Repository\n\n"
  exit
fi

CLONE_STRING=$1
LOCAL_PARENT_DIRECTORY="$HOME/REPO"

GITHUB_USER=`echo $CLONE_STRING | awk -F '/' '{print $4}'`
REPO_NAME=`echo $CLONE_STRING | awk -F '/' '{$1=$2=$3=$4=""; print $0}' | sed 's/\.git//' | sed 's/ //g'`

if [ -z $GITHUB_USER -o -z $REPO_NAME ]; then
  printf "\nBad clone string.\n"
  printf "Copy this string from the GitHub page for your Developer Fork.\n\n"
  exit
fi

REPO_ROOT=$LOCAL_PARENT_DIRECTORY/$REPO_NAME

if [ ! -d $LOCAL_PARENT_DIRECTORY ]; then
    mkdir $LOCAL_PARENT_DIRECTORY
fi

if [ -d $REPO_ROOT ]; then
    printf "\n$REPO_ROOT already exists.\nOperation canceled.\n\n"
    exit 1
fi

# there is no UPSTREAM, since this is my repo
eval REPOSITORY=$1

git ls-remote --exit-code $REPOSITORY &> /dev/null
if [ $? -ne 0 ]; then
    printf "\n$REPOSITORY does not exist.\nOperation canceled.\n\n"
    exit 1
fi

printf "\nClone GitHub repo $REPOSITORY\n    into $REPO_ROOT\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd "$LOCAL_PARENT_DIRECTORY"
git clone $REPOSITORY
cd $REPO_NAME
git config --global push.default simple
