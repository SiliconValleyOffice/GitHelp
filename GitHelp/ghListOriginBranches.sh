#!/bin/bash
# list all origin branches
# alias = ghLOB

git remote update origin --prune &> /dev/null
git branch -r | sed '/deleted/d' | sed '/HEAD/d' | sed '/origin/!d' | sed 's/origin\///' | sed 's/ //g'
