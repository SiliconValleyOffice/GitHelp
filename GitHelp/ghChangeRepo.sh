#!/bin/bash
# Change Repository
# alias = ghCR

if [ ! -d "$HOME/REPO" ] ; then
  printf "\nghCR - Fatal Error !!!"
  printf "    Your home directory does not contain a REPO directory.\n\n"
  exit 1
fi

cd $HOME/REPO

if [ $# -eq 0 ]; then
  REPO_LIST=`ls -d */ 2>/dev/null`
  if [ $? -ne 0 ] ; then
    printf "\nNo local repositories.\n\n"
  else
    for REPO in "${REPO_LIST[@]}"; do
      printf "${REPO}"
    done
    printf "\n\nghCR repository_name\n    will change repositories\n\n"
  fi
  exit 1
fi

if [ $# -ne 1 ]; then
  printf "Usage:\n"
  printf "    ghCR - Change Repository\n\n"
  printf "    ghCR repository_name\n"
  printf "    ghCR without any arguments will list available repositories\n\n"
    exit 1
fi

exit 1

NEW_PROFILE='#!/bin/bash'
NEW_PROFILE="$NEW_PROFILE \nexport GIT_HOST_URL=$1"
NEW_PROFILE="$NEW_PROFILE \nexport GITHUB_USER=$2"
NEW_PROFILE="$NEW_PROFILE \nexport GIT_ROOT=$3"
NEW_PROFILE="$NEW_PROFILE \nexport JIRA_TICKET_PREFIX=$4"
echo -e "$NEW_PROFILE" > ~/.githelp_profile

source ~/.githelp_profile

printf "\nNew GitHub configuration:\n"
printf "    GIT_HOST_URL = '$GIT_HOST_URL' \n"
printf "    GITHUB_USER = '$GITHUB_USER' \n"
printf "    GIT_ROOT = '$GIT_ROOT' \n"
printf "    JIRA_TICKET_PREFIX = '$JIRA_TICKET_PREFIX' \n\n"

