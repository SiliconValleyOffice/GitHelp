#!/bin/bash
# local git CONFIGuration
# alias = ghCONFIG

source ~/.githelp_profile

printf "\nCurrent GitHub configuration:\n"
printf "    GITHUB_USER = '$GITHUB_USER' \n"
printf "    GIT_ROOT = '$GIT_ROOT' \n"
printf "    JIRA_TICKET_PREFIX = '$JIRA_TICKET_PREFIX' \n\n"

if [ $# -eq 0 ]; then
    if [ -a ~/.githelp_profile_list ]; then
      ~/.githelp_profile_list
    fi
    printf "\nYou can change the configuration with the following command.\n"
    printf "    Usage: ghCONFIG GitHub_user git_root JIRA_ticket_prefix\n\n"
    exit 1
fi

if [ $# -ne 3 ]; then
  printf "Usage:\n    ghCONFIG\n    - to see the current GitHelp configuration\n\n    ghCONFIG GitHub_user git_root JIRA_ticket_prefix\n    - to change the GitHelp configuration\n\n"
    exit 1
fi

NEW_PROFILE='#!/bin/bash'
NEW_PROFILE="$NEW_PROFILE \nexport GITHUB_USER=$1"
NEW_PROFILE="$NEW_PROFILE \nexport GIT_ROOT=$2"
NEW_PROFILE="$NEW_PROFILE \nexport JIRA_TICKET_PREFIX=$3"
echo -e "$NEW_PROFILE" > ~/.githelp_profile

source ~/.githelp_profile

printf "\nNew GitHub configuration:\n"
printf "    GITHUB_USER = '$GITHUB_USER' \n"
printf "    LOCAL_GIT_ROOT = '$GIT_ROOT' \n\n"

printf "\nWARNING:\n    Don't forget to update environment variables by running\n    source ~/.bash_profile\n\n"

printf "Use ghROOT to change directory to the new git root of\n    $GIT_ROOT.\n\n"
