#!/bin/bash
# Checkout development branch

$GITHELP_HOME/ghOriginBranchExists.sh development
if [ $? -ne 0 ]; then
    # create branch
    if [[ `git branch` != *"development"* ]] ; then
        git fetch upstream &> /dev/null
        git checkout upstream/development &> /dev/null
        git checkout -b development
    fi
    git push origin development &> /dev/null
fi

git checkout development &>/dev/null
RESULT=$?

$GITHELP_HOME/ghCleanUntrackedFiles.sh

exit $RESULT
