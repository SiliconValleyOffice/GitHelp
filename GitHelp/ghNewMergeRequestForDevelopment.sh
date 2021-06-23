#!/bin/bash
# Create a Merge Request for Development
# alias = ghNMRD

if [ "$#" -gt 0 ]; then
  printf "\nUsage: ghNMRD\n"
  printf "    no arguments accepted\n"
  printf "    upstream_branch = \'development\' = ${DEVELOPMENT_BRANCH}\n\n"
  exit 1
fi

$GITHELP_HOME/ghNewPullRequest.sh ${DEVELOPMENT_BRANCH}
