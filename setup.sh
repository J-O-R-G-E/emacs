#!/bin/bash
#By Jorge Cardona

# This file is to set up the required directories and files
# to allow emacs to act as an IDE

_EMACS=$HOME/.emacs
_EMACS_DIR=$HOME/.emacs.d
_EFILE=pkg
BACKUP_DIR=$HOME/.originalEmacsFiles.d


# Check if we have $HOME/.emacs file
if [ -e "$_EMACS" ]
then
    echo ".emacs File Exists..."
    sleep 2

    echo "Creating: $BACKUP_DIR"
    sleep 2
    mkdir $BACKUP_DIR

    echo "Backing up files to: $BACKUP_DIR"
    sleep 2
    cp $_EMACS $BACKUP_DIR/

    echo "Making Changes Needed..."
    sleep 2
    
    cat $_EFILE > $_EMACS  # Now lets overide the file
    echo "Done..."
    sleep 2
    
else
    
    echo "File Does Not Exists..."
    sleep 2

    echo "Creating .emacs File..."
    sleep 2

    touch $_EMACS
    
    echo "Making Changes Needed..."
    sleep 2
    cat $_EFILE > $_EMACS
    
    echo "Done..."
    sleep 2
    
fi

if [ -d "$_EMACS_DIR" ]
then
    echo "Directory .emacs.d Exist..."
    sleep 2

    echo "Backing up files to: $BACKUP_DIR"
    sleep 2
    cp -R $_EMACS_DIR/* $BACKUP_DIR/

    
    echo "Making Changes Needed..."
    sleep 2
    cp -R snipets  $_EMACS_DIR/
    
    echo "Done..."
    sleep 2

else
    echo "Directory .emacs.d  Does Not Exist..."
    sleep 2

    emacs "Creating: $_EMACS_DIR"
    sleep 2
    mkdir -p $_EMACS_DIR

    echo "Making Changes Needed..."
    sleep 2
    cp -R snippets $_EMACS_DIR
    
    echo "Done..."
    sleep 2
fi

echo -e  "Setup Completed!"
sleep 1

exit
