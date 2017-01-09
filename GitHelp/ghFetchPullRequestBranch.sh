#!/bin/bash
# Fetch Pull Request Branch
# alias = ghFPRB

if [ $# -ne 1 ]; then
    printf "\nUsage: ghFPRB pull_request_from_string\n"
    printf "    Fetch Pull Request Branch\n\n"
    exit 1
fi

PULL_REQUEST_STRING=$1
SEPARATOR_COUNT=`echo "$PULL_REQUEST_STRING" | awk -F\: '{print NF-1}'`
if [[ "$SEPARATOR_COUNT" != 1 ]]; then
    printf "\n    ERROR: Argument is not a Pull Request \"from\" string.\n\n"
    exit 1
fi

DEVELOPER_LOGIN_ID=`echo $PULL_REQUEST_STRING | cut -d':' -f 1`
BRANCH_NAME=`echo $PULL_REQUEST_STRING | cut -d':' -f 2`
LOCAL_PR_BRANCH="PR-$DEVELOPER_LOGIN_ID/$BRANCH_NAME"

CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $LOCAL_PR_BRANCH = $CURRENT_BRANCH ]]; then
    printf "WARNING:  Already on the branch named \"${LOCAL_PR_BRANCH}\".\n\n"
    git branch
    exit 1;
fi

$GITHELP_HOME/ghFetchForkMiscBranch.sh $DEVELOPER_LOGIN_ID $BRANCH_NAME "PR"
