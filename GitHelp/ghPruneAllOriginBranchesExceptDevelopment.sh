#!/bin/bash
# Prune all origin branches except development and master
# alias = ghPAOBED

cd $GIT_ROOT
IFS=" "

git remote update origin --prune &> /dev/null
TEMP_DELETE_LIST="$($GITHELP_HOME/ghListOriginBranches.sh | sed '/Fetching/d' | sed '/HEAD/d' | sed 's/ //g' | tr '\r\n' ' ')"
ORIGIN_DELETE_LIST=`echo "$TEMP_DELETE_LIST" | sed "s/${DEVELOPMENT_BRANCH}//"`

if [[ -z $ORIGIN_DELETE_LIST ]]
then
    printf "\nNo origin branches to delete.\n\n"
    exit 1
fi

printf "\nOrigin branches to be deleted:\n"
for BRANCH in $ORIGIN_DELETE_LIST; do
    printf "> ${BRANCH}\n"
done

printf "\nDESTROY all branches on origin, except development:\n"
printf "    WARNING:  NO RECOVERY !!!\n"
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
    git checkout ${DEVELOPMENT_BRANCH}
    printf "\nOperation canceled.\n\n"
    exit 1
fi

for BRANCH in $ORIGIN_DELETE_LIST; do
    git push origin --delete $BRANCH
done

printf "\nOrigin branch state:\n"
$GITHELP_HOME/ghListOriginBranches.sh
printf "\nLocal branch state:\n"
git branch
printf "\n"
