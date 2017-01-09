#!/bin/bash
# New Pull Request for a Development branch
# alias = ghNPRD

if [ $# -ne 0 ]; then
  printf "\nUsage: ghNPRD\n"
  printf "    Create a Pull Request for the current branch\n"
  printf "    against development.\n\n"
  exit
fi

$GITHELP_HOME/ghNewPullRequest.sh
