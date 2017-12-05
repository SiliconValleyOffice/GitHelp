#!/bin/bash
# Verify Clean Branch

CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
RESULTS=`git status`
if [[ "$RESULTS"  != *"working directory clean"* ]] && [[ "$RESULTS"  != *"working tree clean"* ]] ; then
    printf "\nERROR:  \"${CURRENT_BRANCH}\" branch is not clean.\n"
    printf "    Commit/push your changes and try again.\n\n"
    exit 1;
fi
if [[ "$RESULTS" = *"Your branch is ahead"* ]] ; then
    printf "\nERROR:  You forgot to push your changes in branch \"${CURRENT_BRANCH}\".\n"
    printf "    Run \"git push\" and try again.\n\n"
    exit 1;
fi
