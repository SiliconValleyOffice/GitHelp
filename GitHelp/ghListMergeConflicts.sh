#!/bin/bash
# list files with merge conflicts
# alias = ghLMC

CONFLICT_LIST=`git diff --name-only --diff-filter=U`
if [[ -z "$CONFLICT_LIST" ]]; then
    printf "\nNo merge conflicts.\n\n"
else
    CONFLICT_COUNT=`git diff --name-only --diff-filter=U | wc -l`
    printf "\n$CONFLICT_COUNT merge conflicts:\n"
    printf "$CONFLICT_LIST\n"
fi
