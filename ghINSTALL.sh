#!/bin/bash
# Install GITHELP

printf "\nInstall GitHelp?\n"
if [[ -d ~/GitHelp ]]; then
    printf "    Existing installation will be upgraded.\n"
    printf "    GitHelp repository configurations will be preserved.\n"
    printf "    Note:\n"
    printf "      If you are upgrading from a version that is earlier than 1.57\n"
    printf "      you should manually delete the GitHelp lines from ~/.bash_profile\n"
    printf "      before proceeding with this upgrade.\n"
fi
read -p "Are you sure?  (y/n)   " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "\nOperation canceled.\n\n"
    exit 1
fi

if [[ -a ~/.bash_profile ]]; then
    BACKUP_NAME=".bash_profile-"`date '+%Y-%m-%d-%R'`
    cp ~/.bash_profile ~/$BACKUP_NAME
    printf "\nYour current .bash_profile has been backed up to $BACKUP_NAME\n\n"
    sed -i '/=====  GitHelp - START  =====/,/=====  GitHelp - END  =======/d' ~/.bash_profile
    cat GitHelp/bash_profile >> ~/.bash_profile
else
    cp GitHelp/bash_profile ~/.bash_profile
fi

if [[ -d ~/GitHelp ]]; then
    rm -rf ~/GitHelp
fi
cp -rf GitHelp ~/

printf "WARNING:\n    Don't forget to update environment variables by running\n    source ~/.bash_profile\n\n"
