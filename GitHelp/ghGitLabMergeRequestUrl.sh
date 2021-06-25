#!/bin/bash
# Create a GitLab Merge Request URL

if [ "$#" -lt 1 ]; then
    printf "\nUsage: ghGitLabMergeRequestUrl target_branch [target_project_owner]\n\n"
    printf "    target_project_owner = Fork project owner or defaults to upstream as project owner "
    exit 1
fi

TARGET_BRANCH=$1
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
ORIGIN_PROJECT_WITH_HTTP=`git config --get remote.origin.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//'`
ORIGIN_PROJECT=`git config --get remote.origin.url | awk -F/ '{print $4 "/" $5}' | sed 's/\.git//'`

if [ "$#" -eq 2 ]; then
    TARGET_PROJECT_OWNER=$2
else
    TARGET_PROJECT_OWNER=upstream
fi

TARGET_PROJECT=`git config --get remote.$TARGET_PROJECT_OWNER.url | awk -F/ '{print $4 "/" $5}' | sed 's/\.git//'`

echo "${ORIGIN_PROJECT_WITH_HTTP}/merge_requests/new?merge_request%5Bsource_branch%5D=${CURRENT_BRANCH}&merge_request%5Bsource_project_id%5D=${ORIGIN_PROJECT}&merge_request%5Btarget_branch%5D=${TARGET_BRANCH}&merge_request%5Btarget_project_id%5D=$TARGET_PROJECT"
