#!/bin/bash
# local git CONFIGuration
# alias = ghCONFIG

source ~/.githelp_profile 2>&1

STATUS="Previous"
if [ $# -eq 0 ]; then

  if [ -a ~/.githelp_profile ] ; then
    STATUS="Currrent"
  else
      printf "\nGitHelp installation:\n"
      printf "    No Origins have been cloned.\n"
      printf "    Use ghCO to Clone an Origin (a developer fork).\n\n"
      exit 1
  fi
fi

printf "\n${STATUS} GitHub configuration:\n"
printf "    GIT_HOST_URL = '$GIT_HOST_URL' \n"
printf "    GITHUB_USER = '$GITHUB_USER' \n"
printf "    GIT_ROOT = '$GIT_ROOT' \n"
printf "    JIRA_TICKET_PREFIX = '$JIRA_TICKET_PREFIX' \n\n"

if [ $# -eq 0 ]; then
    if [ -a ~/.githelp_profile_list ]; then
      ~/.githelp_profile_list
    fi
    printf "\nYou can change the configuration with the following command.\n"
    printf "    Usage: ghCONFIG  Git_Host_URL  GitHub_user  git_root  JIRA_ticket_prefix\n"
    printf "        (\"ghCONFIG \" + copy/paste a row from the GitHelp Configurations list above)\n\n"
    exit 1
fi

if [ $# -ne 4 ]; then
  printf "Usage:\n"
  printf ""    ghCONFIG\n    - to see the current GitHelp configuration\n\n"
  printf "    ghCONFIG GitHub_user git_root JIRA_ticket_prefix\n"
  printf ""    - to change the GitHelp configuration\n"
  printf "       (\"ghCONFIG \" + copy/paste a row from the GitHelp Configurations list above)\n\n"
    exit 1
fi

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

printf "\nWARNING:\n    Don't forget to update environment variables by running\n    source ~/.bash_profile\n\n"

printf "Use ghROOT to change directory to the new git root of\n    $GIT_ROOT.\n\n"
