#!/bin/bash
# Create a Pull Request
# alias = ghNPRD

if [ "$#" -gt 0 ]; then
  printf "\nUsage: ghNPRD\n"
  printf "    no arguments accepted\n"
  printf "    upstream_branch = \'development\' = ${DEVELOPMENT_BRANCH}\n\n"
  exit 1
fi

$GITHELP_HOME/ghNewPullRequest.sh ${DEVELOPMENT_BRANCH}
