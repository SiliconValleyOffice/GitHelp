#!/bin/bash
# Create a new MISC git branch
# gitNMB

cd $GIT_ROOT

git rev-parse --show-toplevel &> /dev/null
if [ $? -ne 0 ]; then
    printf "\nFATAL ERROR_1:  Not a git repository directory\n\n"
    exit 1;
fi
cd $(git rev-parse --show-toplevel) &> /dev/null

if [ "$#" -lt 1 ]; then
  printf "\nUsage: ghNMB branch_name [upstream_release_branch_number]\n"
  printf "  default upstream_branch = 'development'\n"
  printf "  Create new origin branch from upstream branch.\n\n"
  exit
fi

ORIGIN_BRANCH=${1}

$GITHELP_HOME/ghOriginBranchExists.sh ${ORIGIN_BRANCH}  &> /dev/null
if [[ $? -ne 1 ]] ; then
    printf "\nERROR_2:  The branch named \"${ORIGIN_BRANCH}\" already exists.\n\n"
    exit 1;
fi

if [ $# -eq 2 ]; then
    UPSTREAM_BRANCH=$2
else
    UPSTREAM_BRANCH="development"
fi

$GITHELP_HOME/ghUpstreamBranchExists.sh ${UPSTREAM_BRANCH}  &> /dev/null
if [[ $? -ne 0 ]] ; then
    printf "\nERROR_3:  The branch named \"${UPSTREAM_BRANCH}\" does not exist on the upstream repository.\n\n"
    exit 1;
fi

printf "\nCreate a new Origin tracking branch\n"
printf "    from \"upstream/${UPSTREAM_BRANCH}\"\n"
printf "    named \"$ORIGIN_BRANCH\"\n\n"
printf "    You will be working in the new branch after creation.\n"

read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

$GITHELP_HOME/ghCleanUntrackedFiles.sh

git fetch upstream &> /dev/null
git remote prune upstream &> /dev/null
git checkout upstream/${UPSTREAM_BRANCH} &> /dev/null
git checkout -b ${ORIGIN_BRANCH}
git fetch origin &> /dev/null
git remote prune origin &> /dev/null
git push origin ${ORIGIN_BRANCH} &> /dev/null
echo
git branch -u "origin/${ORIGIN_BRANCH}"

printf "\nLocal branch state:\n"
git branch
printf "\n"
