#!/bin/bash
# Create a GitHub Merge Request URL

if [ "$#" -ne 1 ]; then
printf "\nUsage: ghGitLabMergeRequestUrl upstream_branch\n\n"
exit 1
fi

UPSTREAM_BRANCH=$1
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
UPSTREAM_PROJECT=`git config --get remote.upstream.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//'`
ORIGIN_PROJECT=`git config --get remote.origin.url | awk -F/ '{print $4 "/" $5}' | sed s/\.git//`

echo "$UPSTREAM_PROJECT/compare/${UPSTREAM_BRANCH}...$ORIGIN_PROJECT?expand=1"

