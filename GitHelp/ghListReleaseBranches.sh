#!/bin/bash
# list upstream release branches
# alias = ghLRB

git remote show upstream | cut -d " " -f 5 | grep "release/"
