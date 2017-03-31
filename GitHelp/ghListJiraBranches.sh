#!/bin/bash
# list iOS release branches
# alias = ghLIRB

git remote update origin --prune &> /dev/null

git branch -r | grep 'Release_' | sed 's/  upstream\///'
