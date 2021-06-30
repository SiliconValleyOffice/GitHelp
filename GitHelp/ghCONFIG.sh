#!/bin/bash
# local git CONFIGuration
# alias = ghCONFIG

if [ -a ~/.githelp_profile ] ; then
  source ~/.githelp_profile 2>&1
fi

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
printf "    TICKET_TYPE = '$TICKET_TYPE' \n"
printf "    TICKET_BASE_URL = '$TICKET_BASE_URL' \n"
printf "    TICKET_PREFIX = '$TICKET_PREFIX' \n"
printf "    DEVELOPMENT_BRANCH = '$DEVELOPMENT_BRANCH' \n\n"

if [ $# -eq 0 ]; then
    if [ -a ~/.githelp_profile_list ]; then
      ~/.githelp_profile_list
    fi
    printf "\nYou can change the configuration with the following command.\n"
    printf "    Usage: ghCONFIG  Git_Host_URL  GitHub_user  git_root  ticket_type ticket_base_url ticket_prefix  DEVELOPMENT_BRANCH\n"
    printf "        (\"ghCONFIG \" + copy/paste a row from the GitHelp Configurations list above)\n\n"
    printf "A much easier method is to use the ghCR command to Change Repository.\n\n"
    exit 1
fi

if [ $# -ne 7 ]; then
  printf "Usage:\n"
  printf "    ghCONFIG\n    - to see the current GitHelp configuration\n\n"
  printf "    ghCONFIG  Git_Host_URL  GitHub_user  git_root  ticket_type ticket_base_url ticket_prefix  DEVELOPMENT_BRANCH\n"
  printf "    - to change the GitHelp configuration\n"
  printf "       (\"ghCONFIG \" + copy/paste a row from the GitHelp Configurations list above)\n\n"
  printf "A much easier method is to use the ghCR command to Change Repository.\n\n"
  exit 1
fi

NEW_PROFILE='#!/bin/bash'
NEW_PROFILE="$NEW_PROFILE \nexport GIT_HOST_URL=$1"
NEW_PROFILE="$NEW_PROFILE \nexport GITHUB_USER=$2"
NEW_PROFILE="$NEW_PROFILE \nexport GIT_ROOT=$3"
NEW_PROFILE="$NEW_PROFILE \nexport TICKET_TYPE=$4"
NEW_PROFILE="$NEW_PROFILE \nexport TICKET_BASE_URL=$5"
NEW_PROFILE="$NEW_PROFILE \nexport TICKET_PREFIX=$6"
NEW_PROFILE="$NEW_PROFILE \nexport DEVELOPMENT_BRANCH=$7"
echo -e "$NEW_PROFILE" > ~/.githelp_profile

source ~/.githelp_profile

printf "New GitHub configuration:\n"
printf "    GIT_HOST_URL = '$GIT_HOST_URL' \n"
printf "    GITHUB_USER = '$GITHUB_USER' \n"
printf "    GIT_ROOT = '$GIT_ROOT' \n"
printf "    TICKET_TYPE = '$TICKET_TYPE' \n"
printf "    TICKET_BASE_URL = '$TICKET_BASE_URL' \n"
printf "    TICKET_PREFIX = '$TICKET_PREFIX' \n"
printf "    DEVELOPMENT_BRANCH = '$DEVELOPMENT_BRANCH' \n\n"

