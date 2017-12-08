#!/bin/bash

cd "$GIT_ROOT"

if [ "$#" -lt 1 ]; then
  exit 1
fi

git remote update upstream --prune &> /dev/null
RESULTS=`$GITHELP_HOME/ghListUpstreamBranches.sh`

if [[ "$RESULTS"  != *"$1"* ]] ; then
    exit 1;
fi
