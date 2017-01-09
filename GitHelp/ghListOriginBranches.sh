#!/bin/bash
# list all origin branches
# alias = ghLOB

if [ "$1" == "-s" ]; then
    git remote update origin --prune &> /dev/null
else
    git remote update origin --prune
fi

git branch -r | sed '/deleted/d' | sed '/HEAD/d' | sed '/origin/!d' | sed 's/origin\///'
# git branch -r | sed '/deleted/d' | sed '/upstream/d' | sed 's/origin\///'
# git branch -r | sed '/deleted/d' | sed '/upstream/d' | sed 's/origin\///' | sed '/\//d'
