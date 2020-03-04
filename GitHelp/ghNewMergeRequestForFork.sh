#!/bin/bash
# New Merge Request for a Fork branch
# alias = ghNMRF

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNMRF git_user_name branch_name\n"
  printf "    git_user_id = owner of the Fork\n\n"
  printf "    New Pull Request for the current branch\n"
  printf "    against a branch in another Fork.\n\n"
  exit
fi

FORK_OWNER=$1
FORK_BRANCH=$2

$GITHELP_HOME/ghNewPullRequestForFork.sh $FORK_OWNER $FORK_BRANCH