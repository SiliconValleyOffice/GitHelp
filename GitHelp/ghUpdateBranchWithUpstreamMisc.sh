#!/bin/bash
# update current branch with upstream/misc branch
# alias = ghUBUM


if [ $# -eq 1 ]; then
    UPSTREAM_BRANCH="$1"
else
    UPSTREAM_BRANCH="master"
fi

$GITHELP_HOME/ghUpdateBranchWithUpstreamBranch.sh $UPSTREAM_BRANCH
