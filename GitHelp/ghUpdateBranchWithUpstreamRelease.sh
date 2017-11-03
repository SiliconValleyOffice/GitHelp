#!/bin/bash
# update current branch with upstream/release/x.x branch
# alias = ghUBUR

if [ ! $# -eq 1 ]; then
  printf "\nUsage: giUBUR upstream_release_branch_number\n"
  printf "  Update current branch with upstream Release branch.\n\n"
  exit
fi

UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseReleaseBranch.sh $1`
if [ $? -ne 0 ] ; then
  exit 1;
fi

$GITHELP_HOME/ghUpdateBranchWithUpstreamBranch.sh $UPSTREAM_BRANCH
