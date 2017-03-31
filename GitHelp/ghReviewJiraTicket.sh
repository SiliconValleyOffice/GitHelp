#!/bin/bash
# Review JIRA Ticket
# alias = ghRJT

if [ "$#" -gt 1 ]; then
    printf "\nUSAGE:  ghRJT [ticket_number]\n"
    printf "    default ticket_number = current JIRA branch.\n"
    printf "    current JIRA prefix = $JIRA_TICKET_PREFIX\n\n"
    exit 1;
fi

if [ $# -eq 0 ]; then
  BRANCH_NAME=`$GITHELP_HOME/ghCurrentBranchName.sh`
  REGULAR_EXPRESSION="${JIRA_TICKET_PREFIX}*"
  if ! [[ "$BRANCH_NAME" =~ $REGULAR_EXPRESSION ]] ; then
      printf "\n    ERROR: This is not a JIRA branch.\n\n"
      exit 1
  fi
  JIRA_TICKET=$BRANCH_NAME
fi

if [ $# -eq 1 ]; then
    REGULAR_EXPRESSION='^[0-9]+$'
    if ! [[ $1 =~ $REGULAR_EXPRESSION ]] ; then
        printf "\n    ERROR: Argument is not a JIRA number.\n\n"
        exit 1
    fi
    JIRA_TICKET="${JIRA_TICKET_PREFIX}-$1"
fi

printf "\nJIRA Ticket = $JIRA_TICKET\n\n"

JIRA_URL="https://breakthrough.atlassian.net/browse/${JIRA_TICKET}"

if which google-chrome > /dev/null
then
  google-chrome "$JIRA_URL"
else
  open "$JIRA_URL"
fi

printf "\n"
