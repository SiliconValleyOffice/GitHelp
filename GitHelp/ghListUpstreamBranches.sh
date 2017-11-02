#!/bin/bash
# list all upstream branches
# alias = ghLUB

git remote show upstream | cut -d " " -f 5
