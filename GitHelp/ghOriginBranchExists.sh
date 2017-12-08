#!/bin/bash

cd "$GIT_ROOT"

if [ "$#" -lt 1 ]; then
  exit 1
fi

git remote update origin --prune &> /dev/null
RESULTS=`$GITHELP_HOME/ghListOriginBranches.sh`

for ROW in $RESULTS; do
  if [[ "$ROW" = "${1}" ]] ; then
      exit 0;
  fi
done
exit 1
