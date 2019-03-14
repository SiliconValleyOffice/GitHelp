#!/bin/bash
# fetch fork branch
# alias = ghFFMB

if [[ $# -lt 2 || $# -gt 3 ]]; then
    printf "\nUsage: ghFFMB github_user_name branch_name [local_branch_prefix]\n"
    printf "    github_user_id = owner of the Fork\n"
    printf "    default local_branch_prefix = \"DF\"\n"
    printf "    Fetch Fork Misc Branch\n\n"
    exit 1
fi

DEVELOPER_LOGIN_ID=$1
BRANCH_NAME=$2
if [ $# -eq 3 ]; then
    LOCAL_BRANCH_PREFIX=$3
else
    LOCAL_BRANCH_PREFIX="DF"
fi
LOCAL_DF_BRANCH="${LOCAL_BRANCH_PREFIX}-$DEVELOPER_LOGIN_ID/$BRANCH_NAME"

GITHUB_USER_TO_LOWER=`echo $GITHUB_USER | tr '[:upper:]' '[:lower:]'`

DEV_FORK=`git config --get remote.origin.url | tr '[:upper:]' '[:lower:]' | sed "s/$GITHUB_USER_TO_LOWER/$DEVELOPER_LOGIN_ID/"`

if [[ `git branch` == *"${LOCAL_DF_BRANCH}"* ]] ; then
    printf "\nFatal Error:  The branch named \"${BRANCH_NAME}\" already exists locally.\n"
    printf "Operation Canceled.\n\n"
    exit 1
fi

git ls-remote --exit-code $DEV_FORK &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  A fork does not exist for developer login id \"$DEVELOPER_LOGIN_ID\".\n\n"
    exit 1
fi

if [[ `git remote` != *"$DEVELOPER_LOGIN_ID"* ]] ; then
    printf "\nCreating a remote for \"$DEVELOPER_LOGIN_ID\"\n"
    git remote add $DEVELOPER_LOGIN_ID $DEV_FORK
fi

$GITHELP_HOME/ghForkBranchExists.sh ${DEVELOPER_LOGIN_ID} ${BRANCH_NAME}
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${BRANCH_NAME}\" does not exist on the fork owned by \"${DEVELOPER_LOGIN_ID}\".\n\n"
    exit 1;
fi

printf "\nCreate a new Origin tracking branch\n"
printf "    from \"${DEVELOPER_LOGIN_ID}/${BRANCH_NAME}\"\n"
printf "    named \"$LOCAL_DF_BRANCH\"\n\n"
printf "    You will be working in the new branch after creation.\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh

CHECKOUT="$LOCAL_DF_BRANCH $DEVELOPER_LOGIN_ID/$BRANCH_NAME" &> /dev/null

git fetch $DEVELOPER_LOGIN_ID &> /dev/null
git remote prune $DEVELOPER_LOGIN_ID &> /dev/null
RESULTS=`git checkout ${DEVELOPER_LOGIN_ID}/${BRANCH_NAME}`
if [ $? -ne 0 ] ; then
    printf "\n$RESULTS\n\n"
    exit 1
fi

git checkout -b ${LOCAL_DF_BRANCH}
git fetch origin &> /dev/null
git remote prune origin &> /dev/null
git push origin $LOCAL_DF_BRANCH &> /dev/null

git config --unset "branch.${LOCAL_DF_BRANCH}.remote"
git config --unset "branch.${LOCAL_DF_BRANCH}.merge"

echo
git branch -u "origin/$LOCAL_DF_BRANCH"

printf "\nLocal branch state:\n"
git branch
printf "\n"
