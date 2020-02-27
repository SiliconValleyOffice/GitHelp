#!/bin/bash
# Create a GitLab Merge Request URL

if [ "$#" -ne 1 ]; then
printf "\nUsage: ghGitLabMergeRequestUrl upstream_branch\n\n"
exit 1
fi

UPSTREAM_BRANCH=$1
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

echo "$(git config --get remote.origin.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//')/merge_requests/new?merge_request%5Bsource_branch%5D=${CURRENT_BRANCH}&merge_request%5Bsource_project_id%5D=$(git config --get remote.origin.url | awk -F/ '{print $4 "/" $5}' | sed s/\.git//
)&merge_request%5Btarget_branch%5D=${UPSTREAM_BRANCH}&merge_request%5Btarget_project_id%5D=$(git config --get remote.upstream.url | awk -F/ '{print $4 "/" $5}' | sed s/\.git//)"
