#!/bin/bash

cd "$GIT_ROOT"

if [ "$#" -lt 1 ]; then
  exit 1
fi

RESULTS=`$GITHELP_HOME/ghListOriginBranches.sh`

for ROW in $RESULTS; do
  if [[ "$ROW" = "${1}" ]] ; then
      exit 0;
  fi
done
exit 1
