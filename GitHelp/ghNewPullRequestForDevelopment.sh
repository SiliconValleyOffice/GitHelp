#!/bin/bash
# Create a Pull Request
# alias = ghNPR

if [ "$#" -gt 0 ]; then
  printf "\nUsage: ghNPRD\n"
  printf "    no arguments accepted\n"
  printf "    upstream_branch = development\n\n"
  exit 1
fi

$GITHELP_HOME/ghNewPullRequest.sh development