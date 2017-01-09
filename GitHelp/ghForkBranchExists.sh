#!/bin/bash

cd "$GIT_ROOT"

if [ "$#" -ne 2 ]; then
  exit 1
fi

RESULTS=`$GITHELP_HOME/ghListForkBranches.sh ${1}`

if [[ "$RESULTS" != *"${2}"* ]] ; then
    printf "\n$RESULTS\n"
    exit 1;
fi
