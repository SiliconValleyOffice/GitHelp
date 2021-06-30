#!/bin/bash
# Validate Ticket ID based on Ticket Type
# Supports ClickUp, GitHub, GitLab, and Jira

TICKET_ID=$1

if [[ $TICKET_TYPE == 'ClickUp' ]]; then
    ALPHANUMERICAL_ID='^[A-Za-z0-9]+$'
    if ! [[ $TICKET_ID =~ $ALPHANUMERICAL_ID ]] ; then
        exit 1
    fi
else  # TICKET_TYPE == GitHub, GitLab or Jira
    NUMERICAL_ID='^[0-9]+$'
    if ! [[ $TICKET_ID =~ $NUMERICAL_ID ]] ; then
        exit 1
    fi
fi

exit 0
