#!/bin/bash
# Create a Pull Request
# alias = ghNPR

if [ "$#" -gt 1 ]; then
  printf "\nUsage: ghNPR [upstream_release_branch_number]\n"
  printf "    create a Pull Request for the current branch\n"
  printf "    default upstream_branch = development\n\n"
  exit
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

$GITHELP_HOME/ghOriginBranchExists.sh ${CURRENT_BRANCH} &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${CURRENT_BRANCH}\" does not exist on origin.\n\n"
    exit 1;
fi

$GITHELP_HOME/ghVerifyCleanBranch.sh
if [ $? -ne 0 ] ; then
    exit 1;
fi

IS_DEVELOPMENT_BRANCH="YES"
if [ $# -eq 1 ]; then
    IS_DEVELOPMENT_BRANCH="NO"
    UPSTREAM_BRANCH=`$1`
else
    UPSTREAM_BRANCH="development"
fi

$GITHELP_HOME/ghUpstreamBranchExists.sh ${UPSTREAM_BRANCH} &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${UPSTREAM_BRANCH}\" does not exist on the upstream repository.\n\n"
    exit 1;
fi

MERGE_RESULTS="$(git merge upstream/${UPSTREAM_BRANCH})"
if [[ "$MERGE_RESULTS"  != *"Already up-to-date"* ]] ; then
  git push
  MERGE_RESULTS="$(git merge upstream/${UPSTREAM_BRANCH})"
  if [[ "$MERGE_RESULTS"  != *"Already up-to-date"* ]] ; then
      printf "\nERROR:  \"${CURRENT_BRANCH}\" branch is not "up-to-date" with upstream/${UPSTREAM_BRANCH}.\n"
      printf "    Run \"ghUBUB ${UPSTREAM_BRANCH}\" and try again.\n\n"
      exit 1;
  fi
fi

printf "\nLocal branch \"$CURRENT_BRANCH\" has no local changes\nand is up-to-date with upstream branch \"${UPSTREAM_BRANCH}\".\n\n"
printf "Create a Pull Request (PR) from the origin branch \"$CURRENT_BRANCH\"\n into the upstream branch \"${UPSTREAM_BRANCH}\"?\n"
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

git push &>/dev/null

if [[ "$IS_DEVELOPMENT_BRANCH" == "NO" ]] ; then
  printf "\nDo you also want to submit a PR against \"upstream\\development\"?\n"
  read -p "Continue?  (y/n)   " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
      exit 1
  fi
  $GITHELP_HOME/ghNewPullRequestForDevelopment.sh
fi
