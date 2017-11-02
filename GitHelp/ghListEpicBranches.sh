#!/bin/bash
# list upstream epic branches
# alias = ghLEB

git remote show upstream | cut -d " " -f 5 | grep "epic/"
