#!/bin/bash
# Destroy current branch from the Origin, and locally
# alias = ghDOB

CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`

$GITHELP_HOME/ghDestroyMiscBranch.sh $CURRENT_BRANCH
