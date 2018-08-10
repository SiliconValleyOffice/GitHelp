#!/bin/bash
# Prune Local Branches Not On Origin
# alias = ghPLBNOO

#  git fetch -p  ??????

cd $GIT_ROOT
IFS=" "

git remote update origin --prune &> /dev/null
REMOTE_LIST=`$GITHELP_HOME/ghListOriginBranches.sh | tr '\r\n' ' '`
DELETE_LIST="$(git branch | sed 's/\*/ /' | sed 's/ //g' | sed '/^development$/d' | tr '\r\n' ' ')"

for REMOTE in $REMOTE_LIST; do
   DELETE_LIST="$(eval echo $DELETE_LIST | sed "s#$REMOTE##")"
done

if [[ -z $DELETE_LIST ]]
then
    printf "\nNo local branches to delete.\n\n"
    exit 1
fi

BRANCH_ARRAY=($DELETE_LIST)
printf "\nLocal branches to be deleted:\n"
for BRANCH in "${BRANCH_ARRAY[@]}"; do
    printf "    ${BRANCH}\n"
done

printf "\nDELETE local branches which are not on origin:\n"
printf "    WARNING:  NO RECOVERY !!!\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh

for BRANCH in "${BRANCH_ARRAY[@]}"; do
    git branch -D ${BRANCH}
done

printf "\nLocal branch state:\n"
git branch
printf "\n"
