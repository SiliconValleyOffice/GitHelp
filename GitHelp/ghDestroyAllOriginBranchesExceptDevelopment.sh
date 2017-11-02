#!/bin/bash
# Destroy all origin branches except development
# alias = ghDAOBED

cd $GIT_ROOT

git remote update origin --prune &> /dev/null
ORIGIN_DELETE_LIST="$($GITHELP_HOME/ghListOriginBranches.sh | sed '/Fetching/d' | sed '/HEAD/d' | sed 's/ //g')"

ORIGIN_DELETE_LIST="$(eval echo $ORIGIN_DELETE_LIST | sed "s/development//")"

echo $ORIGIN_DELETE_LIST

if [[ -z $ORIGIN_DELETE_LIST ]]
then
    printf "\nNo origin branches to delete.\n\n"
    exit 1
fi

IFS=" "
BRANCH_ARRAY=($DELETE_LIST)
printf "\nOrigin branches to be deleted:\n"
for BRANCH in "${BRANCH_ARRAY[@]}"; do
    printf "    ${BRANCH}\n"
done

printf "\nDESTROY all branches on origin, except development:\n"
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh

for BRANCH in "${BRANCH_ARRAY[@]}"; do
    git push origin --delete $BRANCH
    git branch -D $BRANCH
done

printf "\nOrigin branch state:\n"
$GITHELP_HOME/ghListOriginBranches.sh
printf "\nLocal branch state:\n"
git branch
printf "\n"
