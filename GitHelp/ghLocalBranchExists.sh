#!/bin/bash

cd "$GIT_ROOT"

if [ "$#" -lt 1 ]; then
  exit 1
fi

if [[ `git branch` != *"${1}"* ]] ; then
    exit 1;
fi
