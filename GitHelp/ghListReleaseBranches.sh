#!/bin/bash
# list upstream release branches
# alias = ghLRB

git remote update upstream --prune &> /dev/null

git branch -r | grep 'release/' | sed 's/  upstream\///'
