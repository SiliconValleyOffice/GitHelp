#!/bin/bash
# Prune Local Branches Except Development
# alias = ghPLB

#  git fetch -p  ??????

cd $GIT_ROOT
IFS=" "

git remote update origin --prune &> /dev/null
DELETE_LIST="$(git branch | sed 's/\*/ /' | sed 's/ //g' | sed '/'"$DEVELOPMENT_BRANCH"'/d' | tr '\r\n' ' ')"

if [[ -z $DELETE_LIST ]]
then
    printf "\nNo local branches to delete.\n\n"
    exit 1
fi

BRANCH_ARRAY=($DELETE_LIST)
printf "\nBranches to be deleted locally and on origin:\n"
for BRANCH in "${BRANCH_ARRAY[@]}"; do
    printf "    ${BRANCH}\n"
done

printf "\n    WARNING:  NO RECOVERY !!!\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh

for BRANCH in "${BRANCH_ARRAY[@]}"; do
    $GITHELP_HOME/ghDestroyMiscBranch.sh ${BRANCH}
done
