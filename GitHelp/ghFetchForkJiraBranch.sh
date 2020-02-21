#!/bin/bash
# Fetch Fork JIRA Branch
# alias = ghFFJB

if [ $# -ne 2 ]; then
    printf "\nUsage: ghFFJB git_user_name JIRA_number\n"
    printf "    git_user_id = owner of the Fork\n"
    printf "    Fetch Fork JIRA Branch\n\n"
    exit 1
fi

REGULAR_EXPRESSION='^[0-9]+$'
if ! [[ $2 =~ $REGULAR_EXPRESSION ]] ; then
    printf "\n    ERROR: Second argument is not a JIRA number.\n\n"
    exit 1
fi

DEVELOPER_LOGIN_ID=$1
JIRA_BRANCH="${JIRA_TICKET_PREFIX}-${2}"
LOCAL_DF_BRANCH="DF-$DEVELOPER_LOGIN_ID/$BRANCH_NAME"
CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $LOCAL_DF_BRANCH = $CURRENT_BRANCH ]]; then
    printf "WARNING:  Already on the branch named \"${JIRA_BRANCH}\".\n\n"
    git branch
    exit 1;
fi


$GITHELP_HOME/ghFetchForkMiscBranch.sh $1 $JIRA_BRANCH
