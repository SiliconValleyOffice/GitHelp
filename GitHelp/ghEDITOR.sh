#!/bin/bash
# Default editor configuration for git
# alias = ghEDITOR

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

CURRENT_EDITOR=`git config core.editor`
printf "\nCurrent git text editor = $CURRENT_EDITOR\n\n"

if [ $# -ne 1 ] ; then
  exit
fi

# configure a new editor

if [ $CURRENT_EDITOR = $1 ] ; then
  printf "Editor configuration NOT changed.\n"
  printf "\"$1\" is already your git text editor.\n\n"
  exit 0
fi

which $1 &> /dev/null
if [ $? -ne 0 ] ; then
    printf "Editor configuration NOT changed.\n"
    printf "Cannot find executable for \"$1\"\n\n"
    exit 1
fi

git config --global core.editor $1
printf "Editor configuration changed to \"$1\".\n\n"
