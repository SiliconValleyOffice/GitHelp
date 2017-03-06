#!/bin/bash
# Display help for git aliases

GITHELP_VERSION=`$GITHELP_HOME/ghVERSION.sh`
printf "\n$GITHELP_VERSION\n"

if [ "$1" == "-s" ]; then
    printf "gitHELP Silent commands:\n"
    printf "$HELP_MESSAGE    ghSBP  -  Save Bash Profile\n"
    printf "$HELP_MESSAGE    ghCGR  -  Copy GitHelp to Repo\n\n"
    printf "$HELP_MESSAGE    ghCUR  -  Clone Upstream Repo (not a Fork)\n\n"
    exit
fi

${GITHELP_HOME}/ghCONFIG.sh

if [ "$1" == "-x" ]; then
    printf "gitHELP eXtended command list:\n"
    printf "$HELP_MESSAGE    gh        -  This help message\n"
    printf "$HELP_MESSAGE    ghROOT    -  cd \$GIT_ROOT\n"
    printf "$HELP_MESSAGE    ghCONFIG  -  git Configuration\n"
    printf "$HELP_MESSAGE    ghEDITOR  -  Default editor configuration for git\n"
    printf "$HELP_MESSAGE    ghVERSION -  GitHelp Version\n"
    printf "$HELP_MESSAGE    ======= Convenience Commands ========================\n"
    printf "$HELP_MESSAGE    ghAA      -  git Add All\n"
    printf "$HELP_MESSAGE    ghB       -  git Branch\n"
    printf "$HELP_MESSAGE    ghCD      -  Checkout Development\n"
    printf "$HELP_MESSAGE    ghCM      -  Commit with Message\n"
    printf "$HELP_MESSAGE    ghL       -  git Log\n"
    printf "$HELP_MESSAGE    ghLRA     -  Lint Report for Android\n"
    printf "$HELP_MESSAGE    ghP       -  git Push\n"
    printf "$HELP_MESSAGE    ghS       -  git Status\n"
    printf "$HELP_MESSAGE    ======= A ======  Create / Destroy Misc Branches ====\n"
    printf "$HELP_MESSAGE    ghNMB     -  create New Misc Branch (not for a JIRA ticket)\n"
    printf "$HELP_MESSAGE    ghNDMB    -  create New Derived Misc Branch\n"
    printf "$HELP_MESSAGE    ghDCB     -  Destroy Current Branch\n"
    printf "$HELP_MESSAGE    ghDMB     -  Destroy Miscellaneous Branch\n"
    printf "$HELP_MESSAGE    ======= B =========  JIRA Tickets  ==================\n"
    printf "$HELP_MESSAGE    ghNJB     -  create New JIRA Branch\n"
    printf "$HELP_MESSAGE    ghNDJB    -  create New Derived JIRA Branch\n"
    printf "$HELP_MESSAGE    ghRJT     -  Review JIRA Ticket\n"
    printf "$HELP_MESSAGE    ghCJB     -  Checkout JIRA Branch (from origin)\n"
    printf "$HELP_MESSAGE    ghDJB     -  Destroy JIRA Branch\n"
    printf "$HELP_MESSAGE    ======= C =========  Update Branch  =================\n"
    printf "$HELP_MESSAGE    ghUBUD    -  Update current Branch with Upstream Development\n"
    printf "$HELP_MESSAGE    ghUBUR    -  Update current Branch with Upstream Release Branch\n"
    printf "$HELP_MESSAGE    ghRSHA    -  Revert current branch to SHA\n"
    printf "$HELP_MESSAGE    ghLMC     -  List Merge Conflicts\n"
    printf "$HELP_MESSAGE    ======= D =========  Pull Requests  =================\n"
    printf "$HELP_MESSAGE    ghNPRD    -  New Pull Request (PR) for the upstream Development branch\n"
    printf "$HELP_MESSAGE    ghNPRR    -  New Pull Request (PR) for an upstream Release branch\n"
    printf "$HELP_MESSAGE    ghNPRF    -  New Pull Request (PR) for a Fork branch\n"
    printf "$HELP_MESSAGE    ghRPRU    -  Review Pull Requests for upstream\n"
    printf "$HELP_MESSAGE    ghRPRF    -  Review Pull Requests for a Fork\n"
    printf "$HELP_MESSAGE    ghFPRB    -  Fetch a Pull Request Branch\n"
    printf "$HELP_MESSAGE    ======= E =========  Branches  ======================\n"
    printf "$HELP_MESSAGE    ghLOB     -  List Origin Branches\n"
    printf "$HELP_MESSAGE    ghFOB     -  Fetch Origin Branch\n"
    printf "$HELP_MESSAGE    ghLUB     -  List Upstream Branches\n"
    printf "$HELP_MESSAGE    ghLRB     -  List Release Branches\n"
    printf "$HELP_MESSAGE    ======= F =========  Forks (not yours)  =============\n"
    printf "$HELP_MESSAGE    ghLFB     -  List Fork Branches\n"
    printf "$HELP_MESSAGE    ghFFJB    -  Fetch Fork JIRA Branch\n"
    printf "$HELP_MESSAGE    ghFFMB    -  Fetch Fork Misc Branch\n"
    printf "$HELP_MESSAGE    ghUBFB    -  Update current Branch with Fork Branch\n"
    printf "$HELP_MESSAGE    ======= G =========  Clean  =========================\n"
    printf "$HELP_MESSAGE    ghCUF     -  Clean Untracked Files\n"
    printf "$HELP_MESSAGE    ghCUCB    -  Clean Untracked files and Checkout Branch\n"
    printf "$HELP_MESSAGE    ghSCDC    -  Stash Changes and Drop and Clean\n"
    printf "$HELP_MESSAGE    ======= H =========  Misc Updates  ==================\n"
    printf "$HELP_MESSAGE    ghCMTF    -  Commit Modified Tracked Files in the current branch\n"
    printf "$HELP_MESSAGE    ghCPOB    -  Cherry Pick sha from Origin Branch into the current branch\n"
    printf "$HELP_MESSAGE    ghLMC     -  List Merge Conflicts\n"
    printf "$HELP_MESSAGE    ======= J =========  SHAs  ==========================\n"
    printf "$HELP_MESSAGE    ghRSHA    -  Revert current branch to SHA\n"
    printf "$HELP_MESSAGE    ghCPOB    -  Cherry Pick sha from Origin Branch into the current branch\n"
    printf "$HELP_MESSAGE    ======= K =========  Wiki  ==========================\n"
    printf "$HELP_MESSAGE    ghCW      -  Clone Wiki\n"
    printf "$HELP_MESSAGE    ghPW      -  Pull latest files from Wiki\n"
    printf "$HELP_MESSAGE    ghUW      -  Update Wiki with local changes\n"
    printf "$HELP_MESSAGE    ======= M =========  Maintenance  ===================\n"
    printf "$HELP_MESSAGE    ghREMOTE  -  List verbose remote definitions\n"
    printf "$HELP_MESSAGE    ghDLBNOO  -  Delete Local Branches Not On Origin\n"
    printf "$HELP_MESSAGE    ghDAOBED  -  Destroy All Origin Branches Except Development\n"
    printf "$HELP_MESSAGE    ghDOBNOL  -  Destroy Origin Branches Not On Local, Except Development\n"
    printf "$HELP_MESSAGE    ghCF      -  Clone Fork\n"
else
    printf "gitHELP frequently used commands:\n"
    printf "$HELP_MESSAGE    gh        -  This help message\n"
    printf "$HELP_MESSAGE    ghROOT    -  cd \$GIT_ROOT\n"
    printf "$HELP_MESSAGE    ghCONFIG  -  git Configuration\n"
    printf "$HELP_MESSAGE    ghEDITOR  -  Default editor configuration for git\n"
    printf "$HELP_MESSAGE    ghVERSION -  GitHelp Version\n"
    printf "$HELP_MESSAGE    ======= Convenience Commands ========================\n"
    printf "$HELP_MESSAGE    ghAA      -  git Add All\n"
    printf "$HELP_MESSAGE    ghB       -  git Branch\n"
    printf "$HELP_MESSAGE    ghCD      -  Checkout Development\n"
    printf "$HELP_MESSAGE    ghCM      -  Commit with Message\n"
    printf "$HELP_MESSAGE    ghL       -  git Log\n"
    printf "$HELP_MESSAGE    ghLRA     -  Lint Report for Android\n"
    printf "$HELP_MESSAGE    ghP       -  git Push\n"
    printf "$HELP_MESSAGE    ghS       -  git Status\n"
    printf "$HELP_MESSAGE    ======= A ======  Create / Destroy Misc Branches ====\n"
    printf "$HELP_MESSAGE    ghNMB     -  create New Misc Branch (not for a JIRA ticket)\n"
    printf "$HELP_MESSAGE    ghNDMB    -  create New Derived Misc Branch\n"
    printf "$HELP_MESSAGE    ghDCB     -  Destroy Current Branch\n"
    printf "$HELP_MESSAGE    ghDMB     -  Destroy Miscellaneous Branch\n"
    printf "$HELP_MESSAGE    ======= B =========  JIRA Tickets  ==================\n"
    printf "$HELP_MESSAGE    ghNJB     -  create New JIRA Branch\n"
    printf "$HELP_MESSAGE    ghNDJB    -  create New Derived JIRA Branch\n"
    printf "$HELP_MESSAGE    ghRJT     -  Review JIRA Ticket\n"
    printf "$HELP_MESSAGE    ghCJB     -  Checkout JIRA Branch\n"
    printf "$HELP_MESSAGE    ghDJB     -  Destroy JIRA Branch\n"
    printf "$HELP_MESSAGE    ======= C =========  Update Branch  =================\n"
    printf "$HELP_MESSAGE    ghUBUD    -  Update current Branch with Upstream Development\n"
    printf "$HELP_MESSAGE    ghUBUR    -  Update current Branch with Upstream Release\n"
    printf "$HELP_MESSAGE    ghRSHA    -  Revert current branch to SHA\n"
    printf "$HELP_MESSAGE    ghLMC     -  List Merge Conflicts\n"
    printf "$HELP_MESSAGE    ======= D =========  Pull Requests  =================\n"
    printf "$HELP_MESSAGE    ghNPRD    -  New Pull Request (PR) for the upstream Development branch\n"
    printf "$HELP_MESSAGE    ghNPRR    -  New Pull Request (PR) for an upstream Release branch\n"
    printf "$HELP_MESSAGE    ghNPRF    -  New Pull Request (PR) for a Fork branch\n"
    printf "$HELP_MESSAGE    ghRPR     -  Review Pull Request in upstream\n"
    printf "$HELP_MESSAGE    ghRPRF    -  Review Pull Requests for a Fork\n"
    printf "$HELP_MESSAGE    ghFPRB    -  Fetch a Pull Request Branch\n"
    printf "$HELP_MESSAGE    ======= E =========  List Branches  =================\n"
    printf "$HELP_MESSAGE    ghLOB     -  List Origin Branches\n"
    printf "$HELP_MESSAGE    ghFOB     -  Fetch Origin Branch\n"
    printf "$HELP_MESSAGE    ghLUB     -  List Upstream Branches\n"
    printf "$HELP_MESSAGE    ghLRB     -  List Release Branches\n"
    printf "$HELP_MESSAGE    ======= F =========  Forks (not yours)  =============\n"
    printf "$HELP_MESSAGE    ghLFB     -  List Fork Branches\n"
    printf "$HELP_MESSAGE    ghFFJB    -  Fetch Fork JIRA Branch\n"
    printf "$HELP_MESSAGE    ghFFMB    -  Fetch Fork Misc Branch\n"
    printf "$HELP_MESSAGE    ghUBFB    -  Update current Branch with Fork Branch\n"
fi

printf "$HELP_MESSAGE\n"

printf "$GITHELP_VERSION\n\n"