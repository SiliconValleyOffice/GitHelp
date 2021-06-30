#!/bin/bash
# Review Ticket
# alias = ghRT

if [ "$#" -gt 1 ]; then
    printf "\nUSAGE:  ghRT [ticket_id]\n"
    printf "    default ticket_id = current ticket branch.\n"
    printf "    current ticket prefix = $TICKET_PREFIX\n\n"
    exit 1;
fi

if [ $# -eq 0 ]; then
  BRANCH_NAME=`$GITHELP_HOME/ghCurrentBranchName.sh`
  REGULAR_EXPRESSION="${TICKET_PREFIX}*"
  if ! [[ "$BRANCH_NAME" =~ $REGULAR_EXPRESSION ]] ; then
      printf "\n    ERROR: This is not a ticket branch.\n\n"
      exit 1
  fi
  TICKET_ID=`echo $BRANCH_NAME | sed "s/${TICKET_PREFIX}-//"`
else
  TICKET_ID=$1

  $GITHELP_HOME/ghValidateTicketId.sh $TICKET_ID
  IS_VALID_TICKET_ID=$?

  if ! [[ $IS_VALID_TICKET_ID -eq 0 ]] ; then
      printf "\n    ERROR: Argument is not a valid $TICKET_TYPE ticket ID.\n\n"
      exit 1
  fi
fi

# Jira is only ticket type with a different url format
if [[ $TICKET_TYPE == 'Jira' ]]; then
  TICKET_URL="${TICKET_BASE_URL}${TICKET_PREFIX}-${TICKET_ID}"
else
  TICKET_URL="${TICKET_BASE_URL}${TICKET_ID}"
fi

if which google-chrome > /dev/null
then
  google-chrome "$TICKET_URL"
else
  open "$TICKET_URL"
fi

printf "\n"
