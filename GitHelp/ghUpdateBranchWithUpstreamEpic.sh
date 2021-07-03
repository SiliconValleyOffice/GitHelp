#!/bin/bash
# update current branch with upstream/epic/ABCD-1234
# alias = ghUBUE

if [ ! $# -eq 1 ]; then
    printf "\nUsage: ghUBUE epic_id\n"
    printf "  Update current Branch with Upstream Epic branch.\n\n"
    exit
fi

UPSTREAM_BRANCH=`$GITHELP_HOME/ghParseEpicBranch.sh $1`
if [ $? -ne 0 ] ; then
    printf "\n    ERROR: Argument is not a valid epic ID.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghUpdateBranchWithUpstreamBranch.sh $UPSTREAM_BRANCH
