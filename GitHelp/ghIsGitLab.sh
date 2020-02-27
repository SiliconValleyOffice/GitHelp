#!/bin/bash
# Is a GitHub repository

git config --get remote.upstream.url | grep "gitlab" 1>/dev/null 2>&1

