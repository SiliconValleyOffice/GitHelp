#!/bin/bash
# Change Repository
# alias = ghCR

if [ ! -d "$HOME/REPO" ] ; then
  printf "\nghCR - Fatal Error !!!"
  printf "    Your home directory does not contain a REPO directory.\n\n"
  exit 1
fi

cd $HOME/REPO

if [[ $# -eq 0 ]] ; then
  REPO_LIST=`ls -d */ 2>/dev/null`
  if [ $? -ne 0 ] ; then
    printf "No local repositories.\n\n"
  else
    printf "Available repositories:\n"
    for REPO in "${REPO_LIST[@]}"; do
      echo "${REPO}" | tr -d '/'
    done
    printf "\nCurrent repository:\n"
    CURRENT_REPO=`echo $GIT_ROOT | rev | cut -d/ -f1 | rev`
    printf "  $CURRENT_REPO\n"
  fi
  exit 1
fi

if [[ $# -ne 1 ]] ; then
  printf "Usage:\n"
  printf "    ghCR - Change Repository\n\n"
  printf "    ghCR repository_name\n"
  printf "      * make repository_name active\n"
  printf "      * move to that repository directory\n\n"
  printf "    ghCR without any arguments\n"
  printf "      * list available repositories\n"
  printf "      * print name of active repository\n\n"
  exit 1
fi

REPO_CONFIG=`grep REPO/$1 $HOME/.githelp_profile_list`
if [[ $? -ne 0 ]] ; then
  printf "\nFatal error:  No configuration for $1\n\n"
  exit 1
fi
PRUNED_REPO_CONFIG=`echo $REPO_CONFIG | sed 's/printf " //' | sed 's/ \\\n"//'`

$GITHELP_HOME/ghCONFIG.sh $PRUNED_REPO_CONFIG

