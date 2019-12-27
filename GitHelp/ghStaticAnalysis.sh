#!/bin/bash
# Static Analysis
# alias = ghSA

STATIC_RESULTS=0
cd $GIT_ROOT

./gradlew tasks 2> /dev/null | grep detekt &> /dev/null
RUN_DETEKT=$?

./gradlew tasks 2> /dev/null | grep lintDebug &> /dev/null
RUN_LINT_DEBUG=$?

./gradlew tasks 2> /dev/null | grep jacocoTestReport &> /dev/null
RUN_JACOCO=$?

#if [ "$RUN_DETEKT" -eq 0 -a "$RUN_LINT_DEBUG" -eq 0 ] ; then
if [ "$RUN_DETEKT" -eq 0 ] ; then
    printf "\nStatic analysis - detekt\n"
    ./gradlew detekt
    DETEKT_RESULTS=$?
else
    printf "\nDetekt not enabled.\n\n"
    DETEKT_RESULTS=0
fi

if [ "$RUN_LINT_DEBUG" -eq 0 ] ; then
    printf "\nStatic analysis - lintDebug\n"
    ./gradlew lintDebug
    LINT_DEBUG_RESULTS=$?
else
    printf "\nlintDebug not enabled.\n\n"
    LINT_DEBUG_RESULTS=0
fi

if [ "$RUN_JACOCO" -eq 0 ] ; then
    printf "\nStatic analysis - jacocoTestReport\n"
    ./gradlew jacocoTestReport -Pkotlin.compiler.allWarningsAsErrors=true
    JACOCO_RESULTS=$?
else
    printf "\njacocoTestReport not enabled.\n\n"
    JACOCO_RESULTS=0
fi

STATIC_RESULTS=$((DETEKT_RESULTS+LINT_DEBUG_RESULTS+JACOCO_RESULTS))
exit $STATIC_RESULTS
