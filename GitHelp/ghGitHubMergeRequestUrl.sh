#!/bin/bash
# Create a GitHub Merge Request URL

if [ "$#" -lt 1 ]; then
    printf "\nUsage: ghGitHubMergeRequestUrl target_branch [target_project_owner]\n\n"
    printf "    target_project_owner = Fork project owner or defaults to upstream as project owner "
    exit 1
fi

TARGET_BRANCH=$1
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
CURRENT_USER=`git config --get remote.origin.url| sed 's/\/\//\//2' | awk -F/ '{print $4}' | sed s/\.git//`

if [ "$#" -eq 2 ]; then
    TARGET_PROJECT_OWNER=$2
else
    TARGET_PROJECT_OWNER=upstream
fi

TARGET_PROJECT=`git config --get remote.$TARGET_PROJECT_OWNER.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//'`

echo "$TARGET_PROJECT/compare/${TARGET_BRANCH}...$CURRENT_USER:$CURRENT_BRANCH?expand=1"

