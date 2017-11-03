#!/bin/bash
# Create a new LOCAL git branch (no origin tracking branch)

CLONE_STRING=$GIT_HOST_URL + "/flywheelms/GitHelp.git"

UPSTREAM_OWNER=`echo $CLONE_STRING | awk -F '/' '{print $4}'`
REPO_NAME=`echo $CLONE_STRING | awk -F '/' '{print $5}' | cut -f 1 -d'.'`

printf "UPSTREAM_OWNER = $UPSTREAM_OWNER\n"
printf "REPO_NAME = $REPO_NAME\n"
