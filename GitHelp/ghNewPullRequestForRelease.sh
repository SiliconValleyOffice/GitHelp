#!/bin/bash
# New Pull Request for a Release branch
# alias = ghNPRR

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNPRR upstream_release_branch_number\n"
  printf "    Create a Pull Request for the current branch\n"
  printf "    against an upstream Release branch.\n\n"
  exit
fi

RELEASE=$1

UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseReleaseBranch.sh ${RELEASE}`
if [[ $? -ne 0 ]] ; then
    printf "\nError:  Not a Release branch.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghNewPullRequest.sh "$UPSTREAM_BRANCH"
