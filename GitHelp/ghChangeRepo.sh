#!/bin/bash
# Change Repository
# alias = ghCR

if [ ! -d "$HOME/REPO" ] ; then
  printf "\nghCR - Fatal Error !!!"
  printf "    Your home directory does not contain a REPO directory.\n\n"
  exit 1
fi

cd $HOME/REPO

if [ $# -eq 0 ] ; then
  REPO_LIST=`ls -d */ 2>/dev/null`
  if [ $? -ne 0 ] ; then
    printf "\nNo local repositories.\n\n"
  else
    printf "\nAvailable repositories:\n"
    for REPO in "${REPO_LIST[@]}"; do
      printf "${REPO}"
    done
    printf "\n\nCurrent repository:\n"
    cd $GIT_ROOT
    pwd
    printf "\nBranches:\n"
    git branch
  fi
  exit 1
fi

if [ $# -ne 1 ] ; then
  printf "Usage:\n"
  printf "    ghCR - Change Repository\n\n"
  printf "    ghCR repository_name\n"
  printf "      * make repository_name active\n"
  printf "      * move to that repository directory\n\n"
  printf "    ghCR without any arguments\n"
  printf "      * list available repositories\n"
  printf "      * move to the active repository directory\n\n"
  exit 1
fi

REPO_CONFIG=`grep REPO/$1 $HOME/.githelp_profile_list`
if [ $? -ne 0 ] ; then
  printf "\nFatal error:  No configuration for $1\n\n"
  exit 1
fi
PRUNED_REPO_CONFIG=`echo $REPO_CONFIG | sed 's/printf " //' | sed 's/ \\\n"//'`

$GITHELP_HOME/ghCONFIG.sh $PRUNED_REPO_CONFIG

