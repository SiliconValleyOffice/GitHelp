#!/bin/bash
# New Pull Request Foreign Repo Misc branch
# alias = ghNPRFRM

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNPRFRM foreign_repo_url misc_branch_name\n"
  printf "    New Pull Request Foreign Repo Misc branch\n"
  printf "    foreign_repo_url example = https://code.mycompany.com/owner/myapp\n\n"
  exit
fi

FOREIGN_REPOSITORY=$1
BRANCH_NAME=$2

git ls-remote --exit-code $FOREIGN_REPOSITORY &> /dev/null
if [ $? -ne 0 ]; then
    printf "\n$FOREIGN_REPOSITORY does not exist.\nOperation canceled.\n\n"
    exit 1
fi

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

CURRENT_BRANCH=`$GITHELP_HOME/ghCurrentBranchName.sh`
if [[ $CURRENT_BRANCH = "development" ]]; then
  printf "\nCannot create a Pull Request for the \"development\" branch on origin.\n"
  printf "    \"origin/development\" is only for review and research of upstream.\n"
  printf "    Create a Derived branch and use that to create a Pull Request.\n\n"
  exit 1
fi

$GITHELP_HOME/ghForeignRepoBranchExists.sh ${FOREIGN_REPOSITORY} ${BRANCH_NAME} &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${BRANCH_NAME}\" does not exist on ${FOREIGN_REPOSITORY}.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghVerifyCleanBranch.sh
if [ $? -ne 0 ] ; then
    exit 1;
fi

printf "Create a Pull Request (PR) from the origin branch \"$CURRENT_BRANCH\"\n into the foreign branch \"${BRANCH_NAME}\"?\n"
printf "    Note:  If you are not already logged into GitHub in the browser,\n           do that before proceeding.\n"
read -p "Continue?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "\n"
# ToDo - provide option to collapse commits into a single, and provide a message for that commit
UPSTREAM_URL="$(git config --get remote.upstream.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//')/compare/${UPSTREAM_BRANCH}...${GITHUB_USER}:${CURRENT_BRANCH}?expand=1"
if which google-chrome > /dev/null ; then
  google-chrome "$UPSTREAM_URL"
else
  open "$UPSTREAM_URL"
fi

printf "\nBe sure to review changed files in PR before clicking button to create.\n\n"
