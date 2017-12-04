#!/bin/bash

if [ "$#" -lt 2 ]; then
  exit 1
fi
FOREIGN_REPOSITORY=$1
BRANCH=$2

RESULTS=`$GITHELP_HOME/ghListForeignRepoBranches.sh $FOREIGN_REPOSITORY`

if [[ "$RESULTS"  != *"$BRANCH"* ]] ; then
    exit 1;
fi
