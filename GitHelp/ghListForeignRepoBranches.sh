#!/bin/bash
# List Foreign Repo Branches
# alias = ghLFRB

if [ $# -ne 1 ]; then
    printf "\nUsage: ghLFRB foreign_repo_url\n"
    printf "    List Foreign Repo Branches\n"
    printf "    foreign_repo_url example = https://code.mycompany.com/owner/myapp\n\n"
    exit
fi

FOREIGN_REPOSITORY=$1
git ls-remote --exit-code $FOREIGN_REPOSITORY &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:\n    Either a fork does not exist for \"$FOREIGN_REPOSITORY\",\n"
    printf "    or you have not been granted permissions.\n\n"
    exit 1
fi

git ls-remote --exit-code $FOREIGN_REPOSITORY | sed '/deleted/d' | sed '/refs\/heads/!d' | sed 's/.*heads\///' | sed 's/./    &/'

printf "\n"
