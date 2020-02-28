#!/bin/bash
# Should we offer to re-submit this PR to the development branch?

# we are only doing this for release branches at this time

echo "$1" | grep "^release/" &>/dev/null
exit $?
