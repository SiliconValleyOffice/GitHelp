#!/bin/bash
# Destroy all origin branches except development and master
# alias = ghDAOBED
cd $GIT_ROOT
IFS=" "

git remote update origin --prune &> /dev/null
DELETE_LIST="$($GITHELP_HOME/ghListOriginBranches.sh | sed '/Fetching/d' | sed '/HEAD/d' | sed 's/ //g' | tr '\r\n' ' ')"
LOCAL_LIST="$(git branch | sed 's/\*/ /' | sed 's/ //g' | tr '\r\n' ' ')"

DELETE_LIST="$(eval echo $DELETE_LIST | sed "s/master//")"
DELETE_LIST="$(eval echo $DELETE_LIST | sed "s/${DEVELOPMENT_BRANCH}//")"

for LOCAL in $LOCAL_LIST; do
   DELETE_LIST="$(eval echo $DELETE_LIST | sed "s/$LOCAL//")"
done

if [[ -z $DELETE_LIST ]]
then
    printf "\nNo origin branches to delete.\n\n"
    exit 1
fi

printf "\nDESTROY branches on origin that are not local, except master and development:\n"
printf "    WARNING:  NO RECOVERY !!!\n"

printf "\nOrigin branches to be deleted:\n"
for BRANCH in "${DELETE_LIST}"; do
    printf "    ${BRANCH}\n"
done
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCheckoutOriginDevelopmentBranch.sh

for BRANCH in "${DELETE_LIST}"; do
    git push origin --delete $BRANCH
done

printf "\nOrigin branch state:\n"
$GITHELP_HOME/ghListOriginBranches.sh
printf "\nLocal branch state:\n"
git branch
printf "\n"
