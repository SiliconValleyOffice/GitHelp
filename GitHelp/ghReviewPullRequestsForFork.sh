#!/bin/bash
# Review Pull Requests for Fork
# alias ghRPRF

if [ $# -ne 1 ]; then
    printf "\nUsage: ghRPRF github_user_name\n"
    printf "    github_user_id = owner of the Fork\n"
    printf "    Review Pull Requests for a Fork\n\n"
    exit 1
fi

DEVELOPER_LOGIN_ID=$1
DEV_FORK=`git config --get remote.origin.url | sed "s/$GITHUB_USER/$DEVELOPER_LOGIN_ID/"`

git ls-remote --exit-code $DEV_FORK &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  A fork does not exist for developer login id \"$DEVELOPER_LOGIN_ID\".\n\n"
    exit 1
fi

UPSTREAM_URL=`echo $DEV_FORK | sed 's/\.git/\/pulls/' `

if which google-chrome > /dev/null
then
    google-chrome "$UPSTREAM_URL"
else
    open "$GITHUB_URL"
fi
