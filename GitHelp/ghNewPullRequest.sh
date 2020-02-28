#!/bin/bash
# Create a Pull Request
# alias = ghNPR

if [ "$#" -ne 1 ]; then
  printf "\nUsage: ghNPR [upstream_branch]\n"
  printf "    create a Pull Request for the current branch\n"
  printf "    into the upstream_branch\n\n"
  exit
fi
UPSTREAM_BRANCH=$1

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

$GITHELP_HOME/ghIsGitLab.sh
IS_GITLAB=$?

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

$GITHELP_HOME/ghUpstreamBranchExists.sh ${UPSTREAM_BRANCH} &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR:  The branch named \"${UPSTREAM_BRANCH}\" does not exist on the upstream repository.\n\n"
    exit 1;
fi

MERGE_RESULTS="$(git merge upstream/${UPSTREAM_BRANCH})"
if [[ "$MERGE_RESULTS"  != *"lready up"* ]] ; then
  git push
  MERGE_RESULTS="$(git merge upstream/${UPSTREAM_BRANCH})"
  if [[ "$MERGE_RESULTS"  != *"lready up"* ]] ; then
      printf "\nERROR:  \"${CURRENT_BRANCH}\" branch is not "up-to-date" with upstream/${UPSTREAM_BRANCH}.\n"
      printf "    Run \"ghUBUB ${UPSTREAM_BRANCH}\" and try again.\n\n"
      exit 1;
  fi
fi

printf "\nLocal branch \"$CURRENT_BRANCH\" has no local changes\nand is up-to-date with upstream branch \"${UPSTREAM_BRANCH}\".\n\n"

$GITHELP_HOME/ghStaticAnalysis.sh
if [ $? -ne 0 ] ; then
printf "\nFATAL ERROR:  You must fix errors before creating a PR.\n"
printf "\nOperation canceled.\n\n"
exit 1
fi

printf "Create a Pull Request (PR) from the origin branch \"$CURRENT_BRANCH\"\n"
printf "into the upstream branch \"${UPSTREAM_BRANCH}\"?\n"
printf "    Note:  If you are not already logged into GitHub in the browser,\n"
printf "           do that before proceeding.\n"
read -p "Continue?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

printf "\n"
# ToDo - provide option to collapse commits into a single, and provide a message for that commit
if [ $IS_GITLAB -eq 0 ]; then
    UPSTREAM_URL=`$GITHELP_HOME/ghGitLabMergeRequestUrl.sh $UPSTREAM_BRANCH`
else
    UPSTREAM_URL=`$GITHELP_HOME/ghGitHubMergeRequestUrl.sh $UPSTREAM_BRANCH`
fi

if which google-chrome > /dev/null ; then
  google-chrome "$UPSTREAM_URL"
else
  open "$UPSTREAM_URL"
fi

printf "\nBe sure to review changed files in Pull/Merge Request before clicking button to create.\n\n"

git push &>/dev/null

$GITHELP_HOME/ghReSubmitToDevelopment.sh $UPSTTREAM_BRANCH
if [ $? -eq 0 ] ; then
  printf "\nDo you also want to submit a PR against \"upstream\\development\"?\n"
  read -p "Continue?  (y/n)   " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
      exit 1
  fi
  $GITHELP_HOME/ghNewPullRequest.sh development
fi
