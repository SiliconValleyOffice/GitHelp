#!/bin/bash
# list all upstream branches
# alias = ghLUB

git remote update upstream --prune > /dev/null 2>&1
git remote show upstream | sed -n '/Local ref configured/q;p' | tail -n +6 | sed -n 's/ tracked//p' | sed -n 's/ //g;p'
