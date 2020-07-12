#!/bin/bash
# Checkout development branch

$GITHELP_HOME/ghOriginBranchExists.sh ${DEVELOPMENT_BRANCH}
if [ $? -ne 0 ]; then
    # create branch
    if [[ `git branch` != *"${DEVELOPMENT_BRANCH}"* ]] ; then
        git fetch upstream &> /dev/null
        git checkout upstream/${DEVELOPMENT_BRANCH} &> /dev/null
        git checkout -b ${DEVELOPMENT_BRANCH}
    fi
    git push origin ${DEVELOPMENT_BRANCH} &> /dev/null
fi

git checkout ${DEVELOPMENT_BRANCH} &>/dev/null
RESULT=$?

$GITHELP_HOME/ghCleanUntrackedFiles.sh

exit $RESULT
