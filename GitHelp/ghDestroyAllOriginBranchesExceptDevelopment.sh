#!/bin/bash
# Destroy all origin branches except development and master
# alias = ghDAOBED

cd $GIT_ROOT

git remote update origin --prune &> /dev/null
REMOTE_LIST="$($GITHELP_HOME/ghListOriginBranches.sh | sed '/Fetching/d' | sed '/HEAD/d' | sed 's/ //g')"
DELETE_LIST="$(git branch | sed 's/\*/ /' | sed 's/ //g')"

DELETE_LIST="$(eval echo $DELETE_LIST | sed "s/master//")"
DELETE_LIST="$(eval echo $DELETE_LIST | sed "s/development//")"

if [[ -z $DELETE_LIST ]]
then
    printf "\nNo origin branches to delete.\n\n"
    exit 1
fi

printf "\nDESTROY all branches on origin, except master and development:\n"
printf "    WARNING:  NO RECOVERY\n    The following local branches will be deleted.\n"
for BRANCH in "$DELETE_LIST"; do
    printf "        ${BRANCH}\n"
done
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
    git checkout development
    printf "\nOperation canceled.\n\n"
    exit 1
fi

for BRANCH in "$DELETE_LIST"; do
    git push origin --delete $BRANCH
    git branch -D $BRANCH
done

printf "\nOrigin branch state:\n"
$GITHELP_HOME/ghListOriginBranches.sh
printf "\nLocal branch state:\n"
git branch
printf "\n"
