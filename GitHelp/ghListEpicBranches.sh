#!/bin/bash
# list upstream epic branches
# alias = ghLEB

git remote update upstream --prune &> /dev/null

git branch -r | grep 'epic/' | sed 's/  upstream\///'
