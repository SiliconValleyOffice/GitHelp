#!/bin/bash
# Review Pull Requests for Upstream
# alias ghRPRU

UPSTREAM_URL=`git config --get remote.upstream.url | sed 's/\.git/\/pulls/' `

if which google-chrome > /dev/null
then
    google-chrome "$UPSTREAM_URL"
else
    open "$GITHUB_URL"
fi
