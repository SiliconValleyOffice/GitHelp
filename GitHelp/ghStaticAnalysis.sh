#!/bin/bash
# Static Analysis
# alias = ghSA

./gradlew tasks 2> /dev/null | grep detekt &> /dev/null
RUN_DETEKT=$?

./gradlew tasks 2> /dev/null | grep lintDebug &> /dev/null
RUN_LINT_DEBUG=$?

if [ "$RUN_DETEKT" -eq 0 -a "$RUN_LINT_DEBUG" -eq 0 ] ; then
# if [ "$RUN_DETEKT" -eq 0 ] ; then
    printf "\nStatic analysis...\n"
    ./gradlew detekt lintDebug
    STATIC_RESULTS=$?
else
    printf "\nStatic analysis not enabled.\n\n"
    STATIC_RESULTS=0
fi

exit $STATIC_RESULTS
