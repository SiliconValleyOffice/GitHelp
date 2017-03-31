#!/bin/bash
# Copy local GitHelp directory to local repo
# gitCGR

REPO_NAME="GitHelp"
REPO_ROOT="${HOME}/REPO"
GITHELP_ROOT="${REPO_ROOT}/${REPO_NAME}"

if [ ! -d $GITHELP_ROOT ]; then
    printf "\n$GITHELP_ROOT does not exist.\nOperation canceled.\n\n"
    exit 1
fi

cp -rf $HOME/GitHelp $GITHELP_ROOT
