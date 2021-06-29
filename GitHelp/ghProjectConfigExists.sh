#!/bin/bash
# Project config file exists and has non-whitespace

CONFIG_FILE=$1
[[ -f "$CONFIG_FILE" ]] && grep -q '[^[:space:]]' "$CONFIG_FILE"