#!/bin/bash
# Browse Upstream Development branch
# alias = ghBUD

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

$GITHELP_HOME/ghVerifyCleanBranch.sh
if [ $? -ne 0 ] ; then
    exit 1;
fi

git fetch upstream &>/dev/null
git checkout development &>/dev/null
git reset --hard upstream/development &>/dev/null
git push origin development --force

echo
git branch
