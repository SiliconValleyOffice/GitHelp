#!/bin/bash
# New Pull Request for a Epic branch
# alias = ghNPRE

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNPRR epic_id\n"
  printf "    Create a Pull Request for the current branch\n"
  printf "    against an upstream Epic branch.\n\n"
  exit
fi

EPIC_ID=$1

UPSTREAM_BRANCH="$GITHELP_HOME/ghParseEpicBranch.sh ${EPIC_ID}"
if [[ $? -ne 0 ]] ; then
    printf "\nError:  Not an Epic branch.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewPullRequest.sh "$UPSTREAM_BRANCH"
