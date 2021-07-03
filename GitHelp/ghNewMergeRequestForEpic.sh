#!/bin/bash
# New Merge Request for a Epic branch
# alias = ghNMRE

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNMRE epid_id\n"
  printf "    Create a Merge Request for the current branch\n"
  printf "    against an upstream Epic branch.\n\n"
  exit
fi

EPIC=$1

UPSTREAM_BRANCH="$GITHELP_HOME/ghParseEpicBranch.sh ${EPIC}"
if [[ $? -ne 0 ]] ; then
    printf "\nError:  Not an Epic branch.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewPullRequest.sh "$UPSTREAM_BRANCH"
