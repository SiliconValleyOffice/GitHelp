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

# Default MR URL targets upstream main branch
MR_URL="${ORIGIN_PROJECT_WITH_HTTP}/merge_requests/new?merge_request%5Bsource_branch%5D=${CURRENT_BRANCH}"

# Change Target URL defaults to target upstream main branch, but prompts for project and branch selection
MR_URL_CHANGE_TARGET="${ORIGIN_PROJECT_WITH_HTTP}/merge_requests/new?change_branches=true&merge_request%5Bsource_branch%5D=${CURRENT_BRANCH}"

if [ "$#" -eq 2 ]; then
    TARGET_PROJECT_OWNER=$2

    DEV_LIST=$GIT_ROOT/.gitHelp/forkDevelopers.ini
    $GITHELP_HOME/ghProjectConfigExists.sh $DEV_LIST
    DEV_LIST_EXISTS=$?

    # Verify fork developer configuration lists owner of target fork with ID
    # Note: Warnings during validation are printed to standard error to prevent interferance
    # with the MR URL being returned to the calling script.
    if [[ $DEV_LIST_EXISTS -eq 0 && `grep $TARGET_PROJECT_OWNER "$DEV_LIST" | wc -w` -eq 2 ]]; then
        
        # Verify project ID is numerical
        TARGET_PROJECT_ID=`grep $TARGET_PROJECT_OWNER "$DEV_LIST" | cut -d ' ' -f2`
        if [[ $TARGET_PROJECT_ID =~ ^[0-9]+$ ]]; then
            MR_URL="${ORIGIN_PROJECT_WITH_HTTP}/merge_requests/new?merge_request%5Bsource_branch%5D=${CURRENT_BRANCH}&merge_request%5Btarget_branch%5D=${TARGET_BRANCH}&merge_request%5Btarget_project_id%5D=$TARGET_PROJECT_ID"
        else
            printf "\nProject ID listed for $TARGET_PROJECT_OWNER's fork is invalid." >&2
            printf "\nPlease correct project ID for $TARGET_PROJECT_OWNER in '${DEV_LIST}'.\n" >&2
            printf "\nMeanwhile, you must manually select the appropriate target project and branch.\n" >&2
            MR_URL=$MR_URL_CHANGE_TARGET
        fi
    else
        printf "\nFork developer configuration missing." >&2
        printf "\nTo configure, add username and project ID to '${DEV_LIST}'.\n" >&2
        printf "\nMeanwhile, you must manually select the appropriate target project and branch.\n" >&2
        MR_URL=$MR_URL_CHANGE_TARGET
    fi  
fi

echo $MR_URL