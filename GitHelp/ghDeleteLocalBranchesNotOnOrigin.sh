#!/bin/bash
# remove tracking branches that no longer exist on Origin
# alias = ghDLBNOO

#  git fetch -p  ??????

cd $GIT_ROOT

git remote update origin --prune &> /dev/null
REMOTE_LIST="$($GITHELP_HOME/ghListOriginBranches.sh | sed '/Fetching/d' | sed '/HEAD/d' | sed 's/ //g')"
DELETE_LIST="$(git branch | sed 's/\*/ /' | sed 's/ //g')"

for REMOTE in $REMOTE_LIST; do
   DELETE_LIST="$(eval echo $DELETE_LIST | sed "s/$REMOTE//")"
done

if [[ -z $DELETE_LIST ]]
then
    printf "\nNo local branches to delete.\n\n"
    exit 1
fi

IFS=" "
BRANCH_ARRAY=($DELETE_LIST)
printf "\nOrigin branches to be deleted:\n"
for BRANCH in "${BRANCH_ARRAY[@]}"; do
    printf "    ${BRANCH}\n"
done

printf "\nDELETE local branches which are not on origin:\n"
printf "    WARNING:  NO RECOVERY\n    The following local branches will be deleted.\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh

for BRANCH in "${BRANCH_ARRAY[@]}"; do
    git branch -d ${BRANCH}
done

printf "\nLocal branch state:\n"
git branch
printf "\n"
