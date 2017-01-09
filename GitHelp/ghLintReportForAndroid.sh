#!/bin/bash
# Generate and View a Lint Report for Android
# alias = ghLRA

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghLRA project_name module_name\n"
  printf "    generate and view a Lint Report for the Android project/module\n\n"
  exit
fi

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

PWD=`pwd`
PROJECT=$1
MODULE=$2

PROJECT_DIRECTORY="${PWD}/${PROJECT}"
if [ ! -d "$PROJECT_DIRECTORY" ]; then
    printf "\nFATAL ERROR:  Project named \"$PROJECT\" does not exist.\n\n"
    pwd
    exit 1;
fi
cd $PROJECT_DIRECTORY

if [ ! -d "$MODULE" ]; then
    printf "\nFATAL ERROR:  Module named \"$MODULE\" does not exist.\n\n"
    exit 1;
fi

RESULTS=`./gradlew :${MODULE}:lintRelease`

LINT_REPORT_URL="file:///${PWD}/${MODULE}/build/outputs/lint-results-release.html"
if which google-chrome > /dev/null
then
  google-chrome -url "$LINT_REPORT_URL"
else
  open "$LINT_REPORT_URL"
fi

printf "\nA new Lint Report is displayed in your browser.\n\n"
