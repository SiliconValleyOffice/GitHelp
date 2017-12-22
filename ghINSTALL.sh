#!/bin/bash
# Install GITHELP

if [[ -d ~/GitHelp ]]; then
    CURRENT_VERSION=`~/GitHelp/ghVERSION.sh`
    NEW_VERSION=`./GitHelp/ghVERSION.sh`
    printf "\nUpgrade GitHelp?\n"
    printf "    From $CURRENT_VERSION\n"
    printf "    To $NEW_VERSION\n\n"
    printf "    GitHelp repository configurations will be preserved.\n"
else
    printf "\nInstall GitHelp?\n"
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
    cat ~/$BACKUP_NAME | sed '/#=====  GitHelp - START  =====/,$d' > ~/.bash_profile
    cat GitHelp/bash_profile >> ~/.bash_profile
else
    cp GitHelp/bash_profile ~/.bash_profile
fi

if [[ -d ~/GitHelp ]]; then
    rm -rf ~/GitHelp
fi
cp -rf GitHelp ~/

printf "WARNING:\n    Close all existing bash windows and reopen.\n\n"
