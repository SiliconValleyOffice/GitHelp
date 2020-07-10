#!/bin/bash
# Validate SSH for both GitHub and GitLab

SSH_HOST=$1

SSH_OUTPUT=`ssh -T $SSH_HOST 2>&1`
SSH_RESULT=$?

echo $SSH_OUTPUT | grep "successfully authenticated" &>/dev/null
SUCCESS_MESSAGE=$?

if [ $SUCCESS_MESSAGE -eq 0 ] ; then
    exit 0
else
    exit $SSH_RESULT
fi
