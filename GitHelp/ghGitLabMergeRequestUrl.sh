#!/bin/bash
# Create a GitLab Merge Request URL

if [ "$#" -ne 1 ]; then
printf "\nUsage: ghGitLabMergeRequestUrl upstream_branch\n\n"
exit 1
fi

UPSTREAM_BRANCH=$1
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
ORIGIN_PROJECT_WITH_HTTP=`git config --get remote.origin.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//'`
ORIGIN_PROJECT=`git config --get remote.origin.url | awk -F/ '{print $4 "/" $5}' | sed 's/\.git//'`
UPSTREAM_PROJECT=`git config --get remote.upstream.url | awk -F/ '{print $4 "/" $5}' | sed 's/\.git//'`

echo "${ORIGIN_PROJECT_WITH_HTTP}/merge_requests/new?merge_request%5Bsource_branch%5D=${CURRENT_BRANCH}&merge_request%5Bsource_project_id%5D=${ORIGIN_PROJECT}&merge_request%5Btarget_branch%5D=${UPSTREAM_BRANCH}&merge_request%5Btarget_project_id%5D=$UPSTREAM_PROJECT"
