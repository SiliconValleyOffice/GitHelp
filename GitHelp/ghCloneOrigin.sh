#!/bin/bash
# Clone Origin
# alias = ghCO

if [ "$#" -lt 3 ]; then
    printf "\nUsage: ghCO github_origin_clone_string upstream_owner development_branch [JIRA_ticket_prefix]\n"
    printf "    Clone Origin (developer fork).\n"
    printf "    JIRA_ticket_prefix default = NOJIRA\n"
    printf "    set upstream_owner = NONE if there is no upstream REPO\n\n"
    exit
fi

CLONE_STRING=$1
GIT_HOST=`echo $CLONE_STRING | cut -d/ -f3 `
GIT_URL="https://"$GIT_HOST
UPSTREAM_OWNER=$2
DEVELOPMENT_BRANCH=$3
if [ "$#" -eq 3 ]; then
    JIRA_TICKET_PREFIX="NOJIRA"
else
    JIRA_TICKET_PREFIX=$4
fi

LOCAL_PARENT_DIRECTORY="$HOME/REPO"

GITHUB_USER=`echo $CLONE_STRING | awk -F '/' '{print $4}'`
REPO_NAME=`echo $CLONE_STRING | awk -F '/' '{print $5}' | cut -f 1 -d'.'`
if [ -z $GITHUB_USER -o -z $REPO_NAME ]; then
  printf "\nBad clone string.\n"
  printf "Copy this string from the GitHub page for the Origin (developer fork).\n\n"
  exit
fi

if [ $UPSTREAM_OWNER != "NONE" ] && [ $GITHUB_USER = $UPSTREAM_OWNER ]; then
  printf "\nYou copied the clone string from an upstream repository,\n    not a fork (origin).\n"
  printf "Copy this string from the GitHub page for the Origin (developer fork).\n\n"
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

eval ORIGIN="${GIT_URL}/${GITHUB_USER}/${REPO_NAME}.git"
eval UPSTREAM="${GIT_URL}/${UPSTREAM_OWNER}/${REPO_NAME}.git"

git config --global credential.helper cache

git ls-remote --exit-code $ORIGIN &> /dev/null
if [ $? -ne 0 ]; then
    printf "\n$ORIGIN does not exist.\nOperation canceled.\n\n"
    exit 1
fi

if [ $UPSTREAM_OWNER != "NONE" ]; then
    git ls-remote --exit-code $UPSTREAM &> /dev/null
    if [ $? -ne 0 ]; then
        printf "\n$UPSTREAM does not exist.\nEnter valid parameters and try again.\nOperation canceled.\n\n"
        exit 1
    fi
fi

printf "\nClone Origin\n    from\n        $ORIGIN\n    into\n        $REPO_ROOT\n"
if [ $UPSTREAM_OWNER != "NONE" ]; then
    printf "    setting upstream to\n        $UPSTREAM\n"
else
  printf "    with no upstream upstream repository\n"
fi
printf "    setting development branch to\n        $DEVELOPMENT_BRANCH\n"
printf "    and the JIRA ticket prefix will be\n        $JIRA_TICKET_PREFIX\n\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

echo
cd "$LOCAL_PARENT_DIRECTORY"
git clone $ORIGIN
while [ $? -ne 0 ]; do
    printf "\n Try again...\n\n"
    git clone $ORIGIN
done
cd $REPO_NAME
git config --global push.default simple
git config credential.helper store

if [ $UPSTREAM_OWNER != "NONE" ]; then
    git remote add upstream $UPSTREAM
    git fetch upstream &> /dev/null
fi
git fetch origin &> /dev/null

PROFILE_URL=`echo $CLONE_STRING | sed 's/\.git//'`
PROFILE_ENTRY="$PROFILE_URL  $GITHUB_USER  $REPO_ROOT  $JIRA_TICKET_PREFIX  $DEVELOPMENT_BRANCH"

printf "\nRunning ghCONFIG to make this your active REPO...\n\n"
${GITHELP_HOME}/ghCONFIG.sh $PROFILE_ENTRY

if [ ! -f ~/.githelp_profile_list ]; then
    echo -n 'printf "GitHelp Configurations:\n"' > ~/.githelp_profile_list
    echo >> ~/.githelp_profile_list
    chmod 777 ~/.githelp_profile_list
fi

grep "$PROFILE_ENTRY" ~/.githelp_profile_list &> /dev/null
if [ $? -eq 1 ]; then
  echo  >> ~/.githelp_profile_list
  echo -n "printf \"   "  >> ~/.githelp_profile_list
  echo -n "$PROFILE_ENTRY" >> ~/.githelp_profile_list
  echo " \n\"" >> ~/.githelp_profile_list
fi


printf "NOTE:\n"
printf "    If this is a clone of a new Origin/fork, you must also\n"
printf "    run 'ghPOB' (ghPruneOriginBranches) in the new repository\n"
printf "    before creating any of your own branches\n\n"

