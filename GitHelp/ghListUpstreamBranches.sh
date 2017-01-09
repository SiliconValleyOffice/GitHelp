#!/bin/bash
# list all upstream branches
# alias = ghLUB

git remote update upstream --prune &> /dev/null

git branch -r | sed '/deleted/d' | sed '/origin/d' | sed 's/upstream\///'
