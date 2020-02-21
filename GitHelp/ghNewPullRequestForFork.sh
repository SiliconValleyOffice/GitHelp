#!/bin/bash
# New Pull Request for a Release branch
# alias = ghNPRF

if [ "$#" -ne 2 ]; then
  printf "\nUsage: ghNPRF git_user_name branch_name\n"
  printf "    git_user_id = owner of the Fork\n\n"
  printf "    New Pull Request for the current branch\n"
  printf "    against a branch in another Fork.\n\n"
  exit
fi

FORK_OWNER=$1
FORK_BRANCH=$2

GITHUB_USER_TO_LOWER=`echo $GITHUB_USER | tr '[:upper:]' '[:lower:]'`

DEV_FORK=`git config --get remote.origin.url | tr '[:upper:]' '[:lower:]' | sed "s/$GITHUB_USER_TO_LOWER/$FORK_OWNER/"`

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

$GITHELP_HOME/ghOriginBranchExists.sh ${CURRENT_BRANCH} &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${CURRENT_BRANCH}\" does not exist on origin.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghVerifyCleanBranch.sh
if [ $? -ne 0 ] ; then
    exit 1;
fi

if [[ `git remote` != *"$FORK_OWNER"* ]] ; then
    printf "\nCreating a remote for \"$FORK_OWNER\"\n"
    git remote add $FORK_OWNER $DEV_FORK
fi

$GITHELP_HOME/ghForkBranchExists.sh ${FORK_OWNER} ${FORK_BRANCH}
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${FORK_BRANCH}\" does not exist on the fork owned by \"${FORK_OWNER}\".\n\n"
    exit 1;
fi

MERGE_RESULTS="$(git merge ${FORK_OWNER}/${FORK_BRANCH})"
if [[ "$MERGE_RESULTS"  != *"lready up"* ]] ; then
    printf "\nERROR:  \"${CURRENT_BRANCH}\" branch is not "up-to-date" with ${FORK_OWNER}/${FORK_BRANCH}.\n"
    printf "    Run \"ghUBFB ${FORK_OWNER} ${FORK_BRANCH}\" and try again.\n\n"
    exit 1;
fi

printf "\nBranch named \"$CURRENT_BRANCH\" has no local changes\nand is up-to-date with \"${FORK_OWNER}\\${FORK_BRANCH}\".\n\n"

$GITHELP_HOME/ghStaticAnalysis.sh
if [ $? -ne 0 ] ; then
    printf "\nFATAL ERROR:  You must fix errors before creating a PR.\n"
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "Create a Pull Request (PR) from origin branch named \"$CURRENT_BRANCH\"\ninto branch named \"$FORK_BRANCH\" in Fork \"${FORK_OWNER}\".\n"
printf "    Note:  If you are not already logged into GitHub in the browser,\n           do that before proceeding.\n"
read -p "Continue?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "\n"

UPSTREAM_URL="$(git config --get remote.$FORK_OWNER.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//')/compare/${FORK_BRANCH}...${GITHUB_USER}:${CURRENT_BRANCH}?expand=1"
if which google-chrome > /dev/null
then
  google-chrome "$UPSTREAM_URL"
else
  open "$UPSTREAM_URL"
fi

printf "\nBe sure to review changed files in PR before clicking button to create.\n\n"
